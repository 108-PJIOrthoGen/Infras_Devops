-- Backfill image_results.bucket and image_results.object_key from legacy presigned URLs
-- stored inside file_metadata. Safe to re-run; only updates rows where bucket/object_key
-- are NULL.
--
-- Expected URL shape:
--   http://host:port/<bucket>/<object_key>?X-Amz-...
--
-- Assumptions about file_metadata structure (adjust if the JSON shape differs):
--   - It is a JSON object stored as jsonb
--   - Has a "url" field whose value is the presigned URL
--
-- For any other shape, this script no-ops on that row and you can fix manually.
--
-- After this script runs, future reads will regenerate a fresh presigned URL using the
-- current MinIO endpoint, so the localhost:9000 URLs become irrelevant.

DO $$
BEGIN
    -- Ensure the columns exist (Hibernate ddl-auto adds them on app boot, but if this script
    -- runs before app boot we add them here so the UPDATE below can target them).
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'image_results' AND column_name = 'bucket'
    ) THEN
        ALTER TABLE image_results ADD COLUMN bucket varchar(200);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'image_results' AND column_name = 'object_key'
    ) THEN
        ALTER TABLE image_results ADD COLUMN object_key varchar(500);
    END IF;
END$$;

-- Backfill from JSON shape: { "url": "http://host:port/<bucket>/<object_key>?..." }
UPDATE image_results
SET
    bucket = COALESCE(
        bucket,
        (regexp_match(file_metadata->>'url', '^https?://[^/]+/([^/?]+)/'))[1]
    ),
    object_key = COALESCE(
        object_key,
        (regexp_match(file_metadata->>'url', '^https?://[^/]+/[^/]+/([^?]+)'))[1]
    )
WHERE (bucket IS NULL OR object_key IS NULL)
  AND file_metadata IS NOT NULL
  AND file_metadata::text ~ '"url"\s*:\s*"https?://';

-- Optional second pass: some frontends may store the URL as the entire metadata value
-- (string, not an object). Uncomment if applicable to your data.
-- UPDATE image_results
-- SET
--     bucket = COALESCE(bucket, (regexp_match(file_metadata::text, '^"https?://[^/]+/([^/?]+)/'))[1]),
--     object_key = COALESCE(object_key, (regexp_match(file_metadata::text, '^"https?://[^/]+/[^/]+/([^?]+)'))[1])
-- WHERE bucket IS NULL AND file_metadata::text ~ '^"https?://';
