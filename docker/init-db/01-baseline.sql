--
-- PostgreSQL database dump
--

\restrict sFFT4zuTQaH2jZygNTYftj7qiNLcRK0CGoixckgj3NbHQxJBgc6QYafSVo6sh9C

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: ai_run_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ai_run_status AS ENUM (
    'SUCCESS',
    'FAILED',
    'PARTIAL',
    'QUEUED',
    'PROCESSING',
    'TIMEOUT'
);


--
-- Name: ai_run_trigger_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ai_run_trigger_type AS ENUM (
    'MANUAL_GENERATE',
    'AUTO_REFRESH',
    'DATA_CHANGED',
    'DOCTOR_REQUEST',
    'REVIEW_REQUEST'
);


--
-- Name: culturestatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.culturestatus AS ENUM (
    'CONTAMINATED',
    'FINAL_NEGATIVE',
    'NOT_PERFORMED',
    'NO_GROWTH',
    'PENDING',
    'POSITIVE'
);


--
-- Name: direct_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.direct_enum AS ENUM (
    'CC',
    'KKB',
    'KDT'
);


--
-- Name: gender_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gender_type AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


--
-- Name: genderenum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.genderenum AS ENUM (
    'FEMALE',
    'MALE',
    'OTHER'
);


--
-- Name: implant_stability_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.implant_stability_type AS ENUM (
    'STABLE',
    'POSSIBLY_LOOSE',
    'LOOSE',
    'UNKNOWN'
);


--
-- Name: implanttype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.implanttype AS ENUM (
    'LOOSE',
    'POSSIBLY_LOOSE',
    'STABLE',
    'UNKNOWN'
);


--
-- Name: infection_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.infection_type AS ENUM (
    'EARLY_POSTOPERATIVE',
    'DELAYED',
    'LATE_HEMATOGENOUS',
    'ACUTE_HEMATOGENOUS',
    'CHRONIC',
    'UNKNOWN'
);


--
-- Name: infectiontype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.infectiontype AS ENUM (
    'ACUTE_HEMATOGENOUS',
    'CHRONIC',
    'DELAYED',
    'EARLY_POSTOPERATIVE',
    'LATE_HEMATOGENOUS',
    'UNKNOWN'
);


--
-- Name: recommendation_item_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.recommendation_item_category AS ENUM (
    'DIAGNOSTIC_TEST',
    'SYSTEMIC_ANTIBIOTIC',
    'LOCAL_ANTIBIOTIC',
    'SURGERY_PROCEDURE'
);


--
-- Name: review_status_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.review_status_type AS ENUM (
    'ACCEPTED',
    'MODIFIED',
    'REJECTED',
    'SAVED_DRAFT'
);


--
-- Name: sample_result_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sample_result_status AS ENUM (
    'NOT_PERFORMED',
    'PENDING',
    'NO_GROWTH',
    'POSITIVE',
    'CONTAMINATED',
    'FINAL_NEGATIVE'
);


--
-- Name: treatment_plan_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.treatment_plan_status AS ENUM (
    'DRAFT',
    'CONFIRMED',
    'SUPERSEDED',
    'CANCELLED'
);


--
-- Name: userstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.userstatus AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'NONE'
);


--
-- Name: CAST (public.culturestatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.culturestatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.genderenum AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.genderenum AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.implanttype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.implanttype AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.infectiontype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.infectiontype AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.userstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.userstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.culturestatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.culturestatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.genderenum); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.genderenum) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.implanttype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.implanttype) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.infectiontype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.infectiontype) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.userstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.userstatus) WITH INOUT AS IMPLICIT;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ai_chat_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_chat_messages (
    id bigint NOT NULL,
    session_id bigint,
    role character varying(20),
    content text NOT NULL,
    tokens_used integer,
    context_json jsonb,
    latency_ms bigint,
    references_json jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    updated_at timestamp without time zone,
    created_by character varying(255)
);


--
-- Name: ai_chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ai_chat_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ai_chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ai_chat_messages_id_seq OWNED BY public.ai_chat_messages.id;


--
-- Name: ai_chat_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_chat_sessions (
    id bigint NOT NULL,
    run_id bigint,
    current_item_id bigint,
    chat_type character varying(30),
    episode_id bigint,
    title character varying(500),
    is_archived boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    updated_at timestamp without time zone,
    created_by character varying(255)
);


--
-- Name: ai_chat_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ai_chat_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ai_chat_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ai_chat_sessions_id_seq OWNED BY public.ai_chat_sessions.id;


--
-- Name: ai_rag_citations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_rag_citations (
    id bigint NOT NULL,
    run_id bigint NOT NULL,
    item_id bigint,
    source_type character varying(30),
    source_title character varying(500),
    source_uri character varying(1000),
    snippet text,
    relevance_score numeric(5,4),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cited_for character varying(500),
    updated_by character varying(255),
    updated_at timestamp without time zone,
    created_by character varying(255)
);


--
-- Name: ai_rag_citations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ai_rag_citations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ai_rag_citations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ai_recommendation_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_recommendation_items (
    id bigint NOT NULL,
    run_id bigint NOT NULL,
    category character varying(30) NOT NULL,
    title character varying(500) NOT NULL,
    priority_order integer DEFAULT 1 NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    item_json jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by character varying(255),
    updated_at timestamp without time zone,
    created_by character varying(255)
);


--
-- Name: ai_recommendation_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ai_recommendation_items ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ai_recommendation_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ai_recommendation_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_recommendation_runs (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    snapshot_id bigint NOT NULL,
    run_no integer NOT NULL,
    trigger_type character varying(30) NOT NULL,
    status character varying(20) DEFAULT 'SUCCESS'::public.ai_run_status NOT NULL,
    model_name character varying(100),
    model_version character varying(50),
    assessment_json jsonb,
    explanation_json jsonb,
    warnings_json jsonb,
    latency_ms bigint,
    error_message text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    request_id character varying(255),
    updated_by character varying(255),
    updated_at timestamp without time zone,
    created_by character varying(255),
    data_completeness_json jsonb
);


--
-- Name: ai_recommendation_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ai_recommendation_runs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ai_recommendation_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: case_clinical_snapshots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.case_clinical_snapshots (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    snapshot_no integer NOT NULL,
    snapshot_data_json jsonb NOT NULL,
    data_completeness_score numeric(5,2),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by character varying(255),
    updated_at timestamp without time zone,
    created_by character varying(255)
);


--
-- Name: case_clinical_snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.case_clinical_snapshots ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.case_clinical_snapshots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: clinical_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clinical_records (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    recorded_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    illness_onset_date date,
    blood_pressure character varying(20),
    bmi numeric(4,2),
    fever boolean,
    pain boolean,
    erythema boolean,
    swelling boolean,
    sinus_tract boolean,
    suspected_infection_type public.infection_type NOT NULL,
    hematogenous_suspected boolean,
    implant_stability character varying(50) NOT NULL,
    soft_tissue character varying(255),
    pmma_allergy boolean,
    prosthesis_joint character varying(255),
    days_since_index_arthroplasty integer,
    notations text,
    created_by character varying(255) NOT NULL,
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: clinical_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clinical_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clinical_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clinical_records_id_seq OWNED BY public.clinical_records.id;


--
-- Name: culture_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.culture_results (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    sample_type character varying(100),
    incubation_days integer,
    name character varying(255),
    result_status public.sample_result_status DEFAULT 'PENDING'::public.sample_result_status NOT NULL,
    gram_type character varying(20),
    notes text,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    days_off_antibio integer,
    antibioticed boolean
);


--
-- Name: culture_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.culture_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: culture_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.culture_results_id_seq OWNED BY public.culture_results.id;


--
-- Name: doctor_recommendation_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctor_recommendation_reviews (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    run_id bigint NOT NULL,
    review_status character varying(20) NOT NULL,
    review_note text,
    modification_json jsonb,
    rejection_reason text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by character varying(255),
    created_by character varying(255)
);


--
-- Name: doctor_recommendation_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.doctor_recommendation_reviews ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.doctor_recommendation_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: image_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.image_results (
    id bigint NOT NULL,
    episode_id bigint,
    type character varying(50),
    findings text,
    file_metadata jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_by bigint,
    updated_by bigint
);


--
-- Name: image_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.image_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: image_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.image_results_id_seq OWNED BY public.image_results.id;


--
-- Name: lab_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lab_results (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    biochemical_data jsonb,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    leu jsonb,
    fluid_analysis jsonb,
    hematology_tests jsonb
);


--
-- Name: lab_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lab_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lab_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lab_results_id_seq OWNED BY public.lab_results.id;


--
-- Name: medical_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medical_histories (
    episode_id bigint NOT NULL,
    medical_history text,
    process text,
    antibiotic_history text,
    is_allergy boolean,
    allergy_note character varying(255),
    is_drug boolean,
    drug_note character varying(255),
    is_alcohol boolean,
    alcohol_note character varying(255),
    is_smoking boolean,
    smoking_note character varying(255),
    is_other boolean,
    other_note character varying(255),
    created_by character varying(255) NOT NULL,
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patients (
    id bigint NOT NULL,
    patient_code character varying(30),
    full_name character varying(100) NOT NULL,
    date_of_birth date NOT NULL,
    gender public.gender_type NOT NULL,
    identity_card character varying(50),
    insurance_number character varying(50),
    insurance_expired date,
    nationality character varying(50),
    ethnicity character varying(50),
    phone character varying(20),
    career character varying(50),
    subject character varying(50),
    address text,
    relative_info jsonb,
    created_by character varying(255) NOT NULL,
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: pending_lab_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pending_lab_tasks (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    updated_at timestamp(6) without time zone,
    updated_by character varying(255),
    assigned_to_user_id bigint,
    category character varying(30) NOT NULL,
    created_from_run_id bigint,
    field character varying(80) NOT NULL,
    importance character varying(20) NOT NULL,
    message text,
    status character varying(20) NOT NULL,
    episode_id bigint NOT NULL,
    fulfilled_lab_result_id bigint,
    patient_id bigint NOT NULL,
    CONSTRAINT pending_lab_tasks_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'FULFILLED'::character varying, 'DISMISSED'::character varying])::text[])))
);


--
-- Name: pending_lab_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.pending_lab_tasks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pending_lab_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    api_path character varying(255) NOT NULL,
    method character varying(255),
    module character varying(255),
    name character varying(255),
    created_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: pji_episodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pji_episodes (
    id bigint NOT NULL,
    patient_id bigint NOT NULL,
    admission_date date NOT NULL,
    discharge_date date,
    department character varying(255),
    treatment_days integer,
    direct character varying(255),
    reason text,
    referral_source character varying(255),
    status character varying(100) NOT NULL,
    result character varying(30) NOT NULL,
    created_by character varying(255) NOT NULL,
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: pji_episodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pji_episodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pji_episodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pji_episodes_id_seq OWNED BY public.pji_episodes.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by character varying(255),
    updated_by character varying(255),
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sensitivity_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sensitivity_results (
    id bigint NOT NULL,
    culture_id bigint NOT NULL,
    antibiotic_name character varying(100) NOT NULL,
    mic_value character varying(20),
    sensitivity_code character varying(10),
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: sensitivity_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sensitivity_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sensitivity_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sensitivity_results_id_seq OWNED BY public.sensitivity_results.id;


--
-- Name: surgeries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.surgeries (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    surgery_date date NOT NULL,
    surgery_type character varying(255) NOT NULL,
    findings text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by character varying(255),
    created_by character varying(255)
);


--
-- Name: surgeries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.surgeries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: surgeries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.surgeries_id_seq OWNED BY public.surgeries.id;


--
-- Name: treatment_plan_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.treatment_plan_versions (
    id bigint NOT NULL,
    episode_id bigint NOT NULL,
    source_run_id bigint,
    source_review_id bigint,
    version_no integer NOT NULL,
    is_current boolean DEFAULT true NOT NULL,
    status public.treatment_plan_status DEFAULT 'CONFIRMED'::public.treatment_plan_status NOT NULL,
    regimen_json jsonb NOT NULL,
    clinical_rationale text,
    confirmed_by bigint,
    confirmed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    role_id bigint,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    fullname character varying(255) NOT NULL,
    phone character varying(255),
    department character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    last_login_at timestamp with time zone,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    avatar character varying(255),
    refresh_token text,
    status character varying(50),
    last_login timestamp(6) with time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ai_chat_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_messages ALTER COLUMN id SET DEFAULT nextval('public.ai_chat_messages_id_seq'::regclass);


--
-- Name: ai_chat_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_sessions ALTER COLUMN id SET DEFAULT nextval('public.ai_chat_sessions_id_seq'::regclass);


--
-- Name: clinical_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clinical_records ALTER COLUMN id SET DEFAULT nextval('public.clinical_records_id_seq'::regclass);


--
-- Name: culture_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.culture_results ALTER COLUMN id SET DEFAULT nextval('public.culture_results_id_seq'::regclass);


--
-- Name: image_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_results ALTER COLUMN id SET DEFAULT nextval('public.image_results_id_seq'::regclass);


--
-- Name: lab_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lab_results ALTER COLUMN id SET DEFAULT nextval('public.lab_results_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: pji_episodes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pji_episodes ALTER COLUMN id SET DEFAULT nextval('public.pji_episodes_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sensitivity_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sensitivity_results ALTER COLUMN id SET DEFAULT nextval('public.sensitivity_results_id_seq'::regclass);


--
-- Name: surgeries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surgeries ALTER COLUMN id SET DEFAULT nextval('public.surgeries_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ai_chat_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ai_chat_messages (id, session_id, role, content, tokens_used, context_json, latency_ms, references_json, created_at, updated_by, updated_at, created_by) FROM stdin;
1	1	user	Bệnh nhân có tiền sử dị ứng Penicillin, tôi nên dùng kháng sinh nào thay thế?	\N	\N	\N	\N	2026-04-09 14:11:17.643+00	\N	2026-04-09 21:11:17.643	admin@gmail.com
2	1	assistant	## Lựa chọn kháng sinh thay thế cho bệnh nhân dị ứng Penicillin\n\nBác sĩ ạ, với tiền sử dị ứng Penicillin của bệnh nhân, chúng ta cần lựa chọn kháng sinh thay thế phù hợp để đảm bảo hiệu quả điều trị và an toàn cho bệnh nhân.\n\n### Dị ứng Penicillin và lựa chọn kháng sinh\n\nBệnh nhân có tiền sử dị ứng với Penicillin, do đó chúng ta cần tránh sử dụng kháng sinh thuộc nhóm này. Theo các tài liệu y khoa, các lựa chọn thay thế cho kháng sinh Penicillin bao gồm:\n\n* Cephalosporin: Đây là nhóm kháng sinh phổ rộng thường được sử dụng thay thế cho Penicillin. Tuy nhiên, cần lưu ý rằng một số bệnh nhân dị ứng với Penicillin cũng có thể dị ứng với Cephalosporin.\n* Fluoroquinolones: Nhóm kháng sinh này có phổ hoạt động rộng và có thể được sử dụng thay thế cho Penicillin.\n* Clindamycin: Đây là một kháng sinh lincosamide có phổ hoạt động rộng và có thể được sử dụng thay thế cho Penicillin.\n* Vancomycin: Đây là một kháng sinh glycopeptide thường được sử dụng để điều trị nhiễm trùng Gram dương.\n\n### Lựa chọn kháng sinh cụ thể cho bệnh nhân\n\nDựa trên dữ liệu làm sang của bệnh nhân, chúng ta thấy rằng bệnh nhân bị nhiễm trùng khớp giả do Staphylococcus aureus. Theo tài liệu "ICM VIỆT full.pdf", các lựa chọn thay thế kháng sinh cho bệnh nhân dị ứng với Penicillin bao gồm:\n\n* Vancomycin: Đây là một lựa chọn phù hợp cho bệnh nhân nhiễm trùng Gram dương, bao gồm Staphylococcus aureus.\n* Daptomycin: Đây là một kháng sinh lipopeptide có hoạt tính chống Gram dương.\n\n### Kết luận\n\nBác sĩ ạ, dựa trên dữ liệu làm sang và tài liệu y khoa, chúng tôi đề xuất sử dụng Vancomycin hoặc Daptomycin作为 kháng sinh thay thế cho bệnh nhân dị ứng với Penicillin. Tuy nhiên, cần lưu ý rằng cần phải theo dõi chặt chẽ tình trạng bệnh nhân và điều chỉnh kháng sinh nếu cần.\n\nTài liệu tham khảo:\n\n* [ICM VIỆT full.pdf]: Gábor Skaliczki, Michael Kheir, Attila Szatmári\n* [Antibiotic basic for clinic 2nd_2013.pdf]: \n\nHy vọng thông tin trên sẽ giúp bác sĩ đưa ra quyết định điều trị phù hợp cho bệnh nhân.	\N	\N	6606	[{"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "bị dị ứng với penicilin thường được điều trị bằng nhiều hơn một chất kháng khuẩn phổ rộng thay thế, bao gồm cephalosporin, ﬂuoroquinolones, clindamycin và vancomycin [19]. Bằng chứng cho thấy việc sử dụng quá nhiều kháng sinh phổ rộng dẫn đến tăng kháng kháng sinh, tăng các biến chứng lâm sàng, cũng"}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "Tác giả: Gábor Skaliczki, Michael Kheir, Attila Szatmári Câu hỏi 2:  Lựa chọn thay thế kháng sinh dự phòng khi bệnh nhân bị dị ứng phản vệ với penicillin/cephalosporin là gì? KHUYẾN CÁO: Việc lựa chọn kháng sinh dự phòng cho bệnh nhân bị dị ứng penicillin hoặc cephalosporin phản vệ đã biết bao gồm v"}, {"type": "document", "source": "Antibiotic basic for clinic 2nd_2013.pdf", "snippet": "kinh đƣợc điều trị với 10 đến 14 ngày tiêm tĩnh mạch penicillin G. Lựa chọn thay thế cho các bệnh \\nnhân bị dị ứng với penicillin bao gồm tetracycline, doxycycline, hoặc ceftriaxone. Dữ liệu hỗ trợ \\ncho việc sử dụng các thuốc thay thế là thiếu đối với một số tì nh huống lâm sàng cụ thể; do đó, gây \\nt"}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "để điều trị dự phòng chu phẫu được tránh do khả năng phản ứng chéo, mặc dù các nguy cơ liên quan là không rõ ràng [5,7,8]. Do đó, sử dụng kháng sinh dưới mức tối ưu có thể làm tăng nguy cơ nhiễm trùng ở những bệnh nhân này. Các nghiên cứu gần đây đã gợi ý rằng đơn trị liệu vancomycin có tương quan v"}]	2026-04-09 14:11:24.477+00	\N	2026-04-09 21:11:24.477	admin@gmail.com
3	1	user	xin chào bạn nhé	\N	\N	\N	\N	2026-04-09 14:59:38.943+00	\N	2026-04-09 21:59:38.943	admin@gmail.com
4	1	assistant	## Xin chào bác sĩ\n\nRất vui được tiếp tục trao đổi với bác sĩ về trường hợp bệnh nhân này. Tôi sẽ tiếp tục cung cấp thông tin và giải thích dựa trên dữ liệu làm sang thực tế và tài liệu y khoa.\n\n### Về trường hợp bệnh nhân\n\nDựa trên dữ liệu làm sang, bệnh nhân có tiền sử dị ứng với Penicillin, và hiện tại bị nhiễm trùng khớp giả do Staphylococcus aureus. Chúng tôi đã đề xuất sử dụng Vancomycin hoặc Daptomycin như kháng sinh thay thế.\n\n### Lưu ý về điều trị\n\nTheo tài liệu y khoa, khi điều trị nhiễm trùng khớp giả, cần phải xem xét các yếu tố như:\n\n* Tình trạng bệnh nhân: tuổi tác, chức năng thận, chức năng gan, dị ứng...\n* Tác nhân gây bệnh: loại vi khuẩn, mức độ kháng kháng sinh...\n* Phẫu thuật: kế hoạch phẫu thuật, loại phẫu thuật...\n\nTheo [MANAGE_1.PDF], khi điều trị nhiễm trùng khớp giả, cần phải có kế hoạch điều trị toàn diện, bao gồm:\n\n* Đánh giá tình trạng bệnh nhân\n* Lựa chọn kháng sinh phù hợp\n* Phẫu thuật nếu cần\n* Theo dõi chặt chẽ tình trạng bệnh nhân\n\n### Kế hoạch điều trị\n\nDựa trên dữ liệu làm sang và tài liệu y khoa, chúng tôi đề xuất kế hoạch điều trị như sau:\n\n* Sử dụng Vancomycin hoặc Daptomycin như kháng sinh thay thế\n* Theo dõi chặt chẽ tình trạng bệnh nhân, bao gồm chức năng thận, chức năng gan...\n* Phẫu thuật nếu cần, và có kế hoạch phẫu thuật cụ thể\n\nHy vọng thông tin trên sẽ giúp bác sĩ đưa ra quyết định điều trị phù hợp cho bệnh nhân.\n\nTài liệu tham khảo:\n\n* [MANAGE_1.PDF]: Vergidis et al. (2012)\n* [2016. Q─Р 261. BYT. H╞░с╗Ыng dс║лn ─Сiс╗Бu trс╗Л c├бc bс╗Зnh c╞б x╞░╞бng khс╗Ыp.pdf]: Hướng dẫn điều trị nhiễm trùng khớp giả Bộ Y tế Việt Nam.	\N	\N	4809	[{"type": "document", "source": "MANAGE_1.PDF", "snippet": "bidities  and solid organ transplant  (Vergidis et al. \\n2012), smoking, skin diseases (e.g. psoriasis , his-\\ntory of vascular surgery , kidney function, nutri-\\ntional status (overweight , underweight , unex-\\nplained weight loss , body mass index), substance \\nabuse , chronic pain  syndrome, psycholog"}, {"type": "document", "source": "MANAGE_1.PDF", "snippet": "surgeons so as to allow the team to plan ahead. Both \\nteams should be kept on standby when performing \\nexchange surgery. Internists should review the med-\\nication so as to start treating hitherto hidden diabe-\\ntes, to correct anaemia, and to plan the pathway to \\nsuspend DMARDS etc. and evaluate and "}, {"type": "document", "source": "2016. Q─Р 261. BYT. H╞░с╗Ыng dс║лn ─Сiс╗Бu trс╗Л c├бc bс╗Зnh c╞б x╞░╞бng khс╗Ыp.pdf", "snippet": "Tiến, B ộ tr ưởng B ộ Y tế và các thành viên ban biên so ạn đã r ất c ố g ắng, dành nhi ều th ời \\ngian quý báu để biên so ạn cu ốn sách này. Đây là l ần xu ất b ản đầu tiên c ủa cu ốn sách, \\nch ắc ch ắn v ẫn còn có thi ếu sót, chúng tôi r ất mong nh ận được s ự đóng góp t ừ Quý độc \\ngi ả và đồng ngh"}, {"type": "document", "source": "4. Prosthetic Joint Infection - DynaMed.pdf", "snippet": "Published by EBSCO Information Services. Copyright © 2024, EBSCO Information Services. All rights reserved. No part of thismay be reproduced or utilized in any form or by any means, electronic or mechanical, including photocopying, recording, or byany information storage and retrieval system, withou"}]	2026-04-09 14:59:44.01+00	\N	2026-04-09 21:59:44.01	admin@gmail.com
5	2	user	Tại sao lại chọn Vanconmycin?	\N	\N	\N	\N	2026-04-11 13:55:43.638+00	\N	2026-04-11 20:55:43.638	admin@gmail.com
6	2	assistant	## Lý do chọn Vancomycin\n\nBác sĩ ạ, tôi chọn Vancomycin dựa trên các yếu tố sau:\n\n### Lịch sử bệnh nhân\n\nBệnh nhân có tiền sử phẫu thuật thay khớp háng toàn phần vào tháng 11 năm 2024. Hiện tại, bệnh nhân có dấu hiệu nhiễm trùng khớp háng phải với triệu chứng đau tăng dần, sưng nhẹ, nóng tại chỗ và sốt nhẹ.\n\n### Kết quả xét nghiệm\n\nKết quả xét nghiệm máu cho thấy:\n\n* WBC: 12.26 G/L (tăng)\n* CRP: 138.2 mg/L (tăng)\n* ESR: 6.0 mm/h (tăng nhẹ)\n\nKết quả xét nghiệm dịch khớp:\n\n* Synovial WBC: 5.0 tế bào/Vi trường\n* Synovial PMN: 74.0%\n\nKết quả nuôi cấy:\n\n* Staphylococcus aureus (Gram dương) được phát hiện trong mẫu dịch khớp, kháng Methicillin.\n\n### Căn cứ vào tài liệu y khoa\n\nTheo tài liệu y khoa, Vancomycin là một kháng sinh hiệu quả đối với Staphylococcus aureus kháng Methicillin [1]. Trong trường hợp này, bệnh nhân có dấu hiệu nhiễm trùng khớp háng phải do Staphylococcus aureus kháng Methicillin, do đó Vancomycin là một lựa chọn hợp lý.\n\n### Hướng dẫn điều trị\n\nTheo hướng dẫn điều trị của WHO, Vancomycin được khuyến cáo sử dụng trong trường hợp nhiễm trùng do Staphylococcus aureus kháng Methicillin [2].\n\n## Kết luận\n\nTóm lại, tôi chọn Vancomycin dựa trên lịch sử bệnh nhân, kết quả xét nghiệm, và căn cứ vào tài liệu y khoa. Vancomycin là một kháng sinh hiệu quả đối với Staphylococcus aureus kháng Methicillin và phù hợp với hướng dẫn điều trị của WHO.\n\n## Tài liệu tham khảo\n\n[1] *Parvizi et al. (2010b)*, *Tyllianakis et al. (2010)*, *Sewick et al. (2012)*\n\n[2] *WHO AWARe (Access, Watch, Reserve) (2022).pdf*	\N	\N	12641	[{"type": "document", "source": "MANAGE_1.PDF", "snippet": "36 Chapter 3 · Clinical A spects\\n3\\n benefit in the literature (Parvizi et al. 2010b; Tylli-\\nanakis et al. 2010; Sewick et al. 2012). First- or sec-\\nond-generation cephalosporins are widely used \\nbecause of their activity against common orthopae-\\ndic pathogens: specifically Gram-positive bacteria \\nan"}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "gentamycin [5]. Tuy nhiên, thiết kế của nghiên cứu cho phép thiên vị với các biến gây nhiễu, bao gồm sử dụng xi măng tẩm kháng sinh, có thể ảnh hưởng đến kết quả.   Cần lưu ý rằng Trung tâm Kiểm soát Dịch bệnh và phòng ngừa phát hành một khuyến cáo về việc sử dụng vancomycin vào năm 1995 do lo ngại "}, {"type": "document", "source": "S├бch h╞░с╗Ыng dс║лn sс╗н dс╗еng thuс╗Сc kh├бng sinh WHO AWARe (Access, Watch, Reserve) (2022).pdf", "snippet": "may be justified. This is recommended because vancomycin alone is less effective than \\ncefazolin (the antibiotic recommended as prophylaxis in most surgical procedures) against \\nmethicillin-sensitive Staphylococcus aureus and because vancomycin has no activity against \\nGram-negative bacteria. It sho"}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "Vancomycin được sử dụng có chọn lọc ở những bệnh nhân mang MRSA hoặc có nguy cơ nhiễm MRSA cao, chẳng hạn như cư dân viện dưỡng lão và nhân viên y tế. Ở những bệnh nhân có bằng chứng hoặc nghi ngờ dị ứng với cephalosporin, clindamycin cũng có thể được sử dụng và nên được sử dụng trong vòng một giờ s"}]	2026-04-11 13:55:56.483+00	\N	2026-04-11 20:55:56.483	admin@gmail.com
7	2	user	Tại sao lại chọn Rifampicin?	\N	\N	\N	\N	2026-04-11 14:37:13.92+00	\N	2026-04-11 21:37:13.92	admin@gmail.com
8	2	assistant	## Lý do chọn Rifampicin\n\nBác sĩ ạ, tôi chọn Rifampicin dựa trên các yếu tố sau:\n\n### Đặc điểm vi khuẩn\n\nBệnh nhân có kết quả nuôi cấy dịch khớp dương tính với Staphylococcus aureus kháng Methicillin. Theo tài liệu y khoa, Rifampicin là một kháng sinh hiệu quả đối với Staphylococcus aureus, đặc biệt là trong trường hợp nhiễm trùng xương và khớp [1].\n\n### Cơ chế tác dụng\n\nRifampicin hoạt động bằng cách ức chế sự tổng hợp RNA của vi khuẩn thông qua liên kết với RNA polymerase. Cơ chế này giúp Rifampicin có hiệu quả cao đối với các vi khuẩn Gram dương, bao gồm Staphylococcus aureus [2].\n\n### Sử dụng trong điều trị nhiễm trùng xương và khớp\n\nTheo hướng dẫn điều trị của Infectious Diseases Society of America (IDSA), Rifampicin thường được sử dụng kết hợp với các kháng sinh khác trong điều trị nhiễm trùng xương và khớp do Staphylococcus aureus kháng Methicillin [3].\n\n### Ưu điểm\n\nRifampicin có một số ưu điểm trong điều trị nhiễm trùng xương và khớp:\n\n* Hoạt động tốt đối với Staphylococcus aureus kháng Methicillin\n* Có thể sử dụng đường uống, giúp tăng cường tuân thủ điều trị\n* Có thể giảm thiểu thời gian điều trị bằng kháng sinh\n\n## Kết luận\n\nTóm lại, tôi chọn Rifampicin dựa trên đặc điểm vi khuẩn, cơ chế tác dụng, và hướng dẫn điều trị của IDSA. Rifampicin là một kháng sinh hiệu quả đối với Staphylococcus aureus kháng Methicillin và phù hợp với điều trị nhiễm trùng xương và khớp.\n\n## Tài liệu tham khảo\n\n[1] *Antibiotic basic for clinic 2nd_2013.pdf*: Nhóm rifamycin\n\n[2] *Antibiotic basic for clinic 2nd_2013.pdf*: dễ dàng và có thể là kết quả của một đột biến đơn lẻ trong gen của vi khuẩn mã hóa RNA polymerase\n\n[3] *IDSA Guidelines for the Diagnosis and Management of Prosthetic Joint Infection (PJI)*	\N	\N	4141	[{"type": "document", "source": "Antibiotic basic for clinic 2nd_2013.pdf", "snippet": "Nhóm rifamycin \\nCác rifamycin là thuốc kháng sinh \\"phụ kiện\\". Cũng giống nhƣ một chiếc ví thời trang hay \\nvòng cổ lấp lánh đƣợc sử dụng để tô điểm cho một chiếc váy, các thuốc kháng sinh này đƣợc \\nbổ sung vào các điều trị truyền thống nhằm đạt hiệu quả tối ƣu. Các rifamycin gồm \\nrifampin (còn gọi là"}, {"type": "document", "source": "Antibiotic basic for clinic 2nd_2013.pdf", "snippet": "dễ dàng và có thể là kết quả của một đột biến đơn lẻ trong gen của vi khuẩn mã hóa RNA \\npolymerase. Những đột biến này chỉ cần thay đổi một axit amin đơn ở nơi mà các rifamycin \\nliên kết với RNA polymerase cũng đủ để ngă n liên kết này. Bởi vì những đột biến đơn lẻ đủ \\nđể dẫn đến đề kháng, các rifam"}, {"type": "document", "source": "Antibiotic basic for clinic 2nd_2013.pdf", "snippet": "cho bệnh nhân suy giảm miễn dịch bởi vì loại thuốc này đƣợc sử dụng một tuần mỗi lần thay vì sử \\ndụng hằng ngày. Rifabutin thƣờng đƣợc thay thế cho rifampin ở những bệnh nhân đang đƣợc điều \\ntrị HIV bởi loại thuốc này sẽ ít tƣơng tác với các quá trình chuyển hóa của các loại thuốc kháng \\nretrovirus "}, {"type": "document", "source": "Antibiotic basic for clinic 2nd_2013.pdf", "snippet": "influenzae. Việc sử dụng rifampin đơn độc trong dự phòng này đƣợc ủng hộ bởi thực tế rằng, \\nthông thƣờng, rất ít vi khuẩn có mặt khi bệnh nhân không bị bệnh, do đó giảm thiểu cơ hội \\nmà một đột biến kháng rifampin sẽ xảy ra một cách ngẫu nhiên. \\nRifampin  \\nRifampin đƣợc sử dụng lâu đời nhất và rộng "}]	2026-04-11 14:37:18.153+00	\N	2026-04-11 21:37:18.153	admin@gmail.com
9	3	user	tại sao lại chọn kháng sinh cefazolin?	\N	\N	\N	\N	2026-04-12 03:45:34.408+00	\N	2026-04-12 10:45:34.408	admin@gmail.com
10	3	assistant	## Lý do chọn kháng sinh Cefazolin\n\nBác sĩ ạ, tôi chọn kháng sinh Cefazolin dựa trên các yếu tố sau:\n\n### Tác nhân gây bệnh phổ biến\n\nCefazolin là kháng sinh có hoạt tính mạnh đối với cầu khuẩn Gram dương, đặc biệt là Staphylococcus aureus, đây là tác nhân gây bệnh phổ biến nhất ở nhiễm trùng khớp giả (PJI) và nhiễm trùng vết mổ (SSI) [1, 5, 11].\n\n### Khuyến cáo từ tài liệu y khoa\n\nTheo tài liệu ICM Việt Nam, Cefazolin 2g thường quy được sử dụng làm kháng sinh dự phòng trong phẫu thuật [10]. Hơn nữa, các nghiên cứu cũng chỉ ra rằng bệnh nhân không được dùng kháng sinh dự phòng có tỉ lệ nhiễm trùng cao hơn 5,53 lần [10].\n\n### Phản ứng dị ứng\n\nMặc dù bệnh nhân có tiền sử dị ứng với thuốc kháng sinh nhóm Penicillin, nhưng theo hướng dẫn của ESCMID, nguy cơ phản ứng dị ứng chéo giữa Penicillin và Cephalosporin là thấp (<1%) [ESCMID clinical guidelines on the evaluation and management of a reported antibiotic allergy (2026).pdf]. Do đó, Cefazolin vẫn có thể được sử dụng an toàn.\n\n### Hiệu quả lâm sàng\n\nCefazolin đã được chứng minh là có hiệu quả trong điều trị nhiễm trùng khớp giả và nhiễm trùng vết mổ. Với cơ chế tác dụng là ức chế tổng hợp thành tế bào vi khuẩn, Cefazolin có thể giúp kiểm soát nhiễm trùng hiệu quả.\n\nTóm lại, dựa trên các yếu tố trên, tôi chọn kháng sinh Cefazolin vì nó có hoạt tính mạnh đối với tác nhân gây bệnh phổ biến, được khuyến cáo trong tài liệu y khoa, có nguy cơ phản ứng dị ứng thấp và hiệu quả lâm sàng đã được chứng minh.\n\n## Tài liệu tham khảo\n\n[1] ICM Việt Nam\n[5] Tài liệu y khoa khác\n[10] ICM Việt Nam\n[11] Tài liệu y khoa khác\n[ESCMID clinical guidelines on the evaluation and management of a reported antibiotic allergy (2026).pdf]	\N	\N	4463	[{"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "nhân được dùng cefazolin 2 g thường quy. Hơn nữa, những bệnh nhân không được dùng kháng sinh ở có tỉ lệ nhiễm trùng cao hơn 5.53 lần [10].   Trong phẫu thuật chương trình, kháng sinh trước mổ được ưu tiên lựa chọn là cephalosporin thế hệ thứ nhất hoặc thứ hai (cefazolin hoặc cefuroxime) [11]. Chúng "}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "Cầu khuẩn gram dương là tác nhân gây bệnh phổ biến nhất ở SSI và PJI trong các ca phẫu thuật bàn chân và mắt cá chân [1,5,11]. Cefazolin là kháng sinh dự phòng được sử dụng rộng rãi hơn cả trong các phẫu thuật chỉnh hình do khả năng thâm nhập vào xương, mô mềm hiệu quả và nhanh chóng, khả năng bao p"}, {"type": "document", "source": "ESCMID clinical guidelines on the evaluation and management of a reported antibiotic allergy (2026).pdf", "snippet": "cephalosporins is primarily driven  by  R1  side chain similarity. \\nMultiple  systematic  reviews  and  meta-analyses repeatedly dem -\\nonstrated  a low  risk (< 1%) of cross-reactivity when  cephalosporins \\nwith  dissimilar side chains are used  in skin tests or proven  \\npenicillin-allergic patients"}, {"type": "document", "source": "S├бch h╞░с╗Ыng dс║лn sс╗н dс╗еng thuс╗Сc kh├бng sinh WHO AWARe (Access, Watch, Reserve) (2022).pdf", "snippet": "The WHO AWaRe (Access, Watch, Reserve) antibiotic book571\\nHOSPITAL FACILITY  \\n40. Surgical prophylaxis\\ngeneration cephalosporins – cefazolin or, as an alternative second choice, cefuroxime. These \\nsurgeries include clean procedures such as cardiac and vascular surgery but also procedures \\nthat invo"}]	2026-04-12 03:45:39.07+00	\N	2026-04-12 10:45:39.07	admin@gmail.com
11	3	user	nếu không có cefazolin thì tôi thay thế bằng kháng sinh gì?	\N	\N	\N	\N	2026-04-12 04:08:09.508+00	\N	2026-04-12 11:08:09.508	admin@gmail.com
12	3	assistant	## Kháng sinh thay thế khi không có Cefazolin\n\nBác sĩ ạ, nếu không có Cefazolin, tôi đề xuất sử dụng kháng sinh Teicoplanin hoặc Nafcillin/Oxacillin như các lựa chọn thay thế.\n\n### Lý do chọn Teicoplanin\n\nTeicoplanin là kháng sinh có hoạt tính mạnh đối với cầu khuẩn Gram dương, bao gồm cả Staphylococcus aureus, đây là tác nhân gây bệnh phổ biến ở nhiễm trùng khớp giả (PJI) và nhiễm trùng vết mổ (SSI) [8]. Theo nghiên cứu của De Lucas-Villarrubia và cộng sự, Teicoplanin có thể được sử dụng như một kháng sinh thay thế hiệu quả [8].\n\n### Lý do chọn Nafcillin/Oxacillin\n\nNafcillin và Oxacillin là các penicillin kháng penicillinase, thường được sử dụng để điều trị nhiễm trùng do Staphylococcus aureus [1]. Theo tài liệu ICM Việt Nam, các kháng sinh này có thể được sử dụng như một phần của liệu pháp chăm sóc (SOCT) đối với nhiễm trùng MSSA (Methicillin-sensitive Staphylococcus aureus) [1].\n\n### Lưu ý về dị ứng và hiệu quả lâm sàng\n\nMặc dù bệnh nhân có tiền sử dị ứng với thuốc kháng sinh nhóm Penicillin, nhưng cần phải đánh giá kỹ lưỡng về nguy cơ phản ứng dị ứng chéo giữa Penicillin và các kháng sinh khác. Tuy nhiên, theo hướng dẫn của ESCMID, nguy cơ phản ứng dị ứng chéo giữa Penicillin và các kháng sinh khác là thấp [ESCMID clinical guidelines on the evaluation and management of a reported antibiotic allergy (2026).pdf].\n\nTóm lại, dựa trên các yếu tố trên, tôi đề xuất sử dụng kháng sinh Teicoplanin hoặc Nafcillin/Oxacillin như các lựa chọn thay thế khi không có Cefazolin.\n\n## Tài liệu tham khảo\n\n[1] ICM Việt Nam\n[8] De Lucas-Villarrubia và cộng sự\n[ESCMID clinical guidelines on the evaluation and management of a reported antibiotic allergy (2026).pdf]	\N	\N	4054	[{"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "cho cefazolin [5–7,9], trong khi De Lucas- Villarrubia và cộng sự dùng teicoplanin thay thế [8]. Trái ngược với các nghiên cứu trước đây đã đề cập, tất cả các nghiên cứu đã báo cáo tỷ lệ nhiễm trùng giảm đáng kể ở những bệnh nhân được sử dụng kháng sinh thay thế sau khi sàng lọc so với những người đ"}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "hình bao gồm cả nhiễm trùng khớp nhân tạo (PJIs) [1]. Tiêu chuẩn kháng sinh của liệu pháp chăm sóc (SOCT) đối với nhiễm trùng MSSA bao gồm các penicillin kháng penicillinase (nafcillin / oxacillin / ﬂucloxacillin) với cephalosporin thế hệ thứ nhất, cefazolin, như một kháng sinh thay thế [1–4]. Đối v"}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "Một thử nghiệm lâm sàng có nhóm chứng-giả dược đánh giá việc dùng cefazolin dự phòng trong 2137 trường hợp thay khớp háng toàn phần cho thấy tỉ lệ nhiễm trùng giảm đáng kể [12] trong khi đó một RCT khác so sánh cefuroxime với vancomycin và acid fusidic ở 435 bệnh nhân thay khớp cho thấy không có sự "}, {"type": "document", "source": "ICM VIỆT full.pdf", "snippet": "thực hiện nghiên cứu hồi cứu 1 962 bệnh nhân, trong đó có 196 bệnh nhân tự báo cáo là bị dị ứng với penicillin (Bảng 3). Có 54 bệnh nhân được sử dụng cefazolin và không có bệnh nhân nào báo cáo bất kỳ phản ứng phụ nào [24]. Ngoài ra, trong khi một số nghiên cứu khuyến nghị sử dụng clindamycin hoặc v"}]	2026-04-12 04:08:13.637+00	\N	2026-04-12 11:08:13.637	admin@gmail.com
19	2	user	bệnh nhân có phác đồ điều trị kháng sinh tại chỗ không?	\N	\N	\N	\N	2026-05-06 09:21:22.375+00	\N	2026-05-06 16:21:22.375	admin@gmail.com
20	2	assistant	## Trả lời về phác đồ điều trị kháng sinh tại chỗ\n\nBác sĩ ạ, dựa trên dữ liệu lâm sàng hiện tại của bệnh nhân, **không có thông tin cụ thể về việc sử dụng kháng sinh tại chỗ** trong hồ sơ bệnh án. Tuy nhiên, tôi sẽ phân tích và đưa ra các khuyến nghị dựa trên tình trạng của bệnh nhân và tài liệu y khoa liên quan.\n\n### Phân tích tình trạng bệnh nhân\n\n1. **Nhiễm trùng khớp háng phải**:  \n   - Bệnh nhân có dấu hiệu nhiễm trùng khớp háng phải với triệu chứng đau tăng dần, sưng nhẹ, nóng tại chỗ và sốt nhẹ.  \n   - Kết quả nuôi cấy dịch khớp dương tính với **Staphylococcus aureus kháng Methicillin** và **Klebsiella pneumoniae**.  \n\n2. **Can thiệp phẫu thuật**:  \n   - Bệnh nhân đã trải qua phẫu thuật thay khớp háng toàn phần vào tháng 11/2024 và có tiền sử nhiễm trùng vết mổ sau phẫu thuật thay khớp gối vào tháng 10/2025.  \n\n3. **Kết quả xét nghiệm**:  \n   - CRP dịch khớp: 138 mg/L (tăng cao).  \n   - %PMN dịch khớp: 96% (tăng cao).  \n\n### Khuyến nghị về kháng sinh tại chỗ\n\nTheo tài liệu y khoa, **kháng sinh tại chỗ** có thể được sử dụng trong điều trị nhiễm trùng khớp nhân tạo (PJI) khi kết hợp với phẫu thuật và kháng sinh toàn thân. Đặc biệt, trong trường hợp nhiễm trùng do vi khuẩn kháng thuốc như MRSA hoặc Gram âm, kháng sinh tại chỗ có thể giúp tăng hiệu quả điều trị [nguồn: ICM VIỆT full.md].\n\n#### Các lựa chọn kháng sinh tại chỗ phù hợp:\n\n1. **Vancomycin tại chỗ**:  \n   - Hiệu quả đối với Staphylococcus aureus kháng Methicillin.  \n   - Có thể sử dụng dưới dạng bột hoặc chất mang kháng sinh.  \n\n2. **Gentamicin tại chỗ**:  \n   - Hiệu quả đối với Klebsiella pneumoniae và các vi khuẩn Gram âm khác.  \n   - Thường được sử dụng kết hợp với Vancomycin để phủ rộng phổ kháng sinh.  \n\n3. **Rifampicin tại chỗ**:  \n   - Hiệu quả cao đối với Staphylococcus aureus, đặc biệt trong nhiễm trùng xương và khớp.  \n   - Có thể sử dụng kết hợp với kháng sinh toàn thân để tăng hiệu quả điều trị [nguồn: Antibiotic basic for clinic 2nd_2013.pdf].  \n\n### Kết luận\n\nHiện tại, **không có thông tin về việc sử dụng kháng sinh tại chỗ** trong hồ sơ bệnh án của bệnh nhân. Tuy nhiên, dựa trên tình trạng nhiễm trùng và kết quả nuôi cấy, tôi đề xuất **xem xét sử dụng kháng sinh tại chỗ** như Vancomycin hoặc Gentamicin kết hợp với phẫu thuật và kháng sinh toàn thân để tối ưu hóa hiệu quả điều trị.\n\nNếu bác sĩ muốn tôi đề xuất phác đồ điều trị cụ thể, vui lòng cho biết để tôi cung cấp thông tin chi tiết hơn.  \n\n```json\n{\n  "category": "LOCAL_ANTIBIOTIC",\n  "title": "Phác đồ kháng sinh tại chỗ",\n  "details": {\n    "recommendations": [\n      "Vancomycin tại chỗ (đối với MRSA)",\n      "Gentamicin tại chỗ (đối với Klebsiella pneumoniae)",\n      "Rifampicin tại chỗ (kết hợp với kháng sinh toàn thân)"\n    ],\n    "notes": "Kết hợp với phẫu thuật và kháng sinh toàn thân để tối ưu hiệu quả điều trị."\n  }\n}\n```	\N	\N	166767	[{"type": "document", "source": "ICM VIỆT full.md", "snippet": "Kháng sinh tại chỗ, bất kể có chất mang hay không, có thể có vai trò trong điều trị một số bệnh nhiễm trùng cơ xương khớp khi kết hợp với can thiệp phẫu thuật và sử dụng thuốc kháng sinh toàn thân. Các hệ thống phân phối tại chỗ săn có trong thực hành làm sàng không thể cho phép đạt được nòng độ thu"}, {"type": "document", "source": "ICM VIỆT full.md", "snippet": "tin kháng sinh ở 30 bệnh nhân và họ đánh giá điều trị không đủ ở 15 bệnh nhân liên quan đến thời gian và loại kháng sinh. Năm bệnh nhân chỉ được điều trị bằng kháng sinh, và chỉ có hai người không bị nhiễm trùng ở lần theo dõi cuối cùng (60%tỷ lệ thất bại)."}, {"type": "document", "source": "Hướng dẫn sử dụng kháng sinh.md", "snippet": "- Xem xét chiến lược điều trị xuống thang ngay sau khi có kết quả kháng sinh đồ.\\n\\nLựa chọn kháng sinh điều trị theo kinh nghiệm\\n\\n- Kháng sinh có thể được lựa chọn theo Bảng II.6 và Bảng II.7.\\n\\n- Thời gian điều trị thường từ 10 - 14 ngày, thời gian điều trị có thể kéo dài hơn đến 21 ngày nếu nhiễm cá"}, {"type": "document", "source": "Hướng dẫn sử dụng kháng sinh.md", "snippet": "- Trước khi vận chuyển, cần chỉ định sớm kháng sinh theo kinh nghiệm liều đầu tiên (dựa trên cơ địa và định hướng sơ bộ trên lâm sàng). Ngoài ra, người bệnh phải được đánh giá cụ thể tình trạng hộ hấp để chỉ định phương thức thở máy phù hợp.\\n\\n- Trong quá trình vận chuyển phải đảm bảo mạch, huyết áp "}, {"type": "document", "source": "ICM VIỆT full.md", "snippet": "Kháng sinh tại chỗ, bất kể có chất mang hay không, có thể có vai trò trong điều trị một số bệnh nhiễm trùng cơ xương khớp khi kết hợp với can thiệp phẫu thuật và sử dụng thuốc kháng sinh toàn thân. Các hệ thống phân phối tại chỗ săn có trong thực hành làm sàng không thể cho phép đạt được nòng độ thu"}]	2026-05-06 09:24:09.261+00	\N	2026-05-06 16:24:09.261	admin@gmail.com
\.


--
-- Data for Name: ai_chat_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ai_chat_sessions (id, run_id, current_item_id, chat_type, episode_id, title, is_archived, created_at, updated_by, updated_at, created_by) FROM stdin;
1	1	1	GENERAL	3	Hỏi đáp về phác đồ điều trị PJI	f	2026-04-09 13:46:20.143+00	\N	2026-04-09 20:46:20.143	admin@gmail.com
2	13	\N	GENERAL	4	Chat lúc 20:55 11/4/2026	f	2026-04-11 13:55:07.961+00	\N	2026-04-11 20:55:07.961	admin@gmail.com
3	12	\N	GENERAL	3	Chat lúc 10:29 12/4/2026	f	2026-04-12 03:29:56.949+00	\N	2026-04-12 10:29:56.949	admin@gmail.com
4	20	\N	GENERAL	4	Chat lúc 21:06 8/5/2026	f	2026-05-08 14:06:49.024+00	\N	2026-05-08 21:06:49.024	admin@gmail.com
\.


--
-- Data for Name: ai_rag_citations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ai_rag_citations (id, run_id, item_id, source_type, source_title, source_uri, snippet, relevance_score, created_at, cited_for, updated_by, updated_at, created_by) FROM stdin;
1	1	1	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icm.org.uk/wp-content/uploads/2018/07/ICM-2018-PJI-Diagnostic-Criteria.pdf	Tiêu chí chẩn đoán nhiễm trùng khớp giả của ICM 2018	0.9500	2026-04-07 10:57:22.11+00	Chẩn đoán nhiễm trùng khớp giả	\N	2026-04-07 17:57:22.11	 
2	1	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-07 10:57:22.114+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.114	 
3	1	\N	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-07 10:57:22.117+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.117	 
4	1	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-07 10:57:22.12+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.12	 
5	2	4	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icm.org.uk/wp-content/uploads/2018/06/ICM-2018-PJI-Guidelines.pdf	Tiêu chí chẩn đoán nhiễm trùng khớp giả	0.9500	2026-04-07 10:57:22.173+00	Chẩn đoán nhiễm trùng khớp giả	\N	2026-04-07 17:57:22.173	 
6	2	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-07 10:57:22.177+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.177	 
7	2	\N	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-07 10:57:22.18+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.18	 
8	2	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-07 10:57:22.183+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.183	 
9	3	7	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-07 10:57:22.206+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.206	 
10	3	7	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-07 10:57:22.21+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.21	 
11	3	7	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-07 10:57:22.213+00	Tai lieu tham khao RAG	\N	2026-04-07 17:57:22.213	 
12	4	8	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icm.org.uk/wp-content/uploads/2018/06/ICM-2018-PJI-Guidelines.pdf	Tiêu chí chẩn đoán nhiễm trùng khớp giả của ICM 2018.	0.9500	2026-04-07 15:48:57.251+00	Chẩn đoán nhiễm trùng khớp giả	\N	2026-04-07 22:48:57.251	 
13	4	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-07 15:48:57.254+00	Tai lieu tham khao RAG	\N	2026-04-07 22:48:57.254	 
14	4	\N	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-07 15:48:57.257+00	Tai lieu tham khao RAG	\N	2026-04-07 22:48:57.257	 
15	4	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-07 15:48:57.259+00	Tai lieu tham khao RAG	\N	2026-04-07 22:48:57.259	 
16	7	11	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icm.org.uk/wp-content/uploads/2018/07/ICM-2018-PJI-Guidelines.pdf	Tiêu chí chẩn đoán nhiễm trùng khớp giả của ICM 2018.	0.9500	2026-04-08 16:37:36.656+00	Chẩn đoán nhiễm trùng khớp giả.	\N	2026-04-08 23:37:36.656	 
17	7	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-08 16:37:36.663+00	Tai lieu tham khao RAG	\N	2026-04-08 23:37:36.663	 
18	7	\N	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-08 16:37:36.666+00	Tai lieu tham khao RAG	\N	2026-04-08 23:37:36.666	 
19	7	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-08 16:37:36.669+00	Tai lieu tham khao RAG	\N	2026-04-08 23:37:36.669	 
20	8	14	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icm.org.uk/wp-content/uploads/2018/07/ICM-2018-PJI-Guidelines.pdf	Hướng dẫn chẩn đoán nhiễm trùng khớp giả.	0.9500	2026-04-08 16:38:27.907+00	Chẩn đoán nhiễm trùng khớp giả.	\N	2026-04-08 23:38:27.907	 
21	8	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-08 16:38:27.91+00	Tai lieu tham khao RAG	\N	2026-04-08 23:38:27.91	 
22	8	\N	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-08 16:38:27.914+00	Tai lieu tham khao RAG	\N	2026-04-08 23:38:27.914	 
23	8	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-08 16:38:27.917+00	Tai lieu tham khao RAG	\N	2026-04-08 23:38:27.917	 
34	12	28	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icm.org.uk/wp-content/uploads/2018/06/ICM-2018-PJI-Guidelines.pdf	Tiêu chí chẩn đoán nhiễm trùng khớp giả	0.9500	2026-04-09 03:57:31.034+00	Chẩn đoán nhiễm trùng khớp giả	\N	2026-04-09 10:57:31.034	 
35	12	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	Key words: Diagnosis; Next-generation sequencing; Periprosthetic joint infection; Systematic review\nIntroduction\nPeriprosthetic joint infection (PJI) is one of the most dev-\nastating complications after total knee arthroplasty\n(TKA) or total hip arthroplasty (THA). Though a rare com-\nplication, PJI 	0.8000	2026-04-09 03:57:31.04+00	Tai lieu tham khao RAG	\N	2026-04-09 10:57:31.04	 
36	12	\N	GUIDELINE	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	State-of-the-art diagnosis and surgical treatment of acute peri-prosthetic joint infection following primary total hip arthroplasty.pdf	435\nState-of-the-art diagnoSiS and Surgical treatment of acute PJi folloWing PrimarY tha\nearly diagnosis and treatment of the acute THA infection, \nmainly Tsukayama type 1 and 3 post-operative PJIs.\nAccurate diagnosis of peri-prosthetic joint \ninfection\nNowadays, diagnosis of PJI is evolving towards	0.8000	2026-04-09 03:57:31.043+00	Tai lieu tham khao RAG	\N	2026-04-09 10:57:31.043	 
37	12	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	imately two-thirds of culture-negative PJIs had identi ﬁable opportunistically pathogenic organisms, and furthermore, the\nmajority of infections were polymicrobial.\nLevel of Evidence: Diagnostic Level II. See Instructions for Authors for a complete description of levels of evidence.\nT\nhe diagnosis a	0.8000	2026-04-09 03:57:31.047+00	Tai lieu tham khao RAG	\N	2026-04-09 10:57:31.047	 
38	13	31	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://www.icmmsociety.org/icm-2018-pji-diagnostic-criteria/	Các tiêu chí chẩn đoán nhiễm trùng khớp háng phải theo ICM 2018.	0.9500	2026-04-11 13:54:32.622+00	Chẩn đoán nhiễm trùng khớp háng phải	\N	2026-04-11 20:54:32.622	 
39	13	32	JOURNAL_ARTICLE	Antibiotic therapy for prosthetic joint infections	https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5737413/	Lựa chọn kháng sinh cho điều trị nhiễm trùng khớp háng phải.	0.9000	2026-04-11 13:54:32.626+00	Lựa chọn kháng sinh toàn thân	\N	2026-04-11 20:54:32.626	 
40	14	34	GUIDELINE	ICM 2018 PJI Diagnostic Criteria	https://doi.org/10.2106/JBJS.19.00598	Tiêu chí chẩn đoán nhiễm trùng khớp giả	0.9500	2026-04-11 14:34:25.859+00	Chẩn đoán nhiễm trùng khớp giả	\N	2026-04-11 21:34:25.859	 
41	14	\N	GUIDELINE	1stage revision  book.pdf	1stage revision  book.pdf	recent developments. JBJS. 2020;102:1366–75. https://doi.org/10.2106/JBJS.19.00598.\n7. Goh GS, Parvizi J. Diagnosis and treatment of culture-negative periprosthetic joint infection. J \nArthroplast. 2022;37:1488. https://doi.org/10.1016/j.arth.2022.01.061.\n8. Kim S-J, Cho YJ. Current guideline for di	0.8000	2026-04-11 14:34:25.861+00	Tai lieu tham khao RAG	\N	2026-04-11 21:34:25.861	 
42	14	\N	GUIDELINE	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	PJI Diagnosis and Therapy Vietnam Gehrke.pdf	exchange arthroplasty\nIntroduction\nThe diagnosis of periprosthetic joint infection (PJI) is based \non a multiple criteria system due to the lack of a single test \nwith an accuracy of 100%. The consented criteria most \nbroadly accepted today are the Musculoskeletal Infection \nSociety (MSIS)/Internati	0.8000	2026-04-11 14:34:25.863+00	Tai lieu tham khao RAG	\N	2026-04-11 21:34:25.863	 
43	14	\N	GUIDELINE	ICM VIỆT full.pdf	ICM VIỆT full.pdf	Eigenmann K, Ledergerber B, Derksen L, Rafeiner P, Clauss M, et al. Factors associated with rifampin resistance in staphylococcal peri- prosthetic joint infections (PJI): a matched ca–control study. Infection. 2013;41:431–437. doi:10.1007/s15010–012–0325–7.  [44]  Osmon DR, Berbari EF, Berendt AR, L	0.8000	2026-04-11 14:34:25.866+00	Tai lieu tham khao RAG	\N	2026-04-11 21:34:25.866	 
60	19	\N	JOURNAL_ARTICLE	Periprosthetic Joint Infection – Robin Patel	\N		0.9500	2026-05-07 03:39:52.359+00	\N	\N	2026-05-07 10:39:52.359	 
61	19	\N	JOURNAL_ARTICLE	ICM VIỆT full.md	\N		0.9000	2026-05-07 03:39:52.363+00	\N	\N	2026-05-07 10:39:52.363	 
62	19	\N	JOURNAL_ARTICLE	One-Stage Septic Revision Arthroplasty	\N		0.7000	2026-05-07 03:39:52.365+00	\N	\N	2026-05-07 10:39:52.365	 
63	19	\N	JOURNAL_ARTICLE	Debridement, Antibiotic Pearls, and Retention	\N		0.6500	2026-05-07 03:39:52.369+00	\N	\N	2026-05-07 10:39:52.369	 
64	20	56	GUIDELINE	International Consensus Meeting (ICM) 2018 Periprosthetic Joint Infection Diagnostic Criteria	https://www.orthopaedics.org/icm2018/pji-criteria	Major criteria include two positive cultures of the same organism; minor criteria include elevated CRP, ESR, synovial WBC, PMN%, and alpha‑defensin.	0.9600	2026-05-07 03:51:19.874+00	Scoring system, major and minor criteria definitions	\N	2026-05-07 10:51:19.874	 
65	20	57	JOURNAL_ARTICLE	Local Antibiotic Delivery in Periprosthetic Joint Infection: Cement Spacers Loaded with Vancomycin and Carbapenems	https://doi.org/10.1016/j.arth.2022.01.015	Combining vancomycin with meropenem in PMMA spacers provides high local concentrations against both Gram‑positive and Gram‑negative resistant organisms.	0.9400	2026-05-07 03:51:19.876+00	Local antibiotic regimen composition	\N	2026-05-07 10:51:19.876	 
66	20	58	SYSTEMATIC_REVIEW	Management of Multidrug‑Resistant Periprosthetic Joint Infection: Systemic Antibiotic Strategies	https://www.sciencedirect.com/science/article/pii/S1521694221001234	Recommended systemic therapy for MDR PJI includes an initial 6‑week IV course of vancomycin plus a carbapenem, followed by oral linezolid and fosfomycin for consolidation.	0.9500	2026-05-07 03:51:19.877+00	Systemic antibiotic regimen and duration	\N	2026-05-07 10:51:19.877	 
67	20	59	CONSENSUS_STATEMENT	Two‑Stage Revision Arthroplasty for Chronic Periprosthetic Joint Infection	https://www.aaos.org/clinical/2021/two-stage-revision	Two‑stage revision remains the gold standard for chronic PJI, especially when organisms are resistant or biofilm‑forming.	0.9700	2026-05-07 03:51:19.878+00	Surgical strategy recommendation	\N	2026-05-07 10:51:19.878	 
68	21	60	GUIDELINE	International Consensus Meeting (ICM) 2018 Periprosthetic Joint Infection Diagnostic Criteria	\N	The ICM 2018 scoring system assigns major and minor criteria; a total score ≥6 with at least one major criterion defines a definite PJI.	0.9600	2026-05-09 11:48:26.006+00	Cung cấp tiêu chuẩn chẩn đoán ICM 2018 cho mục DIAGNOSTIC_TEST	\N	2026-05-09 11:48:26.006	 
69	21	62	JOURNAL_ARTICLE	Management of Periprosthetic Joint Infection – Antibiotic Strategies	https://doi.org/10.1016/j.arth.2022.01.015	For Gram‑negative PJI, ceftriaxone IV followed by oral fluoroquinolones is recommended, with rifampicin added for biofilm activity.	0.9400	2026-05-09 11:48:26.009+00	Hướng dẫn lựa chọn kháng sinh hệ thống cho E. coli trong mục SYSTEMIC_ANTIBIOTIC	\N	2026-05-09 11:48:26.009	 
70	21	63	SYSTEMATIC_REVIEW	Two‑Stage Revision Arthroplasty for Chronic Periprosthetic Joint Infection	https://doi.org/10.1186/s13018-021-02567-9	Two‑stage exchange remains the gold standard for chronic or early postoperative PJI, especially when the infecting organism is Gram‑negative and biofilm‑forming.	0.9500	2026-05-09 11:48:26.011+00	Lý do lựa chọn chiến lược phẫu thuật TWO_STAGE_REVISION trong mục SURGERY_PROCEDURE	\N	2026-05-09 11:48:26.011	 
71	22	64	GUIDELINE	ICM VIỆT full	\N	ICM 2018 scoring hệ thống tiêu chí major và minor, tổng điểm 0‑9, với 6‑8 điểm được xem là INCONCLUSIVE, cần kết hợp lâm sàng để quyết định.	0.9600	2026-05-09 11:50:02.434+00	Cung cấp tiêu chí chẩn đoán ICM và cách tính điểm cho mục Diagnostic_Test	\N	2026-05-09 11:50:02.434	 
72	22	67	JOURNAL_ARTICLE	One-Stage Septic Revision Arthroplasty	https://example.com/one-stage-septic-revision	One-stage revision có thể được áp dụng cho các bệnh nhân không có mô mềm yếu và sinh vật nhạy cảm, nhưng đối với gram‑negative như E. coli thường ưu tiên two-stage.	0.9200	2026-05-09 11:50:02.436+00	Giải thích lựa chọn two-stage revision trong mục Surgery_Procedure	\N	2026-05-09 11:50:02.436	 
73	22	67	SYSTEMATIC_REVIEW	1.5-Stage Exchange Arthroplasty for Total Knee Arthroplasty Periprosthetic Joint Infections	https://example.com/1.5-stage-exchange	Two-stage exchange remains gold standard for chronic PJI, especially with gram‑negative organisms, providing higher infection‑eradication rates.	0.9400	2026-05-09 11:50:02.437+00	Hỗ trợ khuyến cáo two-stage revision và thời gian điều trị kháng sinh	\N	2026-05-09 11:50:02.437	 
74	22	65	META_ANALYSIS	Antibiotic-loaded cement spacers in PJI	https://example.com/cement-spacer-analysis	Gentamicin combined with vancomycin in PMMA spacers provides broad coverage against gram‑negative and gram‑positive organisms with acceptable elution profiles.	0.9300	2026-05-09 11:50:02.438+00	Lựa chọn Gentamicin + Vancomycin cho Local_Antibiotic	\N	2026-05-09 11:50:02.438	 
75	22	66	JOURNAL_ARTICLE	Management of Gram‑Negative Periprosthetic Joint Infection	https://example.com/gram-negative-pji	Ceftriaxone IV followed by oral ciprofloxacin is an effective regimen for E. coli PJI, with rifampicin added for biofilm activity.	0.9500	2026-05-09 11:50:02.439+00	Phác đồ Systemic_Antibiotic cho E. coli	\N	2026-05-09 11:50:02.439	 
\.


--
-- Data for Name: ai_recommendation_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ai_recommendation_items (id, run_id, category, title, priority_order, is_primary, item_json, created_at, updated_by, updated_at, created_by) FROM stdin;
1	1	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng với hải sản và phấn hoa.", "severity": "HIGH"}, {"type": "DRUG_INTERACTION", "message": "Bệnh nhân đang dùng thuốc kháng sinh nhóm Penicillin.", "severity": "MEDIUM"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Bệnh nhân có biểu hiện nhiễm trùng khớp giả mãn tính do Staphylococcus aureus.", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Có khả năng gây bệnh cao", "biofilm_forming": true, "resistance_detail": "Kết quả xét nghiệm kháng sinh đồ", "resistance_profile": "Nhạy cảm với một số kháng sinh"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có biểu hiện nhiễm trùng mãn tính."}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": false, "criterion": "Có dịch tiết ra từ vết thương", "is_decisive": false, "result_detail": "Không có dịch tiết ra từ vết thương"}, {"result": true, "criterion": "Có 2 hoặc nhiều xét nghiệm nuôi cấy dương tính với cùng một tác nhân", "is_decisive": true, "result_detail": "Nuôi cấy dương tính với Staphylococcus aureus"}], "major_criteria_met": true, "major_criteria_conclusion": "Bệnh nhân có ít nhất một tiêu chí chính dương tính."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí của ICM 2018, bệnh nhân có biểu hiện nhiễm trùng khớp giả."}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng ESR và CRP", "score_weight": 1, "result_detail": "ESR: 18, CRP: 3.2", "score_awarded": 1}, {"result": true, "criterion": "Tăng số lượng bạch cầu trong dịch khớp", "score_weight": 1, "result_detail": "Số lượng bạch cầu: 850", "score_awarded": 1}, {"result": true, "criterion": "Có bạch cầu đa nhân trung tính trong dịch khớp", "score_weight": 1, "result_detail": "Bạch cầu đa nhân trung tính: 22%", "score_awarded": 1}], "total_minor_score": 3, "total_minor_score_note": "Tổng điểm các tiêu chí phụ là 3."}}	2026-04-07 10:57:22.071+00	\N	2026-04-07 17:57:22.071	 
2	1	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Điều trị kháng sinh toàn thân trong 6 tuần.", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh nhóm Cephalosporin", "route": "IV", "dosage": "1g x 3 lần/ngày", "frequency": "3 lần/ngày", "sequence_order": 1, "antibiotic_name": "Cefazolin"}], "phase_order": 1, "duration_note": "Điều trị kháng sinh toàn thân", "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh nhóm Tetracycline", "route": "ORAL", "dosage": "100mg x 2 lần/ngày", "frequency": "2 lần/ngày", "sequence_order": 1, "antibiotic_name": "Doxycycline"}], "phase_order": 2, "duration_note": "Điều trị kháng sinh đường uống", "duration_weeks": 4}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimen_name": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Suy thận nặng", "Dị ứng với kháng sinh"], "total_duration_weeks": 6}	2026-04-07 10:57:22.103+00	\N	2026-04-07 17:57:22.103	 
3	1	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Phẫu thuật hai giai đoạn để loại bỏ nhiễm trùng và phục hồi chức năng khớp.", "stages": [{"stage_name": "Giai đoạn 1: Loại bỏ implant và nhiễm trùng", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra xét nghiệm"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Phục hồi chức năng khớp", "stage_order": 2, "preconditions": ["Kết thúc giai đoạn 1", "Bệnh nhân ổn định"], "interval_from_stage1": "6 tuần", "estimated_duration_minutes": 180}], "priority_note": "Cần phẫu thuật gấp để tránh biến chứng", "priority_level": "HIGH", "strategy_rationale": "Loại bỏ nhiễm trùng và phục hồi chức năng khớp", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng sau phẫu thuật", "Thất bại trong phục hồi chức năng"], "estimated_total_treatment_time": "12 tuần"}	2026-04-07 10:57:22.106+00	\N	2026-04-07 17:57:22.106	 
4	2	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng với hải sản và phấn hoa", "severity": "HIGH"}, {"type": "DRUG_INTERACTION", "message": "Kháng sinh được chọn cần tương thích với bệnh nhân", "severity": "MEDIUM"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Bệnh nhân được chẩn đoán nhiễm trùng khớp giả do Staphylococcus aureus", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Vi khuẩn có khả năng hình thành biofilm", "biofilm_forming": true, "resistance_detail": "Kết quả kháng sinh đồ", "resistance_profile": "Nhạy cảm với một số kháng sinh"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có triệu chứng kéo dài"}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": false, "criterion": "Có dịch tiết ra từ vết thương", "is_decisive": false, "result_detail": "Không có dịch tiết ra từ vết thương"}, {"result": true, "criterion": "Có 2 mẫu nuôi cấy dương tính với cùng một loại vi khuẩn", "is_decisive": true, "result_detail": "Nuôi cấy dương tính với Staphylococcus aureus"}], "major_criteria_met": true, "major_criteria_conclusion": "Đáp ứng tiêu chí chính về nuôi cấy"}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí của ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp giả"}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng ESR và CRP", "score_weight": 2, "result_detail": "ESR: 18 mm/h, CRP: 3.2 mg/L", "score_awarded": 2}, {"result": true, "criterion": "Tăng số lượng bạch cầu trong dịch khớp", "score_weight": 3, "result_detail": "Số lượng bạch cầu: 850 cells/uL", "score_awarded": 3}], "total_minor_score": 5, "total_minor_score_note": "Đáp ứng các tiêu chí phụ"}}	2026-04-07 10:57:22.16+00	\N	2026-04-07 17:57:22.16	 
5	2	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Cần theo dõi và điều chỉnh liều kháng sinh dựa trên chức năng thận", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh hiệu quả đối với Staphylococcus aureus", "route": "IV", "dosage": "2g x 3 lần/ngày", "frequency": "Tiêm tĩnh mạch", "sequence_order": 1, "antibiotic_name": "Cefazolin"}], "phase_order": 1, "duration_note": "Kháng sinh tiêm tĩnh mạch", "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh uống hiệu quả đối với Staphylococcus aureus", "route": "ORAL", "dosage": "100mg x 2 lần/ngày", "frequency": "Uống", "sequence_order": 2, "antibiotic_name": "Doxycycline"}], "phase_order": 2, "duration_note": "Kháng sinh uống", "duration_weeks": 2}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimen_name": "Kháng sinh针对 Staphylococcus aureus", "contraindications": ["Dị ứng với kháng sinh"], "total_duration_weeks": 4}	2026-04-07 10:57:22.165+00	\N	2026-04-07 17:57:22.165	 
6	2	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Cần theo dõi và điều trị sau phẫu thuật", "stages": [{"stage_name": "Giai đoạn 1: Loại bỏ implant và nhiễm trùng", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra nhiễm trùng"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Tái tạo khớp", "stage_order": 2, "preconditions": ["Kiểm tra nhiễm trùng đã khỏi", "Chuẩn bị bệnh nhân"], "interval_from_stage1": "6 tuần", "estimated_duration_minutes": 180}], "priority_note": "Cần thực hiện phẫu thuật càng sớm càng tốt", "priority_level": "HIGH", "strategy_rationale": "Loại bỏ nhiễm trùng và tái tạo khớp", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng tái phát", "Tổn thương thần kinh"], "estimated_total_treatment_time": "12 tuần"}	2026-04-07 10:57:22.169+00	\N	2026-04-07 17:57:22.169	 
7	3	DIAGNOSTIC_TEST	Danh gia chan doan PJI	1	t	{"ai_reasoning": {"warnings": [], "primary_diagnosis": "Can danh gia them", "reasoning_summary": "```json\\n{\\n  \\"recommendation_items\\": [\\n    {\\n      \\"category\\": \\"DIAGNOSTIC_TEST\\",\\n      \\"title\\": \\"Chan doan Nhiem trung Khop gia (PJI)\\",\\n      \\"item_json\\": {\\n        \\"scoring_system\\": {\\n          \\"name\\": \\"ICM 2018 PJI Diagnostic Criteria\\",\\n          \\"version\\": \\"2018 (Philadelphia Consensus)\\",\\n          \\"total_score\\": 6,\\n          \\"interpretation\\": \\"INFECTED\\",\\n          \\"confidence_note\\": \\"Dựa trên các tiêu chí của ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp giả.\\"\\n        },\\n        \\"major_criteria\\": {\\n          \\"note\\": \\"Các tiêu chí chính\\",\\n          \\"items\\": [\\n            {\\n              \\"criterion\\": \\"Sinus tract communicating with the joint\\",\\n              \\"result\\": false,\\n              \\"result_detail\\": \\"Không có dấu hiệu của sinus tract.\\",\\n              \\"is_decisive\\": false\\n            },\\n            {\\n              \\"criterion\\": \\"Hai hoặc nhiều xét nghiệm nuôi cấy dương tính với cùng một tác nhân\\",\\n              \\"result\\": true,\\n              \\"result_detail\\": \\"Nuôi cấy Staphylococcus aureus dương tính.\\",\\n              \\"is_decisive\\": true\\n            }\\n          ],\\n          \\"major_criteria_met\\": true,\\n          \\"major_criteria_conclusion\\": \\"Đáp ứng tiêu chí chính về nuôi cấy.\\"\\n        },\\n        \\"minor_criteria_scoring\\": {\\n          \\"note\\": \\"Các tiêu chí phụ\\",\\n          \\"items\\": [\\n            {\\n              \\"criterion\\": \\"Tăng ESR và CRP\\",\\n              \\"score_weight\\": 1,\\n              \\"result\\": true,\\n              \\"result_detail\\": \\"ESR: 18.0 mm/h, CRP: 3.2 mg/L.\\",\\n              \\"score_awarded\\": 1\\n            },\\n            {\\n              \\"criterion\\": \\"Tăng số lượng bạch cầu trong dịch khớp\\",\\n              \\"score_weight\\": 1,\\n              \\"result\\": true,\\n              \\"result_detail\\": \\"Synovial WBC: 850.0 cells/uL.\\",\\n              \\"score_awarded\\": 1\\n            },\\n            {\\n              \\"criterion\\": \\"Tăng tỷ lệ PMN trong dịch khớp\\",\\n              \\"score_weight\\": 1,\\n              \\"result\\": true,\\n              \\"result_detail\\": \\"Synovial PMN: 22.0%."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018", "total_score": 0, "interpretation": "INCONCLUSIVE", "confidence_note": "AI response khong parse duoc JSON — can danh gia lai"}}	2026-04-07 10:57:22.203+00	\N	2026-04-07 17:57:22.203	 
8	4	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng với hải sản và phấn hoa.", "severity": "HIGH"}, {"type": "DRUG_INTERACTION", "message": "Bệnh nhân đang dùng thuốc kháng sinh nhóm Penicillin.", "severity": "MEDIUM"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Bệnh nhân có biểu hiện nhiễm trùng khớp giả mãn tính do Staphylococcus aureus.", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Không có thông tin chi tiết về độc tính.", "biofilm_forming": false, "resistance_detail": "Không có thông tin chi tiết về kháng thuốc.", "resistance_profile": "Nhạy cảm với kháng sinh."}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có biểu hiện nhiễm trùng khớp giả mãn tính."}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": false, "criterion": "Có dịch tiết ra từ vết thương", "is_decisive": false, "result_detail": "Không có dịch tiết ra từ vết thương."}, {"result": true, "criterion": "Có 2 mẫu nuôi cấy dương tính với cùng một loại vi khuẩn", "is_decisive": true, "result_detail": "Nuôi cấy dương tính với Staphylococcus aureus."}], "major_criteria_met": true, "major_criteria_conclusion": "Bệnh nhân có ít nhất một tiêu chí chính dương tính."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí của ICM 2018, bệnh nhân có biểu hiện nhiễm trùng khớp giả."}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng ESR và CRP", "score_weight": 1, "result_detail": "ESR: 18.0 mm/h, CRP: 3.2 mg/L.", "score_awarded": 1}, {"result": true, "criterion": "Tăng số lượng bạch cầu trong dịch khớp", "score_weight": 1, "result_detail": "Số lượng bạch cầu trong dịch khớp: 850 cells/uL.", "score_awarded": 1}], "total_minor_score": 2, "total_minor_score_note": "Tổng điểm các tiêu chí phụ là 2."}}	2026-04-07 15:48:57.239+00	\N	2026-04-07 22:48:57.239	 
9	4	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Điều trị kháng sinh toàn thân trong 4 tuần.", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh toàn thân giai đoạn tấn công.", "route": "IV", "dosage": "1g x 3 lần/ngày", "frequency": "3 lần/ngày", "sequence_order": 1, "antibiotic_name": "Cefazolin"}], "phase_order": 1, "duration_note": "Điều trị kháng sinh toàn thân trong 2 tuần.", "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh toàn thân giai đoạn duy trì.", "route": "ORAL", "dosage": "500mg x 3 lần/ngày", "frequency": "3 lần/ngày", "sequence_order": 1, "antibiotic_name": "Cefalexin"}], "phase_order": 2, "duration_note": "Điều trị kháng sinh toàn thân trong 2 tuần.", "duration_weeks": 2}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimen_name": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Dị ứng với kháng sinh"], "total_duration_weeks": 4}	2026-04-07 15:48:57.244+00	\N	2026-04-07 22:48:57.244	 
10	4	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Phẫu thuật hai giai đoạn để điều trị nhiễm trùng khớp giả.", "stages": [{"stage_name": "Giai đoạn 1: Loại bỏ implant nhiễm trùng", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Chuẩn bị thiết bị"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Thay thế implant mới", "stage_order": 2, "preconditions": ["Kết quả xét nghiệm tốt", "Bệnh nhân ổn định"], "interval_from_stage1": "Sau 6 tuần", "estimated_duration_minutes": 180}], "priority_note": "Cần phẫu thuật khẩn cấp để loại bỏ nhiễm trùng.", "priority_level": "HIGH", "strategy_rationale": "Loại bỏ implant nhiễm trùng và thay thế bằng implant mới.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng sau phẫu thuật", "Tổn thương thần kinh"], "estimated_total_treatment_time": "12 tuần"}	2026-04-07 15:48:57.247+00	\N	2026-04-07 22:48:57.247	 
11	7	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng với hải sản và phấn hoa.", "severity": "HIGH"}, {"type": "DRUG_INTERACTION", "message": "Bệnh nhân đang dùng thuốc kháng sinh nhóm Penicillin.", "severity": "MEDIUM"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Dựa trên các tiêu chí của ICM 2018 và kết quả xét nghiệm, bệnh nhân được chẩn đoán là có nhiễm trùng khớp giả.", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Vi khuẩn có khả năng hình thành biofilm.", "biofilm_forming": true, "resistance_detail": "Kết quả kháng sinh đồ", "resistance_profile": "Nhạy cảm với một số kháng sinh"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có triệu chứng kéo dài"}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": false, "criterion": "Có dịch tiết ra từ vết thương", "is_decisive": false, "result_detail": "Không có dịch tiết ra từ vết thương"}, {"result": true, "criterion": "Có 2 mẫu nuôi cấy dương tính với cùng một loại vi khuẩn", "is_decisive": true, "result_detail": "Nuôi cấy dương tính với Staphylococcus aureus"}], "major_criteria_met": true, "major_criteria_conclusion": "Đáp ứng tiêu chí chính về nuôi cấy."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí của ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp giả."}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng ESR và CRP", "score_weight": 2, "result_detail": "ESR: 18, CRP: 3.2", "score_awarded": 2}, {"result": true, "criterion": "Tăng số lượng bạch cầu trong dịch khớp", "score_weight": 3, "result_detail": "Số lượng bạch cầu: 850", "score_awarded": 3}], "total_minor_score": 5, "total_minor_score_note": "Đáp ứng các tiêu chí phụ."}}	2026-04-08 16:37:36.593+00	\N	2026-04-08 23:37:36.593	 
12	7	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Điều chỉnh liều theo chức năng thận.", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh nhóm cephalosporin thế hệ 3.", "route": "IV", "dosage": "2g x 1 lần/ngày", "frequency": "1 lần/ngày", "sequence_order": 1, "antibiotic_name": "Ceftriaxone"}], "phase_order": 1, "duration_note": "Kháng sinh tiêm tĩnh mạch", "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh nhóm fluoroquinolone.", "route": "ORAL", "dosage": "500mg x 2 lần/ngày", "frequency": "2 lần/ngày", "sequence_order": 1, "antibiotic_name": "Ciprofloxacin"}], "phase_order": 2, "duration_note": "Kháng sinh đường uống", "duration_weeks": 4}], "indication": "Nhiễm trùng khớp giả", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimen_name": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Suy thận nặng", "Dị ứng với kháng sinh"], "total_duration_weeks": 6}	2026-04-08 16:37:36.643+00	\N	2026-04-08 23:37:36.643	 
13	7	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Cần theo dõi chặt chẽ bệnh nhân sau phẫu thuật.", "stages": [{"stage_name": "Giai đoạn 1: Loại bỏ implant và nhiễm trùng", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra nhiễm trùng"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Tái tạo khớp", "stage_order": 2, "preconditions": ["Kiểm tra nhiễm trùng đã khỏi"], "interval_from_stage1": "6 tuần", "estimated_duration_minutes": 180}], "priority_note": "Cần thực hiện phẫu thuật càng sớm càng tốt.", "priority_level": "HIGH", "strategy_rationale": "Loại bỏ nhiễm trùng và tái tạo khớp.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Suy nhiễm trùng", "Thất bại trong việc loại bỏ nhiễm trùng"], "estimated_total_treatment_time": "12 tuần"}	2026-04-08 16:37:36.65+00	\N	2026-04-08 23:37:36.65	 
14	8	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng với hải sản và phấn hoa.", "severity": "HIGH"}, {"type": "DRUG_INTERACTION", "message": "Kháng sinh được chỉ định cần được theo dõi chặt chẽ.", "severity": "MEDIUM"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Dựa trên các tiêu chí của ICM 2018 và kết quả xét nghiệm.", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Có khả năng gây bệnh cao.", "biofilm_forming": true, "resistance_detail": "Kết quả xét nghiệm kháng sinh đồ.", "resistance_profile": "Nhạy cảm với một số kháng sinh."}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có triệu chứng kéo dài."}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": false, "criterion": "Có dịch tiết ra từ vết thương", "is_decisive": false, "result_detail": "Không có dịch tiết ra từ vết thương."}, {"result": true, "criterion": "Có 2 hoặc nhiều xét nghiệm nuôi cấy dương tính với cùng một tác nhân", "is_decisive": true, "result_detail": "Nuôi cấy dương tính với Staphylococcus aureus."}], "major_criteria_met": true, "major_criteria_conclusion": "Đáp ứng tiêu chí chính về nuôi cấy."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí của ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp giả."}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng ESR và CRP", "score_weight": 2, "result_detail": "ESR: 18, CRP: 3.2", "score_awarded": 2}, {"result": true, "criterion": "Tăng số lượng bạch cầu trong dịch khớp", "score_weight": 3, "result_detail": "Số lượng bạch cầu: 850 cells/uL", "score_awarded": 3}], "total_minor_score": 5, "total_minor_score_note": "Đáp ứng các tiêu chí phụ."}}	2026-04-08 16:38:27.894+00	\N	2026-04-08 23:38:27.894	 
15	8	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Cần theo dõi và điều chỉnh liều.", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Theo dõi chức năng thận.", "route": "IV", "dosage": "2g IV mỗi 8 giờ", "frequency": "3 lần/ngày", "sequence_order": 1, "antibiotic_name": "Cefazolin"}], "phase_order": 1, "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Theo dõi tác dụng phụ.", "route": "ORAL", "dosage": "500mg uống mỗi 6 giờ", "frequency": "4 lần/ngày", "sequence_order": 2, "antibiotic_name": "Cefalexin"}], "phase_order": 2, "duration_weeks": 2}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Chức năng thận", "Tác dụng phụ"], "regimen_name": "Phác đồ điều trị Staphylococcus aureus", "contraindications": ["Dị ứng với kháng sinh"], "total_duration_weeks": 4}	2026-04-08 16:38:27.899+00	\N	2026-04-08 23:38:27.899	 
16	8	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Cần thảo luận kỹ với bệnh nhân về kế hoạch điều trị.", "stages": [{"stage_name": "Giai đoạn 1: Loại bỏ implant và nhiễm trùng", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra xét nghiệm"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Tái tạo khớp", "stage_order": 2, "preconditions": ["Kiểm tra nhiễm trùng đã được kiểm soát"], "interval_from_stage1": "6 tuần", "estimated_duration_minutes": 180}], "priority_note": "Cần thực hiện sớm để tránh biến chứng.", "priority_level": "HIGH", "strategy_rationale": "Loại bỏ nhiễm trùng và tái tạo khớp.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng tái phát", "Thất bại trong tái tạo khớp"], "estimated_total_treatment_time": "Khoảng 12 tuần"}	2026-04-08 16:38:27.904+00	\N	2026-04-08 23:38:27.904	 
28	12	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng với hải sản và phấn hoa", "severity": "HIGH"}, {"type": "DRUG_INTERACTION", "message": "Bệnh nhân đang dùng thuốc kháng sinh nhóm Penicillin", "severity": "MEDIUM"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Bệnh nhân được chẩn đoán nhiễm trùng khớp giả do Staphylococcus aureus", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Vi khuẩn có khả năng hình thành biofilm", "biofilm_forming": true, "resistance_detail": "Kết quả kháng sinh đồ", "resistance_profile": "Nhạy cảm với một số kháng sinh"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có triệu chứng kéo dài"}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": false, "criterion": "Có dịch tiết ra từ vết thương", "is_decisive": false, "result_detail": "Không có dịch tiết ra từ vết thương"}, {"result": true, "criterion": "Có 2 mẫu nuôi cấy dương tính với cùng một loại vi khuẩn", "is_decisive": true, "result_detail": "Nuôi cấy dương tính với Staphylococcus aureus"}], "major_criteria_met": true, "major_criteria_conclusion": "Đáp ứng tiêu chí chính về nuôi cấy"}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí của ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp giả"}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng ESR và CRP", "score_weight": 2, "result_detail": "ESR: 18, CRP: 3.2", "score_awarded": 2}, {"result": true, "criterion": "Tăng số lượng bạch cầu trong dịch khớp", "score_weight": 3, "result_detail": "Số lượng bạch cầu: 850", "score_awarded": 3}], "total_minor_score": 5, "total_minor_score_note": "Đáp ứng các tiêu chí phụ"}}	2026-04-09 03:57:31.011+00	\N	2026-04-09 10:57:31.011	 
29	12	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Cân nhắc điều chỉnh liều dựa trên chức năng thận", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh ban đầu", "route": "IV", "dosage": "1g x 3 lần/ngày", "frequency": "IV", "sequence_order": 1, "antibiotic_name": "Cefazolin"}], "phase_order": 1, "duration_note": "Điều trị ban đầu", "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh duy trì", "route": "ORAL", "dosage": "100mg x 2 lần/ngày", "frequency": "ORAL", "sequence_order": 1, "antibiotic_name": "Doxycycline"}], "phase_order": 2, "duration_note": "Tiếp tục điều trị", "duration_weeks": 2}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimen_name": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Dị ứng với kháng sinh"], "total_duration_weeks": 4}	2026-04-09 03:57:31.02+00	\N	2026-04-09 10:57:31.02	 
30	12	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Cân nhắc kỹ lưỡng trước khi phẫu thuật", "stages": [{"stage_name": "Giai đoạn 1: Loại bỏ implant và nhiễm trùng", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra nhiễm trùng"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Tái tạo khớp", "stage_order": 2, "preconditions": ["Kiểm tra nhiễm trùng đã khỏi", "Chuẩn bị bệnh nhân"], "interval_from_stage1": 6, "estimated_duration_minutes": 180}], "priority_note": "Cần phẫu thuật gấp", "priority_level": "HIGH", "strategy_rationale": "Loại bỏ nhiễm trùng và tái tạo khớp", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng tái phát", "Tổn thương thần kinh"], "estimated_total_treatment_time": "Khoảng 12 tuần"}	2026-04-09 03:57:31.03+00	\N	2026-04-09 10:57:31.03	 
31	13	DIAGNOSTIC_TEST	Tiêu đề chẩn đoán nhiễm trùng khớp háng phải	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng hải sản (tôm, cua) và phấn hoa, cần lưu ý khi sử dụng kháng sinh.", "severity": "HIGH"}], "primary_diagnosis": "Nhiễm trùng khớp háng phải", "reasoning_summary": "Dựa trên các tiêu chí ICM 2018 và thông tin lâm sàng, bệnh nhân được chẩn đoán nhiễm trùng khớp háng phải mãn tính do Staphylococcus aureus kháng Methicillin.", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Cần lưu ý đến khả năng hình thành biofilm của vi khuẩn.", "biofilm_forming": true, "resistance_detail": "Kháng Clindamycin và Ciprofloxacin", "resistance_profile": "Kháng Methicillin"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có triệu chứng kéo dài 2 tuần."}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": true, "criterion": "Có dấu hiệu lâm sàng của nhiễm trùng (sưng, nóng, đỏ, đau)", "is_decisive": true, "result_detail": "Bệnh nhân có dấu hiệu sưng nhẹ, nóng tại chỗ và đau tăng dần vùng khớp háng phải."}, {"result": true, "criterion": "Có kết quả xét nghiệm CRP và ESR tăng cao", "is_decisive": true, "result_detail": "CRP: 138.2 mg/L, ESR: 6.0 mm/h"}], "major_criteria_met": true, "major_criteria_conclusion": "Hai tiêu chí chính đều dương tính."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp háng phải."}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Có bạch cầu tăng cao", "score_weight": 1, "result_detail": "WBC: 12.26 G/L", "score_awarded": 1}, {"result": true, "criterion": "Có kết quả nuôi cấy dương tính", "score_weight": 2, "result_detail": "Nuôi cấy Staphylococcus aureus", "score_awarded": 2}], "total_minor_score": 3, "total_minor_score_note": "Tổng điểm các tiêu chí phụ là 3."}}	2026-04-11 13:54:32.61+00	\N	2026-04-11 20:54:32.61	 
32	13	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Cần theo dõi và điều chỉnh liều kháng sinh dựa trên chức năng thận và gan của bệnh nhân.", "phases": [{"phase_name": "Giai đoạn tấn công (Induction/IV phase)", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh glycopeptide, hiệu quả đối với Staphylococcus aureus kháng Methicillin.", "route": "IV", "dosage": "1g x 2 lần/ngày", "frequency": "IV", "sequence_order": 1, "antibiotic_name": "Vancomycin"}, {"role": "SYNERGISTIC", "notes": "Tăng cường hiệu quả điều trị và giảm thiểu kháng kháng sinh.", "route": "ORAL", "dosage": "450mg x 1 lần/ngày", "frequency": "ORAL", "sequence_order": 2, "antibiotic_name": "Rifampicin"}], "phase_order": 1, "duration_note": "Sử dụng kháng sinh tĩnh mạch trong 2 tuần.", "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì (Oral phase)", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Tiếp tục sử dụng Rifampicin đường uống.", "route": "ORAL", "dosage": "450mg x 1 lần/ngày", "frequency": "ORAL", "sequence_order": 1, "antibiotic_name": "Rifampicin"}, {"role": "SYNERGISTIC", "notes": "Mặc dù có kết quả kháng Ciprofloxacin in vitro, nhưng vẫn có thể sử dụng với liều cao và theo dõi chặt chẽ.", "route": "ORAL", "dosage": "500mg x 2 lần/ngày", "frequency": "ORAL", "sequence_order": 2, "antibiotic_name": "Ciprofloxacin"}], "phase_order": 2, "duration_note": "Chuyển sang kháng sinh đường uống trong 4 tuần.", "duration_weeks": 4}], "indication": "Nhiễm trùng khớp háng phải do Staphylococcus aureus kháng Methicillin", "monitoring": ["Theo dõi chức năng thận, gan và công thức máu"], "regimen_name": "Phác đồ điều trị nhiễm trùng khớp háng phải", "contraindications": ["Bệnh nhân có tiền sử bệnh gan nặng"], "total_duration_weeks": 6}	2026-04-11 13:54:32.616+00	\N	2026-04-11 20:54:32.616	 
33	13	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Cần thảo luận kỹ với bệnh nhân về các rủi ro và biến chứng có thể xảy ra.", "stages": [{"stage_name": "Giai đoạn 1: Tháo bỏ implant và đặt spacer", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân với kháng sinh dự phòng"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Cấy ghép lại implant sau 6 tuần", "stage_order": 2, "preconditions": ["Kháng sinh toàn thân trong 6 tuần"], "interval_from_stage1": 6, "estimated_duration_minutes": 180}], "priority_note": "Cần thực hiện phẫu thuật càng sớm càng tốt để tránh biến chứng.", "priority_level": "HIGH", "strategy_rationale": "Bệnh nhân có nhiễm trùng khớp háng phải mãn tính do Staphylococcus aureus kháng Methicillin, cần phẫu thuật tái tạo hai giai đoạn.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng vết mổ, tổn thương dây thần kinh, tái phát nhiễm trùng"], "estimated_total_treatment_time": "Khoảng 12 tuần"}	2026-04-11 13:54:32.619+00	\N	2026-04-11 20:54:32.619	 
34	14	DIAGNOSTIC_TEST	Đánh giá chẩn đoán nhiễm trùng khớp giả	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Bệnh nhân dị ứng hải sản và phấn hoa", "severity": "HIGH"}], "primary_diagnosis": "Nhiễm trùng khớp giả", "reasoning_summary": "Bệnh nhân được chẩn đoán nhiễm trùng khớp giả do Staphylococcus aureus", "identified_organism": {"name": "Staphylococcus aureus", "virulence_note": "Cần theo dõi chặt chẽ", "biofilm_forming": true, "resistance_detail": "Kháng Clindamycin, Ciprofloxacin", "resistance_profile": "Kháng Methicillin"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Bệnh nhân có triệu chứng kéo dài 2 tuần"}, "major_criteria": {"note": "Các tiêu chí chính", "items": [{"result": true, "criterion": "Sốt", "is_decisive": true, "result_detail": "Bệnh nhân có sốt nhẹ 37.8°C"}, {"result": true, "criterion": "Đau khớp", "is_decisive": true, "result_detail": "Bệnh nhân đau tăng dần vùng khớp háng phải"}, {"result": false, "criterion": "Sưng và nóng tại chỗ", "is_decisive": false, "result_detail": "Bệnh nhân có sưng nhẹ, nóng tại chỗ"}], "major_criteria_met": true, "major_criteria_conclusion": "Bệnh nhân có các triệu chứng khớp giả"}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 6, "interpretation": "INFECTED", "confidence_note": "Dựa trên các tiêu chí ICM 2018, bệnh nhân được đánh giá là có nhiễm trùng khớp giả"}, "minor_criteria_scoring": {"note": "Các tiêu chí phụ", "items": [{"result": true, "criterion": "Tăng bạch cầu", "score_weight": 1, "result_detail": "WBC: 12.26 G/L", "score_awarded": 1}, {"result": true, "criterion": "Tăng CRP", "score_weight": 1, "result_detail": "CRP: 138.2 mg/L", "score_awarded": 1}, {"result": true, "criterion": "Kết quả nuôi cấy dương tính", "score_weight": 2, "result_detail": "Nuôi cấy Staphylococcus aureus", "score_awarded": 2}], "total_minor_score": 4, "total_minor_score_note": "Tổng điểm các tiêu chí phụ"}}	2026-04-11 14:34:25.849+00	\N	2026-04-11 21:34:25.849	 
35	14	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh toàn thân	2	f	{"notes": "Cân nhắc điều chỉnh liều theo chức năng thận", "phases": [{"phase_name": "Giai đoạn tấn công", "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh phổ rộng", "route": "IV", "dosage": "1g x 2 lần/ngày", "frequency": "IV", "sequence_order": 1, "antibiotic_name": "Vancomycin"}, {"role": "SYNERGISTIC", "notes": "Tác dụng hiệp đồng", "route": "PO", "dosage": "450mg x 1 lần/ngày", "frequency": "PO", "sequence_order": 2, "antibiotic_name": "Rifampicin"}], "phase_order": 1, "duration_weeks": 2}, {"phase_name": "Giai đoạn duy trì", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh uống", "route": "PO", "dosage": "500mg x 2 lần/ngày", "frequency": "PO", "sequence_order": 1, "antibiotic_name": "Ciprofloxacin"}], "phase_order": 2, "duration_weeks": 4}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimen_name": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Suy thận nặng"], "total_duration_weeks": 6}	2026-04-11 14:34:25.852+00	\N	2026-04-11 21:34:25.852	 
36	14	SURGERY_PROCEDURE	Phác đồ phẫu thuật	3	f	{"notes": "Cần theo dõi chặt chẽ bệnh nhân", "stages": [{"stage_name": "Giai đoạn 1: Tháo bỏ implant", "stage_order": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra nhiễm trùng"], "interval_from_stage1": null, "estimated_duration_minutes": 120}, {"stage_name": "Giai đoạn 2: Lắp đặt implant mới", "stage_order": 2, "preconditions": ["Kiểm tra nhiễm trùng âm tính"], "interval_from_stage1": 6, "estimated_duration_minutes": 180}], "priority_note": "Cần phẫu thuật khẩn cấp", "priority_level": "HIGH", "strategy_rationale": "Nhiễm trùng khớp giả mạn tính", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Suy nhiễm trùng", "Thất bại implant"], "estimated_total_treatment_time": "12 tuần"}	2026-04-11 14:34:25.856+00	\N	2026-04-11 21:34:25.856	 
52	19	DIAGNOSTIC_TEST	Repeat Synovial Fluid Analysis with Alpha‑Defensin and Cell Count	1	t	{"timing": "Within 48 h prior to planned re‑implantation", "purpose": "Confirm ongoing infection and quantify inflammatory burden before the next surgical stage.", "components": ["Synovial fluid aspiration under sterile conditions", "Leukocyte count and differential", "Alpha‑defensin lateral flow assay", "Gram stain and culture (including anaerobes)"], "interpretation": "Alpha‑defensin positive or leukocyte count > 3,000 cells/µL supports persistent infection."}	2026-05-07 03:39:52.342+00	\N	2026-05-07 10:39:52.342	 
53	19	LOCAL_ANTIBIOTIC	Antibiotic‑Loaded Cement Spacer (Vancomycin + Meropenem)	2	f	{"duration": "Maintained for the interval between stages (6–12 weeks)", "rationale": "Provides high local concentrations exceeding MICs while systemic toxicity remains low.", "antibiotics": [{"agent": "Vancomycin", "target": "Gram‑positive organisms, especially MRSA/MSSA", "dose_per_spacer": "4 g"}, {"agent": "Meropenem", "target": "Gram‑negative organisms, including ESBL‑risk Klebsiella", "dose_per_spacer": "2 g"}], "spacer_type": "Articulating cement spacer"}	2026-05-07 03:39:52.347+00	\N	2026-05-07 10:39:52.347	 
54	19	SYSTEMIC_ANTIBIOTIC	IV Vancomycin plus Meropenem (Phase IV Therapy)	3	f	{"regimen": [{"dose": "15 mg/kg IV q12h (adjusted to trough 15–20 µg/mL)", "agent": "Vancomycin", "duration": "6 weeks"}, {"dose": "1 g IV q8h", "agent": "Meropenem", "duration": "6 weeks"}], "rationale": "Both organisms are susceptible; combination covers both Gram‑positive and Gram‑negative pathogens and prevents emergence of resistance during the chronic phase.", "monitoring": ["Renal function (creatinine, eGFR) q48 h", "Vancomycin trough levels", "Liver enzymes for meropenem"]}	2026-05-07 03:39:52.35+00	\N	2026-05-07 10:39:52.35	 
55	19	SURGERY_PROCEDURE	Two‑Stage Exchange Arthroplasty	4	f	{"stage_1": {"goals": "Eradicate biofilm, allow local antibiotic delivery", "procedure": "Removal of all prosthetic components, extensive debridement, placement of antibiotic‑loaded cement spacer"}, "stage_2": {"timing": "Typically 8–12 weeks after stage 1", "procedure": "Re‑implantation of new prosthesis after infection control confirmed by labs and repeat aspiration"}, "evidence": "Two‑stage exchange remains the gold standard for chronic PJIs, especially with mixed Gram‑positive/Gram‑negative flora.", "interim_management": {"antibiotics": "IV Vancomycin + Meropenem for 6 weeks followed by oral suppression if needed", "rehabilitation": "Partial weight‑bearing with spacer in situ"}}	2026-05-07 03:39:52.354+00	\N	2026-05-07 10:39:52.354	 
56	20	DIAGNOSTIC_TEST	Chẩn đoán AI - Đánh giá nhiễm trùng khớp giả theo ICM 2018 Scoring	1	t	{"ai_reasoning": {"warnings": [{"type": "DRUG_INTERACTION", "message": "Cần theo dõi nồng độ Vancomycin khi dùng đồng thời với Meropenem.", "severity": "MEDIUM"}], "primary_diagnosis": "Definite Periprosthetic Joint Infection", "reasoning_summary": "Kết hợp các tiêu chí major và minor đạt tổng điểm 9, cùng với kết quả nuôi cấy đa kháng, cho thấy nhiễm trùng chắc chắn và cần can thiệp đa mô.", "identified_organism": {"name": "Klebsiella pneumoniae / Staphylococcus aureus", "virulence_note": "Cả hai loài đều có khả năng tạo biofilm trên bề mặt prosthetic.", "biofilm_forming": true, "resistance_detail": "Klebsiella: kháng Tobramycin, Amikacin, Ciprofloxacin; Staphylococcus aureus: kháng Clindamycin, Ciprofloxacin.", "resistance_profile": "MULTI-DRUG RESISTANT"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Thời gian xuất hiện >3 tháng và đa vi khuẩn kháng thuốc."}, "major_criteria": {"items": [{"result": true, "criterion": "≥ 2 mẫu nuôi cấy dương tính cùng một vi khuẩn", "is_decisive": true, "result_detail": "Klebsiella pneumoniae và Staphylococcus aureus được phát hiện trong 2 mẫu độc lập."}, {"result": false, "criterion": "Đường rò thông với khớp giả", "is_decisive": false, "result_detail": "Không có bằng chứng hình ảnh cho thấy rò rỉ."}], "major_criteria_met": true, "major_criteria_conclusion": "Đủ tiêu chuẩn major, xác định nhiễm trùng."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 9, "interpretation": "INFECTED", "confidence_note": "Điểm cao (>6) cho thấy xác suất nhiễm trùng rất chắc chắn."}, "minor_criteria_scoring": {"note": "Tính điểm các tiêu chí phụ (minor) theo ICM 2018", "items": [{"result": true, "criterion": "Serum CRP (>10 mg/L) or D-Dimer (>860 ng/mL)", "score_weight": 2, "result_detail": "CRP = 45 mg/L.", "score_awarded": 2}, {"result": true, "criterion": "Tốc độ máu lắng tăng ESR (>30 mm/h)", "score_weight": 1, "result_detail": "ESR = 55 mm/h.", "score_awarded": 1}, {"result": true, "criterion": "Synovial WBC (>3000 cells/μL) or Leukocyte Esterase (++)", "score_weight": 3, "result_detail": "WBC = 4200 cells/μL, Esterase ++.", "score_awarded": 3}, {"result": true, "criterion": "Synovial PMN% (>80%)", "score_weight": 2, "result_detail": "PMN% = 88%.", "score_awarded": 2}, {"result": true, "criterion": "Positive Alpha-Defensin", "score_weight": 3, "result_detail": "Alpha‑defensin dương tính.", "score_awarded": 3}, {"result": true, "criterion": "Elevated Serum IL-6 (>10 pg/mL)", "criterion_vi": "IL-6 huyết thanh tăng", "score_weight": 1, "result_detail": "IL‑6 = 22 pg/mL.", "score_awarded": 1}, {"result": false, "criterion": "1 mẫu nuôi cấy dương tính đơn lẻ", "score_weight": 2, "result_detail": "Không có mẫu đơn lẻ dương tính.", "score_awarded": 0}, {"result": null, "criterion": "Giải phẫu bệnh dương tính (>5 PMN per HPF)", "score_weight": 3, "result_detail": "Chưa thực hiện sinh thiết mô.", "score_awarded": 0}], "total_minor_score": 12, "total_minor_score_note": "Tổng điểm minor >6 củng cố chẩn đoán nhiễm trùng."}}	2026-05-07 03:51:19.863+00	\N	2026-05-07 10:51:19.863	 
57	20	LOCAL_ANTIBIOTIC	Phác đồ kháng sinh tại chỗ - Vancomycin + Meropenem cement spacer	2	f	{"notes": "Spacer nên được thay thế bằng prosthetic mới sau khi nhiễm trùng được kiểm soát.", "indication": "Hỗ trợ điều trị PJI đa kháng sau phẫu thuật giai đoạn 1 (spacer đặt)", "monitoring": ["Kiểm tra nồng độ vancomycin trong máu nếu có rò rỉ cement", "Đánh giá chức năng thận hàng tuần"], "antibiotics": [{"role": "PRIMARY", "notes": "Đảm bảo nồng độ cao tại vị trí nhiễm trùng, hoạt động chống Gram‑positive.", "route": "LOCAL_CEMENT", "dosage": "2 g", "frequency": "Một lần duy nhất trong hỗn hợp", "sequence_order": 1, "antibiotic_name": "Vancomycin"}, {"role": "SYNERGISTIC", "notes": "Phủ rộng Gram‑negative, bao gồm Klebsiella kháng nhiều thuốc.", "route": "LOCAL_CEMENT", "dosage": "2 g", "frequency": "Một lần duy nhất trong hỗn hợp", "sequence_order": 2, "antibiotic_name": "Meropenem"}], "regimen_name": "Vancomycin + Meropenem Loaded Cement Spacer", "delivery_info": {"spacer_type": "STATIC", "mixing_ratio": "Vancomycin 2 g + Meropenem 2 g per 40 g PMMA", "delivery_method": "CEMENT_SPACER", "cement_brand_suggestion": "Palacos R+G"}, "duration_days": 42, "duration_note": "Thời gian spacer thường được duy trì 6‑8 tuần trước khi tái cấy prosthetic.", "contraindications": ["Dị ứng với glycopeptide hoặc carbapenem", "Suy thận nặng (CrCl <30 mL/phút)"]}	2026-05-07 03:51:19.869+00	\N	2026-05-07 10:51:19.869	 
58	20	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh hệ thống - IV 6 tuần + Oral 6 tuần	3	f	{"notes": "Điều chỉnh liều dựa trên mức độ chức năng thận và mức độ nhiễm trùng lâm sàng.", "phases": [{"phase_name": "Giai đoạn tấn công (Induction/IV phase)", "antibiotics": [{"role": "PRIMARY", "notes": "Đối với Staphylococcus aureus (MRSA/MSSA).", "route": "IV", "dosage": "15‑20 mg/kg mỗi 12 giờ", "frequency": "Hai lần mỗi ngày", "sequence_order": 1, "antibiotic_name": "Vancomycin"}, {"role": "SYNERGISTIC", "notes": "Hoạt động mạnh với Klebsiella pneumoniae kháng nhiều thuốc.", "route": "IV", "dosage": "1 g mỗi 8 giờ", "frequency": "Ba lần mỗi ngày", "sequence_order": 2, "antibiotic_name": "Meropenem"}], "phase_order": 1, "duration_note": "Thời gian đủ để tiêu diệt vi khuẩn trong biofilm sau phẫu thuật.", "duration_weeks": 6}, {"phase_name": "Giai đoạn duy trì (Oral/Consolidation phase)", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Hiệu quả với Staphylococcus aureus, thâm nhập tốt vào mô.", "route": "ORAL", "dosage": "600 mg mỗi 12 giờ", "frequency": "Hai lần mỗi ngày", "sequence_order": 1, "antibiotic_name": "Linezolid"}, {"role": "BIOFILM_AGENT", "notes": "Hoạt động chống biofilm, có tác dụng đối với Klebsiella.", "route": "ORAL", "dosage": "3 g mỗi 24 giờ", "frequency": "Một lần mỗi ngày", "sequence_order": 2, "antibiotic_name": "Fosfomycin"}], "phase_order": 2, "duration_note": "Tiếp tục ủi ổ nhiễm trùng và ngăn ngừa tái phát.", "duration_weeks": 6}], "indication": "Điều trị toàn thân cho PJI do Klebsiella pneumoniae và Staphylococcus aureus đa kháng", "monitoring": ["Nồng độ Vancomycin (trough) mỗi 48‑72 giờ", "Chức năng thận và gan hàng tuần", "CBC để phát hiện pancytopenia (đối với Linezolid)"], "regimen_name": "IV Induction → Oral Consolidation for Multi‑Drug Resistant PJI", "contraindications": ["Dị ứng với bất kỳ thuốc nào trong phác đồ", "Suy thận nặng (đối với Vancomycin, Meropenem)", "Suy gan nặng (đối với Linezolid)"], "total_duration_weeks": 12}	2026-05-07 03:51:19.871+00	\N	2026-05-07 10:51:19.871	 
59	20	SURGERY_PROCEDURE	Phác đồ phẫu thuật - Two-stage revision arthroplasty	4	f	{"notes": "Cần đánh giá lại bằng xét nghiệm CRP/ESR và dịch khớp trước khi thực hiện giai đoạn 2.", "stages": [{"stage_name": "Giai đoạn 1 - Tháo khớp giả & đặt spacer kháng sinh", "stage_order": 1, "estimated_duration_minutes": 180}, {"stage_name": "Giai đoạn 2 - Tháo spacer & thay khớp giả mới (Reimplantation)", "stage_order": 2, "estimated_duration_minutes": 210}], "priority_note": "Nguy cơ lan rộng và tổn thương mô nếu trì hoãn.", "priority_level": "HIGH", "strategy_rationale": "PJI mạn tính với vi khuẩn đa kháng, yêu cầu loại bỏ prosthetic hiện tại, đặt spacer kháng sinh, sau đó tái cấy khi nhiễm trùng được kiểm soát.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng tái phát", "Tháo dỡ mô và mất xương", "Biến chứng tim mạch do phẫu thuật dài"], "estimated_total_treatment_time": "4‑6 tháng (bao gồm thời gian spacer và hồi phục)"}	2026-05-07 03:51:19.873+00	\N	2026-05-07 10:51:19.873	 
60	21	DIAGNOSTIC_TEST	Chẩn đoán AI - Đánh giá nhiễm trùng khớp giả theo ICM 2018 Scoring	1	t	{"ai_reasoning": {"warnings": [{"type": "ALLERGY_ALERT", "message": "Kiểm tra tiền sử dị ứng beta‑lactam trước khi dùng Ceftriaxone.", "severity": "LOW"}], "primary_diagnosis": "Definite Periprosthetic Joint Infection", "reasoning_summary": "Kết hợp các chỉ số viêm, kết quả dịch khớp và phát hiện E. coli nhạy cảm với đa số kháng sinh, cho thấy nhiễm trùng khớp giả chắc chắn.", "identified_organism": {"name": "Escherichia coli", "virulence_note": "E. coli có khả năng tạo biofilm trên bề mặt prosthetic, tăng độ khó trong điều trị.", "biofilm_forming": true, "resistance_detail": "Only Ampicillin shows resistance; all other tested agents are susceptible.", "resistance_profile": "Resistant to Ampicillin; Sensitive to Amoxicillin-Clavulanate, Cefazolin, Ceftriaxone, Ciprofloxacin, Gentamicin, Meropenem, Piperacillin-Tazobactam"}, "infection_classification": "ACUTE", "infection_classification_reasoning": "Bệnh xuất hiện trong vòng 90 ngày sau phẫu thuật, đáp ứng tiêu chí thời gian cấp tính."}, "major_criteria": {"items": [{"result": false, "criterion": "≥ 2 mẫu nuôi cấy dương tính cùng một vi khuẩn", "is_decisive": true, "result_detail": "Chỉ có một mẫu nuôi cấy dương tính E. coli."}, {"result": false, "criterion": "Đường rò thông với khớp giả", "is_decisive": false, "result_detail": "Không có bằng chứng rò rỉ trên hình ảnh."}], "major_criteria_met": false, "major_criteria_conclusion": "Không đáp ứng tiêu chí major, nhưng các tiêu chí minor đủ để chẩn đoán PJI."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 9, "interpretation": "INFECTED", "confidence_note": "Điểm cao dựa trên nhiều tiêu chí phụ dương tính, mặc dù không có tiêu chí major đủ tiêu chuẩn."}, "minor_criteria_scoring": {"note": "Tính điểm các tiêu chí phụ (minor) theo ICM 2018", "items": [{"result": true, "criterion": "Serum CRP (>10 mg/L) or D-Dimer (>860 ng/mL)", "score_weight": 2, "result_detail": "CRP = 45 mg/L.", "score_awarded": 2}, {"result": true, "criterion": "Tốc độ máu lắng tăng ESR (>30 mm/h)", "score_weight": 1, "result_detail": "ESR = 55 mm/h.", "score_awarded": 1}, {"result": true, "criterion": "Synovial WBC (>3000 cells/μL) or Leukocyte Esterase (++)", "score_weight": 3, "result_detail": "WBC = 8200 cells/μL, Leukocyte Esterase ++.", "score_awarded": 3}, {"result": true, "criterion": "Synovial PMN% (>80%)", "score_weight": 2, "result_detail": "PMN% = 88%.", "score_awarded": 2}, {"result": true, "criterion": "Positive Alpha-Defensin", "score_weight": 3, "result_detail": "Alpha‑Defensin test positive.", "score_awarded": 3}, {"result": true, "criterion": "Elevated Serum IL-6 (>10 pg/mL)", "criterion_vi": "IL-6 huyết thanh tăng", "score_weight": 1, "result_detail": "IL‑6 = 22 pg/mL.", "score_awarded": 1}, {"result": false, "criterion": "1 mẫu nuôi cấy dương tính đơn lẻ", "score_weight": 2, "result_detail": "Không có mẫu nuôi cấy đơn lẻ dương tính.", "score_awarded": 0}, {"result": null, "criterion": "Giải phẫu bệnh dương tính (>5 PMN per HPF)", "score_weight": 3, "result_detail": "Chưa thực hiện sinh thiết mô.", "score_awarded": 0}], "total_minor_score": 12, "total_minor_score_note": "Tổng điểm minor >6, đáp ứng tiêu chuẩn chẩn đoán PJI."}}	2026-05-09 11:48:25.993+00	\N	2026-05-09 11:48:25.993	 
61	21	LOCAL_ANTIBIOTIC	Phác đồ kháng sinh tại chỗ - Gentamicin + Cefazolin cement spacer	2	f	{"notes": "Spacer được đặt trong ca phẫu thuật giai đoạn 1 và sẽ được tháo ra trong giai đoạn 2 khi nhiễm trùng được kiểm soát.", "indication": "Hỗ trợ điều trị nhiễm trùng khớp giả do E. coli trong giai đoạn hai‑giai đoạn.", "monitoring": ["Đánh giá mức độ đau và viêm tại vị trí spacer", "Kiểm tra chức năng thận (creatinine) mỗi 2 tuần"], "antibiotics": [{"role": "PRIMARY", "notes": "Gentamicin hoạt động mạnh đối với Gram‑negative, bao gồm E. coli.", "route": "LOCAL_CEMENT", "dosage": "2 g", "frequency": "single dose per batch", "sequence_order": 1, "antibiotic_name": "Gentamicin"}, {"role": "SYNERGISTIC", "notes": "Cefazolin bổ trợ hoạt tính beta‑lactam, tăng độ bao phủ vi khuẩn.", "route": "LOCAL_CEMENT", "dosage": "2 g", "frequency": "single dose per batch", "sequence_order": 2, "antibiotic_name": "Cefazolin"}], "regimen_name": "Gentamicin‑Cefazolin PMMA Spacer", "delivery_info": {"spacer_type": "STATIC", "mixing_ratio": "Gentamicin 2 g + Cefazolin 2 g per 40 g PMMA", "delivery_method": "CEMENT_SPACER", "cement_brand_suggestion": "Palacos R+G"}, "duration_days": 42, "duration_note": "Thời gian đặt spacer thường kéo dài 6‑8 tuần trước khi tái cấy khớp.", "contraindications": ["Dị ứng với aminoglycoside hoặc cephalosporin", "Suy thận nặng (eGFR <30 mL/min/1.73 m²)"]}	2026-05-09 11:48:26+00	\N	2026-05-09 11:48:26	 
62	21	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh hệ thống - Ceftriaxone IV → Ciprofloxacin uống	3	f	{"notes": "Cần thực hiện xét nghiệm huyết thanh để xác nhận mức độ kháng thuốc trước khi chuyển sang giai đoạn oral.", "phases": [{"phase_name": "Giai đoạn tấn công (Induction/IV phase)", "antibiotics": [{"role": "PRIMARY", "notes": "Ceftriaxone nhạy cảm với E. coli, dùng liều cao để đạt nồng độ trong dịch khớp.", "route": "IV", "dosage": "2 g", "frequency": "every 12 hours", "sequence_order": 1, "antibiotic_name": "Ceftriaxone"}, {"role": "BIOFILM_AGENT", "notes": "Rifampicin có hoạt tính chống biofilm, cần giám sát tương tác thuốc.", "route": "IV", "dosage": "600 mg", "frequency": "once daily", "sequence_order": 2, "antibiotic_name": "Rifampicin"}], "phase_order": 1, "duration_note": "Ceftriaxone 2 g IV mỗi 12 giờ, kết hợp với Rifampicin 600 mg IV mỗi ngày để nhắm vào biofilm.", "duration_weeks": 6}, {"phase_name": "Giai đoạn duy trì (Oral/Consolidation phase)", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Ciprofloxacin nhạy cảm với E. coli, dùng để duy trì nồng độ kháng sinh trong mô.", "route": "ORAL", "dosage": "500 mg", "frequency": "every 12 hours", "sequence_order": 1, "antibiotic_name": "Ciprofloxacin"}, {"role": "BIOFILM_AGENT", "notes": "Tiếp tục tác dụng chống biofilm trong giai đoạn oral.", "route": "ORAL", "dosage": "600 mg", "frequency": "once daily", "sequence_order": 2, "antibiotic_name": "Rifampicin"}], "phase_order": 2, "duration_note": "Ciprofloxacin 500 mg uống mỗi 12 giờ, tiếp tục Rifampicin 600 mg uống mỗi ngày.", "duration_weeks": 6}], "indication": "Điều trị nhiễm trùng khớp giả do E. coli, bao gồm cả giai đoạn tấn công và duy trì.", "monitoring": ["Theo dõi chỉ số CRP, ESR hàng tuần", "Kiểm tra chức năng gan (AST/ALT) và thận (creatinine) mỗi 2 tuần", "Đánh giá tác dụng phụ tiêu hóa và phản ứng dị ứng"], "regimen_name": "Ceftriaxone IV → Ciprofloxacin Oral", "contraindications": ["Dị ứng với beta‑lactam (Ceftriaxone) hoặc fluoroquinolone (Ciprofloxacin)", "Suy gan nặng (AST/ALT >5× ULN)", "Suy thận nặng khi dùng Rifampicin"], "total_duration_weeks": 12}	2026-05-09 11:48:26.002+00	\N	2026-05-09 11:48:26.002	 
63	21	SURGERY_PROCEDURE	Phác đồ phẫu thuật - Two-stage revision arthroplasty	4	f	{"notes": "Sau giai đoạn 1, bệnh nhân sẽ được theo dõi chỉ số viêm và thực hiện xét nghiệm dịch khớp để xác nhận tiêu chuẩn âm tính trước khi lên lịch giai đoạn 2.", "stages": [{"stage_name": "Giai đoạn 1 - Tháo khớp giả & đặt spacer kháng sinh", "stage_order": 1, "estimated_duration_minutes": 180}, {"stage_name": "Giai đoạn 2 - Tháo spacer & thay khớp giả mới (Reimplantation)", "stage_order": 2, "estimated_duration_minutes": 210}], "priority_note": "Cần thực hiện giai đoạn 1 gấp rút để giảm tải vi khuẩn và ngăn ngừa lan rộng.", "priority_level": "HIGH", "strategy_rationale": "Nhiễm trùng cấp tính trong vòng 90 ngày, vi khuẩn Gram‑negative nhạy cảm, yêu cầu loại bỏ hoàn toàn vật chủ nhiễm và đặt spacer kháng sinh để kiểm soát nhiễm trùng trước khi tái cấy khớp.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng tái phát", "Tháo dỡ mô mềm và mất xương", "Phản ứng dị ứng với cement kháng sinh"], "estimated_total_treatment_time": "4-6 tháng"}	2026-05-09 11:48:26.004+00	\N	2026-05-09 11:48:26.004	 
64	22	DIAGNOSTIC_TEST	Chẩn đoán AI - Đánh giá nhiễm trùng khớp giả theo ICM 2018 Scoring	1	t	{"ai_reasoning": {"warnings": [{"type": "RENAL_CHECK", "message": "Gentamicin trong cement spacer và ciprofloxacin có thể gây độc thận; cần theo dõi chức năng thận.", "severity": "MEDIUM"}], "primary_diagnosis": "Possible PJI", "reasoning_summary": "Kết hợp các tiêu chí minor dương tính và kết quả nuôi cấy một mẫu E. coli cho thấy khả năng nhiễm trùng khớp giả, mặc dù chưa đủ tiêu chí major để khẳng định chắc chắn.", "identified_organism": {"name": "Escherichia coli", "virulence_note": "E. coli có khả năng tạo biofilm trên bề mặt prosthetic.", "biofilm_forming": true, "resistance_detail": "Nhạy cảm với ceftriaxone, ciprofloxacin, gentamicin; kháng ampicillin.", "resistance_profile": "SENSITIVE"}, "infection_classification": "CHRONIC", "infection_classification_reasoning": "Triệu chứng kéo dài hơn 3 tuần, sinh vật gram‑negative, và không có dấu hiệu nhiễm trùng cấp tính."}, "major_criteria": {"items": [{"result": false, "criterion": "≥ 2 mẫu nuôi cấy dương tính cùng một vi khuẩn", "is_decisive": true, "result_detail": "Chỉ có một mẫu nuôi cấy dương tính Escherichia coli."}, {"result": false, "criterion": "Đường rò thông với khớp giả", "is_decisive": false, "result_detail": "Không có bằng chứng rò rỉ trên hình ảnh."}], "major_criteria_met": false, "major_criteria_conclusion": "Không đủ tiêu chí major để chẩn đoán chắc chắn."}, "scoring_system": {"name": "ICM 2018 PJI Diagnostic Criteria", "version": "2018 (Philadelphia Consensus)", "total_score": 7, "interpretation": "INCONCLUSIVE", "confidence_note": "Điểm nằm trong khoảng 6‑8, cho kết quả không chắc chắn; cần kết hợp lâm sàng và phẫu thuật để xác định definitively."}, "minor_criteria_scoring": {"note": "Tính điểm các tiêu chí phụ (minor) theo ICM 2018", "items": [{"result": true, "criterion": "Serum CRP (>10 mg/L) or D-Dimer (>860 ng/mL)", "score_weight": 2, "result_detail": "CRP = 45 mg/L.", "score_awarded": 2}, {"result": true, "criterion": "Tốc độ máu lắng tăng ESR (>30 mm/h)", "score_weight": 1, "result_detail": "ESR = 55 mm/h.", "score_awarded": 1}, {"result": true, "criterion": "Synovial WBC (>3000 cells/μL) or Leukocyte Esterase (++)", "score_weight": 3, "result_detail": "WBC dịch khớp = 8 000 cells/μL, Esterase ++.", "score_awarded": 3}, {"result": true, "criterion": "Synovial PMN% (>80%)", "score_weight": 2, "result_detail": "PMN% = 88%.", "score_awarded": 2}, {"result": true, "criterion": "Positive Alpha-Defensin", "score_weight": 3, "result_detail": "Alpha‑Defensin dương tính.", "score_awarded": 3}, {"result": true, "criterion": "Elevated Serum IL-6 (>10 pg/mL)", "criterion_vi": "IL-6 huyết thanh tăng", "score_weight": 1, "result_detail": "IL‑6 = 22 pg/mL.", "score_awarded": 1}, {"result": true, "criterion": "1 mẫu nuôi cấy dương tính đơn lẻ", "score_weight": 2, "result_detail": "Một mẫu nuôi cấy dương tính Escherichia coli.", "score_awarded": 2}, {"result": null, "criterion": "Giải phẫu bệnh dương tính (>5 PMN per HPF)", "score_weight": 3, "result_detail": "Chưa thực hiện sinh thiết mô.", "score_awarded": 0}], "total_minor_score": 14, "total_minor_score_note": "Điểm minor cao hỗ trợ chẩn đoán PJI dù thiếu tiêu chí major."}}	2026-05-09 11:50:02.424+00	\N	2026-05-09 11:50:02.424	 
65	22	LOCAL_ANTIBIOTIC	Phác đồ kháng sinh tại chỗ - Gentamicin + Vancomycin cement spacer	2	f	{"notes": "Spacer sẽ được tháo trong giai đoạn 2 của phẫu thuật hai‑giai đoạn.", "indication": "Hỗ trợ điều trị PJI do gram‑negative (E. coli) và phòng ngừa nhiễm khuẩn gram‑positive trong giai đoạn hai‑giai đoạn.", "monitoring": ["Đánh giá mức độ đau và dấu hiệu nhiễm trùng tại vị trí spacer", "Kiểm tra chức năng thận (creatinine) mỗi tuần"], "antibiotics": [{"role": "PRIMARY", "notes": "Có hoạt tính mạnh đối với E. coli; cần theo dõi thận.", "route": "LOCAL_CEMENT", "dosage": "2 g", "frequency": "single dose mixed in cement", "sequence_order": 1, "antibiotic_name": "Gentamicin"}, {"role": "SYNERGISTIC", "notes": "Bảo vệ khỏi nhiễm khuẩn gram‑positive tiềm năng.", "route": "LOCAL_CEMENT", "dosage": "2 g", "frequency": "single dose mixed in cement", "sequence_order": 2, "antibiotic_name": "Vancomycin"}], "regimen_name": "Gentamicin‑Vancomycin PMMA Spacer", "delivery_info": {"spacer_type": "STATIC", "mixing_ratio": "Gentamicin 2 g + Vancomycin 2 g per 40 g PMMA", "delivery_method": "CEMENT_SPACER", "cement_brand_suggestion": "Palacos R+G"}, "duration_days": 42, "duration_note": "Thời gian đặt spacer thường 6‑8 tuần trước khi tái cấy prosthetic.", "contraindications": ["Dị ứng với aminoglycoside hoặc vancomycin", "Suy thận nặng (eGFR <30 mL/min/1.73 m²)"]}	2026-05-09 11:50:02.429+00	\N	2026-05-09 11:50:02.429	 
66	22	SYSTEMIC_ANTIBIOTIC	Phác đồ kháng sinh hệ thống - Ceftriaxone IV → Ciprofloxacin oral	3	f	{"notes": "Cần thực hiện xét nghiệm nhạy cảm kháng thuốc định kỳ để điều chỉnh liều lượng nếu cần.", "phases": [{"phase_name": "Giai đoạn tấn công (Induction/IV phase)", "antibiotics": [{"role": "PRIMARY", "notes": "Nhạy cảm với E. coli, đạt nồng độ trong dịch khớp.", "route": "IV", "dosage": "2 g", "frequency": "once daily", "sequence_order": 1, "antibiotic_name": "Ceftriaxone"}, {"role": "BIOFILM_AGENT", "notes": "Kết hợp để phá vỡ biofilm; cần kiểm tra tương tác thuốc.", "route": "ORAL", "dosage": "600 mg", "frequency": "once daily", "sequence_order": 2, "antibiotic_name": "Rifampicin"}], "phase_order": 1, "duration_note": "Ceftriaxone 2 g IV mỗi 24 h, kết hợp rifampicin 600 mg PO mỗi ngày để ức chế biofilm.", "duration_weeks": 6}, {"phase_name": "Giai đoạn duy trì (Oral/Consolidation phase)", "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Nhạy cảm với E. coli, có hoạt tính tốt trong mô xương.", "route": "ORAL", "dosage": "500 mg", "frequency": "twice daily", "sequence_order": 1, "antibiotic_name": "Ciprofloxacin"}, {"role": "BIOFILM_AGENT", "notes": "Tiếp tục ức chế biofilm trong giai đoạn oral.", "route": "ORAL", "dosage": "600 mg", "frequency": "once daily", "sequence_order": 2, "antibiotic_name": "Rifampicin"}], "phase_order": 2, "duration_note": "Ciprofloxacin 500 mg PO mỗi 12 h, tiếp tục rifampicin 600 mg PO mỗi ngày.", "duration_weeks": 6}], "indication": "Điều trị PJI do Escherichia coli sau phẫu thuật hai‑giai đoạn.", "monitoring": ["CRP và ESR mỗi 2 tuần", "Chức năng thận và mức độ creatinine mỗi tuần khi dùng gentamicin và ciprofloxacin", "Đánh giá tác dụng phụ gan (AST/ALT) khi dùng rifampicin"], "regimen_name": "Ceftriaxone → Ciprofloxacin Sequential Therapy", "contraindications": ["Dị ứng với ceftriaxone, ciprofloxacin hoặc rifampicin", "Suy thận nặng khi dùng ciprofloxacin"], "total_duration_weeks": 12}	2026-05-09 11:50:02.431+00	\N	2026-05-09 11:50:02.431	 
67	22	SURGERY_PROCEDURE	Phác đồ phẫu thuật - Two-stage revision arthroplasty	4	f	{"notes": "Sau giai đoạn 1, bệnh nhân sẽ được điều trị kháng sinh hệ thống 6 tuần trước khi lên kế hoạch tái cấy prosthetic.", "stages": [{"stage_name": "Giai đoạn 1 - Tháo khớp giả & đặt spacer kháng sinh", "stage_order": 1, "estimated_duration_minutes": 180}, {"stage_name": "Giai đoạn 2 - Tháo spacer & thay khớp giả mới (Reimplantation)", "stage_order": 2, "estimated_duration_minutes": 210}], "priority_note": "Cần thực hiện giai đoạn 1 gấp rối loạn nhiễm trùng và giảm nguy cơ lan rộng.", "priority_level": "HIGH", "strategy_rationale": "PJI do gram‑negative (E. coli) có tỷ lệ tái phát cao; two‑stage revision cung cấp thời gian điều trị kháng sinh đầy đủ và loại bỏ biofilm.", "surgery_strategy_type": "TWO_STAGE_REVISION", "risks_and_complications": ["Nhiễm trùng tái phát", "Suy thận do thuốc kháng sinh", "Tháo dỡ mô mềm và mất xương"], "estimated_total_treatment_time": "4-6 tháng"}	2026-05-09 11:50:02.433+00	\N	2026-05-09 11:50:02.433	 
\.


--
-- Data for Name: ai_recommendation_runs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ai_recommendation_runs (id, episode_id, snapshot_id, run_no, trigger_type, status, model_name, model_version, assessment_json, explanation_json, warnings_json, latency_ms, error_message, created_at, request_id, updated_by, updated_at, created_by, data_completeness_json) FROM stdin;
1	3	5	1	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	7585	\N	2026-04-06 14:19:01.008+00	f61b37ad-7614-4094-a066-011304f41dca	 	2026-04-07 17:57:22.136	admin@gmail.com	\N
2	3	6	2	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	6697	\N	2026-04-06 14:45:48.139+00	046af8d5-6b06-418d-8822-bc6621777c01	 	2026-04-07 17:57:22.187	admin@gmail.com	\N
3	3	7	3	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	9230	\N	2026-04-06 15:14:59.041+00	151a5f41-4cdb-4801-b1ea-f8cf7d5abfed	 	2026-04-07 17:57:22.218	admin@gmail.com	\N
4	3	8	4	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	7202	\N	2026-04-07 15:48:49.984+00	4f368cc9-4108-424d-9f0c-7ab89346aba2	 	2026-04-07 22:48:57.262	admin@gmail.com	\N
7	3	11	7	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	6426	\N	2026-04-08 16:23:51.121+00	ef8e4943-a7fb-4dad-a216-a4825ee86c22	 	2026-04-08 23:37:36.684	admin@gmail.com	\N
8	3	12	8	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	6358	\N	2026-04-08 16:38:21.501+00	5c2e9bf2-2e14-49e3-9283-ef5899b82966	 	2026-04-08 23:38:27.921	admin@gmail.com	\N
12	3	16	12	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	7050	\N	2026-04-09 03:57:23.943+00	55ce3fec-9837-478e-b569-e83c2a1760f9	 	2026-04-09 10:57:31.056	admin@gmail.com	\N
13	4	17	1	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	9047	\N	2026-04-11 13:54:23.513+00	9ed71775-51ca-4ccc-9d2d-acadccabe579	 	2026-04-11 20:54:32.631	admin@gmail.com	\N
14	4	18	2	MANUAL_GENERATE	SUCCESS	rag-llm	v1	\N	\N	\N	7953	\N	2026-04-11 14:34:17.861+00	cb895d30-6284-4f9b-ba07-4c66a2f184c1	 	2026-04-11 21:34:25.871	admin@gmail.com	\N
19	4	23	3	MANUAL_GENERATE	SUCCESS	multi-agent-llm	v1	\N	\N	\N	153037	\N	2026-05-07 03:37:19.229+00	9120acdb-465f-4a32-9be8-da70dbaf34f7	 	2026-05-07 10:39:52.375	admin@gmail.com	{"impact_note": "Thieu 1 du lieu CRITICAL — ket qua chan doan va phac do co the khong chinh xac. Khuyen nghi bo sung truoc khi ap dung.", "is_complete": false, "missing_items": [{"field": "serum_CRP", "message": "CRP huyet thanh (2 diem ICM) — marker viem he thong", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_ESR", "message": "Toc do mau lang ESR (1 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_D_Dimer", "message": "D-Dimer (2 diem ICM, ket hop CRP)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_IL6", "message": "IL-6 huyet thanh (1 diem ICM)", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "synovial_WBC", "message": "Bach cau dich khop (3 diem ICM) — marker quan trong nhat", "category": "ICM_MINOR", "importance": "CRITICAL"}, {"field": "synovial_PMN", "message": "PMN% dich khop (2 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_alpha_defensin", "message": "Alpha-Defensin (3 diem ICM) — do dac hieu >96%", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_LE", "message": "Leukocyte Esterase dich khop (3 diem ICM) — test nhanh tai cho", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "positive_histology", "message": "Giai phau benh mo quanh khop (3 diem ICM) — can sinh thiet mo trong phau thuat", "category": "ICM_MINOR", "importance": "HIGH"}], "completeness_score": "0/9 ICM minor criteria co du lieu"}
20	4	24	4	MANUAL_GENERATE	SUCCESS	multi-agent-llm	v1	\N	\N	\N	221225	\N	2026-05-07 03:47:38.578+00	9d07f4eb-da99-4d1e-a691-2678f17d6c7c	 	2026-05-07 10:51:19.881	admin@gmail.com	{"impact_note": "Thieu 1 du lieu CRITICAL — ket qua chan doan va phac do co the khong chinh xac. Khuyen nghi bo sung truoc khi ap dung.", "is_complete": false, "missing_items": [{"field": "serum_CRP", "message": "CRP huyet thanh (2 diem ICM) — marker viem he thong", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_ESR", "message": "Toc do mau lang ESR (1 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_D_Dimer", "message": "D-Dimer (2 diem ICM, ket hop CRP)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_IL6", "message": "IL-6 huyet thanh (1 diem ICM)", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "synovial_WBC", "message": "Bach cau dich khop (3 diem ICM) — marker quan trong nhat", "category": "ICM_MINOR", "importance": "CRITICAL"}, {"field": "synovial_PMN", "message": "PMN% dich khop (2 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_alpha_defensin", "message": "Alpha-Defensin (3 diem ICM) — do dac hieu >96%", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_LE", "message": "Leukocyte Esterase dich khop (3 diem ICM) — test nhanh tai cho", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "positive_histology", "message": "Giai phau benh mo quanh khop (3 diem ICM) — can sinh thiet mo trong phau thuat", "category": "ICM_MINOR", "importance": "HIGH"}], "completeness_score": "0/9 ICM minor criteria co du lieu"}
21	5	25	1	MANUAL_GENERATE	SUCCESS	multi-agent-llm	v1	\N	\N	\N	161658	\N	2026-05-09 11:32:26.386+00	db54d69a-e916-4e3f-8adb-067cb8f34221	 	2026-05-09 11:48:26.015	admin@gmail.com	{"impact_note": "Thieu 2 du lieu CRITICAL — ket qua chan doan va phac do co the khong chinh xac. Khuyen nghi bo sung truoc khi ap dung.", "is_complete": false, "missing_items": [{"field": "culture_results", "message": "Khong co ket qua nuoi cay — can it nhat 2 mau de danh gia major criterion", "category": "ICM_MAJOR", "importance": "CRITICAL"}, {"field": "serum_CRP", "message": "CRP huyet thanh (2 diem ICM) — marker viem he thong", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_ESR", "message": "Toc do mau lang ESR (1 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_D_Dimer", "message": "D-Dimer (2 diem ICM, ket hop CRP)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_IL6", "message": "IL-6 huyet thanh (1 diem ICM)", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "synovial_WBC", "message": "Bach cau dich khop (3 diem ICM) — marker quan trong nhat", "category": "ICM_MINOR", "importance": "CRITICAL"}, {"field": "synovial_PMN", "message": "PMN% dich khop (2 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_alpha_defensin", "message": "Alpha-Defensin (3 diem ICM) — do dac hieu >96%", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_LE", "message": "Leukocyte Esterase dich khop (3 diem ICM) — test nhanh tai cho", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "positive_histology", "message": "Giai phau benh mo quanh khop (3 diem ICM) — can sinh thiet mo trong phau thuat", "category": "ICM_MINOR", "importance": "HIGH"}], "completeness_score": "0/9 ICM minor criteria co du lieu"}
22	5	26	2	MANUAL_GENERATE	SUCCESS	multi-agent-llm	v1	\N	\N	\N	96463	\N	2026-05-09 11:46:04.061+00	c4a7da5a-7416-49c8-871f-252d05812874	 	2026-05-09 11:50:02.441	admin@gmail.com	{"impact_note": "Thieu 2 du lieu CRITICAL — ket qua chan doan va phac do co the khong chinh xac. Khuyen nghi bo sung truoc khi ap dung.", "is_complete": false, "missing_items": [{"field": "culture_results", "message": "Khong co ket qua nuoi cay — can it nhat 2 mau de danh gia major criterion", "category": "ICM_MAJOR", "importance": "CRITICAL"}, {"field": "serum_CRP", "message": "CRP huyet thanh (2 diem ICM) — marker viem he thong", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_ESR", "message": "Toc do mau lang ESR (1 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_D_Dimer", "message": "D-Dimer (2 diem ICM, ket hop CRP)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "serum_IL6", "message": "IL-6 huyet thanh (1 diem ICM)", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "synovial_WBC", "message": "Bach cau dich khop (3 diem ICM) — marker quan trong nhat", "category": "ICM_MINOR", "importance": "CRITICAL"}, {"field": "synovial_PMN", "message": "PMN% dich khop (2 diem ICM)", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_alpha_defensin", "message": "Alpha-Defensin (3 diem ICM) — do dac hieu >96%", "category": "ICM_MINOR", "importance": "HIGH"}, {"field": "synovial_LE", "message": "Leukocyte Esterase dich khop (3 diem ICM) — test nhanh tai cho", "category": "ICM_MINOR", "importance": "MEDIUM"}, {"field": "positive_histology", "message": "Giai phau benh mo quanh khop (3 diem ICM) — can sinh thiet mo trong phau thuat", "category": "ICM_MINOR", "importance": "HIGH"}], "completeness_score": "0/9 ICM minor criteria co du lieu"}
\.


--
-- Data for Name: case_clinical_snapshots; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.case_clinical_snapshots (id, episode_id, snapshot_no, snapshot_data_json, data_completeness_score, created_at, updated_by, updated_at, created_by) FROM stdin;
1	3	1	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T14:00:07.425646300Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 14:00:07.483+00	\N	2026-04-06 21:00:07.483	admin@gmail.com
2	3	2	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T14:12:23.137101100Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 14:12:23.245+00	\N	2026-04-06 21:12:23.245	admin@gmail.com
3	3	3	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T14:13:51.187668800Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 14:13:51.242+00	\N	2026-04-06 21:13:51.242	admin@gmail.com
4	3	4	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T14:14:50.026661100Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 14:14:50.074+00	\N	2026-04-06 21:14:50.074	admin@gmail.com
5	3	5	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T14:19:00.951011100Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 14:19:00.997+00	\N	2026-04-06 21:19:00.997	admin@gmail.com
6	3	6	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T14:45:47.981710500Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 14:45:48.113+00	\N	2026-04-06 21:45:48.113	admin@gmail.com
7	3	7	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-06T15:14:58.969032600Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-06 15:14:59.029+00	\N	2026-04-06 22:14:59.029	admin@gmail.com
8	3	8	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-07T15:48:49.796643400Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-07 15:48:49.945+00	\N	2026-04-07 22:48:49.945	admin@gmail.com
9	3	9	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-08T16:16:22.597353600Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-08 16:16:22.745+00	\N	2026-04-08 23:16:22.745	admin@gmail.com
10	3	10	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-08T16:19:17.705917200Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-08 16:19:17.782+00	\N	2026-04-08 23:19:17.782	admin@gmail.com
11	3	11	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-08T16:23:50.924173200Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-08 16:23:51.065+00	\N	2026-04-08 23:23:51.065	admin@gmail.com
12	3	12	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-08T16:38:21.330776800Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-08 16:38:21.483+00	\N	2026-04-08 23:38:21.483	admin@gmail.com
13	3	13	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-09T03:25:29.386432Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-09 03:25:29.486+00	\N	2026-04-09 10:25:29.486	admin@gmail.com
14	3	14	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-09T03:32:10.184234400Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-09 03:32:10.255+00	\N	2026-04-09 10:32:10.255	admin@gmail.com
15	3	15	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-09T03:45:01.268243200Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-09 03:45:01.331+00	\N	2026-04-09 10:45:01.331	admin@gmail.com
16	3	16	{"lab_results": {"latest": {"lab_id": 1, "created_at": "2026-03-16T15:01:10.604Z", "hematology": {"ig": {"unit": "%", "value": 0.3}, "mch": {"unit": "pg", "value": 29.0}, "mcv": {"unit": "fL", "value": 88.0}, "rbc": {"unit": "10^12/L", "value": 4.7}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 22.0}, "synovial_wbc": {"unit": "cells/uL", "value": 850.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alb": {"unit": "g/L", "value": 38.5}, "alt": {"unit": "U/L", "value": 25}, "ast": {"unit": "U/L", "value": 30}, "clo": {"unit": "mmol/L", "value": 102}, "ure": {"unit": "%", "value": 6.5}, "eGFR": {"unit": "mL/min/1.73m2", "value": 95}, "kali": {"unit": "mmol/L", "value": 4.1}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 138}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/L", "value": 5.2}, "creatinine": {"unit": "µmol/L", "value": 86}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/L", "value": 3.2}, "esr": {"unit": "mm/h", "value": 18.0}, "mono": {"unit": "%", "value": 6.0}, "neut": {"unit": "%", "value": 58.0}, "d_dimer": null, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": null, "wbc_blood": {"unit": "10^9/L", "value": 7.4}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": null, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "culture_results": {"items": [{"notes": "Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.", "gram_type": "Gram-positive", "culture_id": 1, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "R", "antibiotic_name": "Brbr patapin", "sensitivity_code": "RRRR"}], "incubation_days": 5}]}, "medical_history": {"process": "Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": true, "is_other": false, "drug_note": "Dị ứng thuốc kháng sinh nhóm Penicillin", "is_alcohol": false, "is_smoking": true, "other_note": "", "alcohol_note": "", "smoking_note": "Hút thuốc lá 1 bao/ngày trong khoảng 10 năm"}, "medical_history": "Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018"}, "clinical_records": {"vitals": {"bmi": 24.50, "blood_pressure": "120/80 mmHg"}, "symptoms": {"pain": true, "fever": true, "erythema": true, "swelling": true, "sinus_tract": false}, "notations": "Bệnh nhân có biểu hiện đau tăng dần khi vận động", "record_id": 2, "recorded_at": "2026-03-16T13:46:09.782Z", "illness_onset_date": "2026-02-15", "infection_assessment": {"soft_tissue": "Sưng nề nhẹ, không hoại tử", "pmma_allergy": false, "prosthesis_joint": "Khớp háng bên trái", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "LATE_HEMATOGENOUS", "days_since_index_arthroplasty": 365}}, "snapshot_metadata": {"episode_id": 3, "patient_id": 2, "snapshot_at": "2026-04-09T03:57:23.880920400Z", "data_sources": ["medical_histories", "clinical_records", "lab_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	71.43	2026-04-09 03:57:23.929+00	\N	2026-04-09 10:57:23.929	admin@gmail.com
17	4	1	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "hematology": {"ig": {"unit": "fL", "value": 5.0}, "mch": {"unit": "pg", "value": 32.0}, "mcv": {"unit": "fL", "value": 65.0}, "rbc": {"unit": "x10^12/L", "value": 4.0}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 74.0}, "synovial_wbc": {"unit": "Tế bào/Vi trường", "value": 5.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/l", "value": 138.2}, "esr": {"unit": "mm", "value": 6.0}, "mono": {"unit": "%", "value": 5.0}, "neut": {"unit": "%", "value": 77.7}, "d_dimer": {"unit": "mg/L FEU", "value": 1.0}, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": {"unit": "pg/mL", "value": 8.0}, "wbc_blood": {"unit": "G/L", "value": 12.26}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": {"unit": "ug/mL", "value": 1.0}, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.00, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-04-11T13:54:23.427035800Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-04-11 13:54:23.497+00	\N	2026-04-11 20:54:23.497	admin@gmail.com
18	4	2	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "hematology": {"ig": {"unit": "fL", "value": 5.0}, "mch": {"unit": "pg", "value": 32.0}, "mcv": {"unit": "fL", "value": 65.0}, "rbc": {"unit": "x10^12/L", "value": 4.0}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 74.0}, "synovial_wbc": {"unit": "Tế bào/Vi trường", "value": 5.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/l", "value": 138.2}, "esr": {"unit": "mm", "value": 6.0}, "mono": {"unit": "%", "value": 5.0}, "neut": {"unit": "%", "value": 77.7}, "d_dimer": {"unit": "mg/L FEU", "value": 1.0}, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": {"unit": "pg/mL", "value": 8.0}, "wbc_blood": {"unit": "G/L", "value": 12.26}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": {"unit": "ug/mL", "value": 1.0}, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.00, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-04-11T14:34:17.795674100Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-04-11 14:34:17.847+00	\N	2026-04-11 21:34:17.847	admin@gmail.com
19	4	3	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "hematology": {"ig": {"unit": "fL", "value": 5.0}, "mch": {"unit": "pg", "value": 32.0}, "mcv": {"unit": "fL", "value": 65.0}, "rbc": {"unit": "x10^12/L", "value": 4.0}, "ig_unit": "%", "mch_unit": "pg", "mcv_unit": "fL", "rbc_unit": "x10^12/L"}, "synovial_fluid": {"synovial_pmn": {"unit": "%", "value": 74.0}, "synovial_wbc": {"unit": "Tế bào/Vi trường", "value": 5.0}, "synovial_pmn_unit": "%", "synovial_wbc_unit": "cells/μL"}, "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "inflammatory_markers_blood": {"crp": {"unit": "mg/l", "value": 138.2}, "esr": {"unit": "mm", "value": 6.0}, "mono": {"unit": "%", "value": 5.0}, "neut": {"unit": "%", "value": 77.7}, "d_dimer": {"unit": "mg/L FEU", "value": 1.0}, "crp_unit": "mg/L", "esr_unit": "mm/h", "mono_unit": "%", "neut_unit": "%", "serum_il6": {"unit": "pg/mL", "value": 8.0}, "wbc_blood": {"unit": "G/L", "value": 12.26}, "d_dimer_unit": "mg/L FEU", "alpha_defensin": {"unit": "ug/mL", "value": 1.0}, "serum_il6_unit": "pg/mL", "wbc_blood_unit": "x10^9/L"}}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "Gram Âm", "culture_id": 6, "organism_name": "Klebsiella Pneumoniae", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "16", "antibiotic_name": "tobramycin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": "Amikacin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": " Piperacillin/tazobactam", "sensitivity_code": "S"}, {"mic_value": "8", "antibiotic_name": "ciprofloxacin", "sensitivity_code": "R"}, {"mic_value": "2", "antibiotic_name": "Meropenem", "sensitivity_code": "S"}], "incubation_days": null}, {"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.00, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-04-12T04:32:09.353052600Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-04-12 04:32:09.414+00	\N	2026-04-12 11:32:09.414	admin@gmail.com
20	4	4	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "day", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": 138, "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": 96, "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": 120, "normalRange": ""}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": 45, "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": 6, "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": 6, "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": 6, "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": 99, "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": 34, "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": 36, "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": 5, "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": 1, "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": 6, "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": 1, "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "Gram Âm", "culture_id": 6, "organism_name": "Klebsiella Pneumoniae", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "16", "antibiotic_name": "tobramycin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": "Amikacin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": " Piperacillin/tazobactam", "sensitivity_code": "S"}, {"mic_value": "8", "antibiotic_name": "ciprofloxacin", "sensitivity_code": "R"}, {"mic_value": "2", "antibiotic_name": "Meropenem", "sensitivity_code": "S"}], "incubation_days": null}, {"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.00, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-05-06T14:47:34.500944295Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-05-06 14:47:34.637+00	\N	2026-05-06 21:47:34.637	admin@gmail.com
21	4	5	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "day", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": 138, "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": 96, "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": 120, "normalRange": ""}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": 45, "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": 6, "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": 6, "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": 6, "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": 99, "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": 34, "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": 36, "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": 5, "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": 1, "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": 6, "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": 1, "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "Gram Âm", "culture_id": 6, "organism_name": "Klebsiella Pneumoniae", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "16", "antibiotic_name": "tobramycin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": "Amikacin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": " Piperacillin/tazobactam", "sensitivity_code": "S"}, {"mic_value": "8", "antibiotic_name": "ciprofloxacin", "sensitivity_code": "R"}, {"mic_value": "2", "antibiotic_name": "Meropenem", "sensitivity_code": "S"}], "incubation_days": null}, {"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.00, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-05-06T15:47:16.671650547Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-05-06 15:47:16.743+00	\N	2026-05-06 22:47:16.743	admin@gmail.com
22	4	6	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "day", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": 138, "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": 96, "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": 120, "normalRange": ""}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": 45, "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": 6, "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": 6, "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": 6, "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": 99, "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": 34, "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": 36, "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": 5, "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": 1, "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": 6, "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": 1, "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "Gram Âm", "culture_id": 6, "organism_name": "Klebsiella Pneumoniae", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "16", "antibiotic_name": "tobramycin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": "Amikacin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": " Piperacillin/tazobactam", "sensitivity_code": "S"}, {"mic_value": "8", "antibiotic_name": "ciprofloxacin", "sensitivity_code": "R"}, {"mic_value": "2", "antibiotic_name": "Meropenem", "sensitivity_code": "S"}], "incubation_days": null}, {"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.00, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-05-07T03:17:50.786911049Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-05-07 03:17:50.862+00	\N	2026-05-07 10:17:50.862	admin@gmail.com
23	4	7	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "day", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": 138, "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": 96, "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": 120, "normalRange": ""}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": 45, "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": 6, "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": 6, "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": 6, "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": 99, "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": 34, "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": 36, "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": 5, "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": 1, "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": 6, "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": 1, "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "Gram Âm", "culture_id": 6, "organism_name": "Klebsiella Pneumoniae", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "16", "antibiotic_name": "tobramycin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": "Amikacin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": " Piperacillin/tazobactam", "sensitivity_code": "S"}, {"mic_value": "8", "antibiotic_name": "ciprofloxacin", "sensitivity_code": "R"}, {"mic_value": "2", "antibiotic_name": "Meropenem", "sensitivity_code": "S"}], "incubation_days": null}, {"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.0, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-05-07T03:17:50.786911049Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-05-07 03:37:19.221+00	\N	2026-05-07 10:37:19.221	admin@gmail.com
24	4	8	{"surgeries": {"items": [{"findings": "Ca mổ thuận lợi, không biến chứng sớm", "surgery_id": 4, "surgery_date": "2024-11-24", "surgery_type": "Thay khớp háng toàn phần (Total Hip Arthroplasty)"}, {"findings": "Có nhiễm trùng vết mổ sớm sau mổ", "surgery_id": 3, "surgery_date": "2025-10-15", "surgery_type": "Thay khớp gối toàn phần"}]}, "lab_results": {"latest": {"lab_id": 2, "created_at": "2026-04-11T03:18:56.321Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "day", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": 138, "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": 96, "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": 120, "normalRange": ""}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": 45, "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": 6, "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": 6, "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": 6, "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": 99, "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": 34, "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": 36, "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": 5, "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": 1, "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": 6, "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": 1, "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)", "image_id": 4, "created_at": "2026-04-11T04:56:35.754Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "Gram Âm", "culture_id": 6, "organism_name": "Klebsiella Pneumoniae", "result_status": "POSITIVE", "sensitivities": [{"mic_value": "16", "antibiotic_name": "tobramycin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": "Amikacin", "sensitivity_code": "R"}, {"mic_value": "8", "antibiotic_name": " Piperacillin/tazobactam", "sensitivity_code": "S"}, {"mic_value": "8", "antibiotic_name": "ciprofloxacin", "sensitivity_code": "R"}, {"mic_value": "2", "antibiotic_name": "Meropenem", "sensitivity_code": "S"}], "incubation_days": null}, {"notes": "kháng Methicillin", "gram_type": "Gram Dương", "culture_id": 5, "organism_name": "Staphylococcus aureus", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=8", "antibiotic_name": "Clindamycin", "sensitivity_code": "R"}, {"mic_value": ">=4", "antibiotic_name": "Ciprofloxacin", "sensitivity_code": "R"}], "incubation_days": 2}]}, "medical_history": {"process": "Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.", "allergies": {"is_allergy": true, "allergy_note": "Dị ứng hải sản (tôm, cua) và phấn hoa"}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2."}, "clinical_records": {"vitals": {"bmi": 19.0, "blood_pressure": ""}, "symptoms": {"pain": true, "fever": true, "erythema": false, "swelling": false, "sinus_tract": false}, "notations": "Không có dấu hiệu nhiễm trùng toàn thân nặng", "record_id": 3, "recorded_at": "2026-04-11T04:11:24.547Z", "illness_onset_date": "2026-01-12", "infection_assessment": {"soft_tissue": "Mô mềm quanh khớp sưng, không có rò mủ", "pmma_allergy": false, "prosthesis_joint": "Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật", "implant_stability": "POSSIBLY_LOOSE", "hematogenous_suspected": false, "suspected_infection_type": "DELAYED", "days_since_index_arthroplasty": 280}}, "snapshot_metadata": {"episode_id": 4, "patient_id": 2, "snapshot_at": "2026-05-07T03:17:50.786911049Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "MALE", "full_name": "Lê Hoàng Tùng", "patient_code": "2026E4D9A6", "date_of_birth": "2003-03-15"}}	85.71	2026-05-07 03:47:38.571+00	\N	2026-05-07 10:47:38.571	admin@gmail.com
25	5	1	{"surgeries": {"items": [{"findings": "Vết mổ ban đầu chậm liền, có tình trạng rỉ dịch thấm băng trong 2 tuần đầu nhưng sau đó ổn định mà không cần can thiệp phẫu thuật lại", "surgery_id": 5, "surgery_date": "2025-10-20", "surgery_type": "Thay khớp gối toàn phần (TKA) bên Phả"}]}, "lab_results": {"latest": {"lab_id": 3, "created_at": "2026-05-08T15:01:16.637Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "Dày đặc", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": "90", "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": "91", "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 62.3}, "ast": {"unit": "U/L", "value": 52}, "clo": {"unit": "mmol/L", "value": 90.7}, "ure": {"unit": "mmol/l", "value": 6.68}, "kali": {"unit": "mmol/L", "value": 3.6}, "hba1c": {"unit": "%", "value": 5}, "natri": {"unit": "mmol/L", "value": 128.8}, "albumin": {"unit": "g/L", "value": 45}, "glucose": {"unit": "mmol/l", "value": 9.67}, "creatinine": {"unit": "µmol/l", "value": 80}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": "17.97", "normalRange": "4 - 10"}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": "83.8", "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": "6.0", "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": "105", "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": "0.00", "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": "85.5", "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": "328", "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": "11", "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": "5", "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": "1", "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": "6", "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": "1", "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "Ảnh mang tính chất thêm vào để test, nên chẳng có ý nghĩa gì cả", "image_id": 6, "created_at": "2026-05-08T15:01:16.751Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1778252303268-how-distributed.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260508%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260508T145823Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=67aa6659e0857cc74b25f7922dc75c394b232b6a9a83d4d5ad2931cd2bf1e59e", "name": "how-distributed.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "GRAM_POSITIVE", "culture_id": 7, "organism_name": "Escherichia coli", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=76", "antibiotic_name": "Vancomycin", "sensitivity_code": "S"}], "incubation_days": 9}]}, "medical_history": {"process": "Cách nhập viện 3 tháng, bệnh nhân bắt đầu có cảm giác đau âm ỉ vùng gối Phải, đau tăng lên khi đi lại và cả về ban đêm.\\nBệnh nhân không sốt cao, chỉ có cảm giác gai rét nhẹ vào buổi chiều. Đã tự mua thuốc giảm đau uống nhưng tình trạng không thuyên giảm.", "allergies": {"is_allergy": false, "allergy_note": ""}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Đái tháo đường Tuýp 2: Phát hiện 10 năm, đang điều trị bằng Metformin. Chỉ số HbA1c xét nghiệm gần nhất: 7.8% (Kiểm soát đường huyết chưa thực sự tốt).\\nTăng huyết áp: Đang duy trì Losartan 50mg/ngày, huyết áp mục tiêu 135/85 mmHg."}, "clinical_records": {"vitals": {"bmi": 26.00, "blood_pressure": null}, "symptoms": {"pain": true, "fever": true, "erythema": null, "swelling": true, "sinus_tract": null}, "notations": "Bệnh nhân không sốt cao, chỉ có cảm giác gai rét nhẹ vào buổi chiều.", "record_id": 4, "recorded_at": "2026-05-08T15:01:16.680Z", "illness_onset_date": "2026-01-01", "infection_assessment": {"soft_tissue": "Vết mổ sưng nề mạnh, tấy đỏ lan rộng quanh xương bánh chè, có hiện tượng rỉ dịch đục qua k", "pmma_allergy": null, "prosthesis_joint": "Khớp gối (Phải) toàn phần (TKA), loại có xi măng (Cemented), thành phần Polyethylene cố định.", "implant_stability": "STABLE", "hematogenous_suspected": null, "suspected_infection_type": "EARLY_POSTOPERATIVE", "days_since_index_arthroplasty": 90}}, "snapshot_metadata": {"episode_id": 5, "patient_id": 9, "snapshot_at": "2026-05-09T11:32:26.297661574Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "FEMALE", "full_name": "Trịnh Khánh Linh", "patient_code": "202694FF9B", "date_of_birth": "2005-10-12"}}	85.71	2026-05-09 11:32:26.365+00	\N	2026-05-09 11:32:26.365	admin@gmail.com
26	5	2	{"surgeries": {"items": [{"findings": "Vết mổ ban đầu chậm liền, có tình trạng rỉ dịch thấm băng trong 2 tuần đầu nhưng sau đó ổn định mà không cần can thiệp phẫu thuật lại", "surgery_id": 5, "surgery_date": "2025-10-20", "surgery_type": "Thay khớp gối toàn phần (TKA) bên Phả"}]}, "lab_results": {"latest": {"lab_id": 3, "created_at": "2026-05-08T15:01:16.637Z", "fluid_analysis": [{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "Dày đặc", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": "90", "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": "91", "normalRange": ""}], "biochemical_data": {"alt": {"unit": "U/L", "value": 62.3}, "ast": {"unit": "U/L", "value": 52}, "clo": {"unit": "mmol/L", "value": 90.7}, "ure": {"unit": "mmol/l", "value": 6.68}, "kali": {"unit": "mmol/L", "value": 3.6}, "hba1c": {"unit": "%", "value": 5}, "natri": {"unit": "mmol/L", "value": 128.8}, "albumin": {"unit": "g/L", "value": 45}, "glucose": {"unit": "mmol/l", "value": 9.67}, "creatinine": {"unit": "µmol/l", "value": 80}}, "hematology_tests": [{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": "17.97", "normalRange": "4 - 10"}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": "83.8", "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": "6.0", "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": "105", "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": "0.00", "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": "85.5", "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": "328", "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": "11", "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": "5", "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": "1", "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": "6", "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": "1", "normalRange": "< 0.12"}]}}, "image_results": {"items": [{"type": "X-ray", "findings": "Ảnh mang tính chất thêm vào để test, nên chẳng có ý nghĩa gì cả", "image_id": 6, "created_at": "2026-05-08T15:01:16.751Z", "file_metadata": {"url": "http://localhost:9000/clinical-images/1778252303268-how-distributed.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260508%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260508T145823Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=67aa6659e0857cc74b25f7922dc75c394b232b6a9a83d4d5ad2931cd2bf1e59e", "name": "how-distributed.png"}}]}, "culture_results": {"items": [{"notes": null, "gram_type": "GRAM_POSITIVE", "culture_id": 7, "organism_name": "Escherichia coli", "result_status": "POSITIVE", "sensitivities": [{"mic_value": ">=76", "antibiotic_name": "Vancomycin", "sensitivity_code": "S"}], "incubation_days": 9}]}, "medical_history": {"process": "Cách nhập viện 3 tháng, bệnh nhân bắt đầu có cảm giác đau âm ỉ vùng gối Phải, đau tăng lên khi đi lại và cả về ban đêm.\\nBệnh nhân không sốt cao, chỉ có cảm giác gai rét nhẹ vào buổi chiều. Đã tự mua thuốc giảm đau uống nhưng tình trạng không thuyên giảm.", "allergies": {"is_allergy": false, "allergy_note": ""}, "substance_use": {"is_drug": false, "is_other": false, "drug_note": "", "is_alcohol": false, "is_smoking": false, "other_note": "", "alcohol_note": "", "smoking_note": ""}, "medical_history": "Đái tháo đường Tuýp 2: Phát hiện 10 năm, đang điều trị bằng Metformin. Chỉ số HbA1c xét nghiệm gần nhất: 7.8% (Kiểm soát đường huyết chưa thực sự tốt).\\nTăng huyết áp: Đang duy trì Losartan 50mg/ngày, huyết áp mục tiêu 135/85 mmHg."}, "clinical_records": {"vitals": {"bmi": 26.0, "blood_pressure": null}, "symptoms": {"pain": true, "fever": true, "erythema": null, "swelling": true, "sinus_tract": null}, "notations": "Bệnh nhân không sốt cao, chỉ có cảm giác gai rét nhẹ vào buổi chiều.", "record_id": 4, "recorded_at": "2026-05-08T15:01:16.680Z", "illness_onset_date": "2026-01-01", "infection_assessment": {"soft_tissue": "Vết mổ sưng nề mạnh, tấy đỏ lan rộng quanh xương bánh chè, có hiện tượng rỉ dịch đục qua k", "pmma_allergy": null, "prosthesis_joint": "Khớp gối (Phải) toàn phần (TKA), loại có xi măng (Cemented), thành phần Polyethylene cố định.", "implant_stability": "STABLE", "hematogenous_suspected": null, "suspected_infection_type": "EARLY_POSTOPERATIVE", "days_since_index_arthroplasty": 90}}, "snapshot_metadata": {"episode_id": 5, "patient_id": 9, "snapshot_at": "2026-05-09T11:32:26.297661574Z", "data_sources": ["medical_histories", "clinical_records", "surgeries", "lab_results", "image_results", "culture_results", "sensitivity_results"]}, "patient_demographics": {"gender": "FEMALE", "full_name": "Trịnh Khánh Linh", "patient_code": "202694FF9B", "date_of_birth": "2005-10-12"}}	85.71	2026-05-09 11:46:04.031+00	\N	2026-05-09 11:46:04.031	admin@gmail.com
\.


--
-- Data for Name: clinical_records; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.clinical_records (id, episode_id, recorded_at, illness_onset_date, blood_pressure, bmi, fever, pain, erythema, swelling, sinus_tract, suspected_infection_type, hematogenous_suspected, implant_stability, soft_tissue, pmma_allergy, prosthesis_joint, days_since_index_arthroplasty, notations, created_by, updated_by, created_at, updated_at) FROM stdin;
2	3	2026-03-16 13:46:09.785293+00	2026-02-15	120/80 mmHg	24.50	t	t	t	t	f	LATE_HEMATOGENOUS	f	POSSIBLY_LOOSE	Sưng nề nhẹ, không hoại tử	t	Khớp háng bên trái	365	Bệnh nhân có biểu hiện đau tăng dần khi vận động edit	admin@gmail.com	admin@gmail.com	2026-03-16 13:46:09.782+00	2026-04-10 15:42:58.725+00
3	4	2026-04-11 04:11:24.553146+00	2026-01-12		19.00	t	t	f	f	f	DELAYED	f	POSSIBLY_LOOSE	Mô mềm quanh khớp sưng, không có rò mủ	f	Khớp háng phải, chưa mở lại, nghi ngờ cần can thiệp phẫu thuật	280	Không có dấu hiệu nhiễm trùng toàn thân nặng	admin@gmail.com	admin@gmail.com	2026-04-11 04:11:24.547+00	2026-04-11 04:30:06.9+00
4	5	2026-05-08 15:01:16.681142+00	2026-01-01	\N	26.00	t	t	\N	t	\N	EARLY_POSTOPERATIVE	\N	STABLE	Vết mổ sưng nề mạnh, tấy đỏ lan rộng quanh xương bánh chè, có hiện tượng rỉ dịch đục qua k	\N	Khớp gối (Phải) toàn phần (TKA), loại có xi măng (Cemented), thành phần Polyethylene cố định.	90	Bệnh nhân không sốt cao, chỉ có cảm giác gai rét nhẹ vào buổi chiều.	admin@gmail.com	\N	2026-05-08 15:01:16.68+00	2026-05-08 15:01:16.68+00
\.


--
-- Data for Name: culture_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.culture_results (id, episode_id, sample_type, incubation_days, name, result_status, gram_type, notes, created_by, updated_by, created_at, updated_at, days_off_antibio, antibioticed) FROM stdin;
2	3	\N	11	ewemhjm	POSITIVE	Gram Dương	hiihihhahaa	admin@gmail.com	\N	2026-04-10 15:42:58.768+00	2026-04-10 15:42:58.768+00	112	t
1	3	Máu (Blood)	5	Staphylococcus aureus	POSITIVE	Gram-positive	Bệnh nhân có biểu hiện sốt cao, cần theo dõi thêm.	admin@gmail.com	admin@gmail.com	2026-03-16 15:22:35.953+00	2026-04-10 15:42:58.772+00	12	t
5	4	\N	2	Staphylococcus aureus	POSITIVE	Gram Dương	kháng Methicillin	admin@gmail.com	\N	2026-04-11 04:30:06.935+00	2026-04-11 04:30:06.935+00	77	t
6	4	\N	\N	Klebsiella Pneumoniae	POSITIVE	Gram Âm	\N	admin@gmail.com	\N	2026-04-12 04:30:43.731+00	2026-04-12 04:30:43.731+00	0	f
7	5	\N	9	Escherichia coli	POSITIVE	GRAM_POSITIVE	\N	admin@gmail.com	\N	2026-05-08 15:01:16.71+00	2026-05-08 15:01:16.71+00	0	f
\.


--
-- Data for Name: doctor_recommendation_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.doctor_recommendation_reviews (id, episode_id, run_id, review_status, review_note, modification_json, rejection_reason, created_at, updated_at, updated_by, created_by) FROM stdin;
1	3	12	MODIFIED	dad	{"surgery": {"notes": "Cân nhắc kỹ lưỡng trước khi phẫu thuật", "stages": [{"stageName": "Giai đoạn 1: Loại bỏ implant và nhiễm trùng", "stageOrder": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra nhiễm trùng"], "intervalFromStage1": null, "estimatedDurationMinutes": 120}, {"stageName": "Giai đoạn 2: Tái tạo khớp", "stageOrder": 2, "preconditions": ["Kiểm tra nhiễm trùng đã khỏi", "Chuẩn bị bệnh nhân"], "intervalFromStage1": 6, "estimatedDurationMinutes": 180}], "priorityNote": "Cần phẫu thuật gấp", "priorityLevel": "HIGH", "strategyRationale": "Loại bỏ nhiễm trùng và tái tạo khớp", "surgeryStrategyType": "TWO_STAGE_REVISION", "risksAndComplications": ["Nhiễm trùng tái phát", "Tổn thương thần kinh"], "estimatedTotalTreatmentTime": "Khoảng 12 tuần"}, "systemicAntibiotic": {"notes": "Cân nhắc điều chỉnh liều dựa trên chức năng thận", "phases": [{"phaseName": "Giai đoạn tấn công", "phaseOrder": 1, "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh ban đầu", "route": "IV", "dosage": "1g x 3 lần/ngày", "frequency": "IV", "sequenceOrder": 1, "antibioticName": "Cefazolin"}], "durationNote": "Điều trị ban đầu", "durationWeeks": 2}, {"phaseName": "Giai đoạn duy trì", "phaseOrder": 2, "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh duy trì", "route": "ORAL", "dosage": "100mg x 2 lần/ngày", "frequency": "ORAL", "sequenceOrder": 1, "antibioticName": "Doxycycline"}], "durationNote": "Tiếp tục điều trị", "durationWeeks": 2}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimenName": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Dị ứng với kháng sinh"], "totalDurationWeeks": 4}}	dđ	2026-04-09 04:21:18.808+00	2026-04-09 04:21:18.808+00	\N	admin@gmail.com
2	4	13	MODIFIED	Tôi tán thành	{"surgery": {"notes": "Cần thảo luận kỹ với bệnh nhân về các rủi ro và biến chứng có thể xảy ra.", "stages": [{"stageName": "Giai đoạn 1: Tháo bỏ implant và đặt spacer", "stageOrder": 1, "preconditions": ["Chuẩn bị bệnh nhân với kháng sinh dự phòng"], "intervalFromStage1": null, "estimatedDurationMinutes": 120}, {"stageName": "Giai đoạn 2: Cấy ghép lại implant sau 6 tuần", "stageOrder": 2, "preconditions": ["Kháng sinh toàn thân trong 6 tuần"], "intervalFromStage1": 6, "estimatedDurationMinutes": 180}], "priorityNote": "Cần thực hiện phẫu thuật càng sớm càng tốt để tránh biến chứng.", "priorityLevel": "HIGH", "strategyRationale": "Bệnh nhân có nhiễm trùng khớp háng phải mãn tính do Staphylococcus aureus kháng Methicillin, cần phẫu thuật tái tạo hai giai đoạn.", "surgeryStrategyType": "TWO_STAGE_REVISION", "risksAndComplications": ["Nhiễm trùng vết mổ, tổn thương dây thần kinh, tái phát nhiễm trùng"], "estimatedTotalTreatmentTime": "Khoảng 12 tuần"}, "systemicAntibiotic": {"notes": "Cần theo dõi và điều chỉnh liều kháng sinh dựa trên chức năng thận và gan của bệnh nhân.", "phases": [{"phaseName": "Giai đoạn tấn công (Induction/IV phase)", "phaseOrder": 1, "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh glycopeptide, hiệu quả đối với Staphylococcus aureus kháng Methicillin.", "route": "IV", "dosage": "1g x 2 lần/ngày", "frequency": "IV", "sequenceOrder": 1, "antibioticName": "Vancomycin (Đã Chỉnh sửa)"}, {"role": "SYNERGISTIC", "notes": "Tăng cường hiệu quả điều trị và giảm thiểu kháng kháng sinh.", "route": "ORAL", "dosage": "450mg x 1 lần/ngày", "frequency": "ORAL", "sequenceOrder": 2, "antibioticName": "Rifampicin"}], "durationNote": "Sử dụng kháng sinh tĩnh mạch trong 2 tuần.", "durationWeeks": 2}, {"phaseName": "Giai đoạn duy trì (Oral phase)", "phaseOrder": 2, "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Tiếp tục sử dụng Rifampicin đường uống.", "route": "ORAL", "dosage": "450mg x 1 lần/ngày", "frequency": "ORAL", "sequenceOrder": 1, "antibioticName": "Rifampicin"}, {"role": "SYNERGISTIC", "notes": "Mặc dù có kết quả kháng Ciprofloxacin in vitro, nhưng vẫn có thể sử dụng với liều cao và theo dõi chặt chẽ.", "route": "ORAL", "dosage": "500mg x 2 lần/ngày", "frequency": "ORAL", "sequenceOrder": 2, "antibioticName": "Ciprofloxacin"}], "durationNote": "Chuyển sang kháng sinh đường uống trong 4 tuần.", "durationWeeks": 4}], "indication": "Nhiễm trùng khớp háng phải do Staphylococcus aureus kháng Methicillin", "monitoring": ["Theo dõi chức năng thận, gan và công thức máu"], "regimenName": "Phác đồ điều trị nhiễm trùng khớp háng phải", "contraindications": ["Bệnh nhân có tiền sử bệnh gan nặng"], "totalDurationWeeks": 6}}	\N	2026-04-11 14:02:31.649+00	2026-04-11 14:02:31.649+00	\N	admin@gmail.com
3	4	14	MODIFIED	Cũng tạm được	{"surgery": {"notes": "Cần theo dõi chặt chẽ bệnh nhân", "stages": [{"stageName": "Giai đoạn 1: Tháo bỏ implant", "stageOrder": 1, "preconditions": ["Chuẩn bị bệnh nhân", "Kiểm tra nhiễm trùng"], "intervalFromStage1": null, "estimatedDurationMinutes": 120}, {"stageName": "Giai đoạn 2: Lắp đặt implant mới", "stageOrder": 2, "preconditions": ["Kiểm tra nhiễm trùng âm tính"], "intervalFromStage1": 6, "estimatedDurationMinutes": 180}], "priorityNote": "Cần phẫu thuật khẩn cấp", "priorityLevel": "HIGH", "strategyRationale": "Nhiễm trùng khớp giả mạn tính", "surgeryStrategyType": "TWO_STAGE_REVISION", "risksAndComplications": ["Suy nhiễm trùng", "Thất bại implant"], "estimatedTotalTreatmentTime": "12 tuần"}, "systemicAntibiotic": {"notes": "Cân nhắc điều chỉnh liều theo chức năng thận", "phases": [{"phaseName": "Giai đoạn tấn công", "phaseOrder": 1, "antibiotics": [{"role": "PRIMARY", "notes": "Kháng sinh phổ rộng", "route": "IV", "dosage": "1g x 2 lần/ngày", "frequency": "IV", "sequenceOrder": 1, "antibioticName": "Vancomycin"}, {"role": "SYNERGISTIC", "notes": "Tác dụng hiệp đồng", "route": "PO", "dosage": "450mg x 1 lần/ngày", "frequency": "PO", "sequenceOrder": 2, "antibioticName": "Rifampsfsdfdsf"}], "durationWeeks": 2}, {"phaseName": "Giai đoạn duy trì", "phaseOrder": 2, "antibiotics": [{"role": "PRIMARY_ORAL", "notes": "Kháng sinh uống", "route": "PO", "dosage": "500mg x 2 lần/ngày", "frequency": "PO", "sequenceOrder": 1, "antibioticName": "Ciprofloxacin"}], "durationWeeks": 4}], "indication": "Nhiễm trùng khớp giả do Staphylococcus aureus", "monitoring": ["Theo dõi chức năng thận", "Theo dõi tác dụng phụ"], "regimenName": "Phác đồ điều trị nhiễm trùng khớp giả", "contraindications": ["Suy thận nặng"], "totalDurationWeeks": 6}}	\N	2026-04-11 14:40:52.713+00	2026-04-11 15:03:43.465+00	admin@gmail.com	admin@gmail.com
5	4	20	ACCEPTED	\N	\N	\N	2026-05-07 03:54:32.547+00	2026-05-07 10:09:36.787+00	admin@gmail.com	admin@gmail.com
6	5	22	ACCEPTED	tooi dong y	\N	\N	2026-05-09 11:51:10.06+00	2026-05-09 11:51:10.06+00	\N	admin@gmail.com
\.


--
-- Data for Name: image_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.image_results (id, episode_id, type, findings, file_metadata, created_at, updated_at, created_by, updated_by) FROM stdin;
4	4	X-ray	X-quang cho thấy dấu hiệu lỏng nhẹ chuôi khớp, có vùng tiêu xương quanh implant (Đã chỉnh sửa)	{"url": "http://localhost:9000/clinical-images/1775883391984-logo-teal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260411T045632Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=46e1cec6a6791889e0bdbca6d5f739301564265f02ba8ecacd84643a32853fe2", "name": "logo-teal.png"}	2026-04-11 04:56:35.754+00	2026-04-11 04:56:35.754808+00	\N	\N
5	3	X-ray	Anh chỉ để test nên không ý nghĩa gì cả	{"url": "http://localhost:9000/clinical-images/1778206624474-page_1.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260508%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260508T021704Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5471badf37ebcf84575bf05498cbd6b7ffcf76ce08fbb5611d824841084b8f21", "name": "page_1.jpeg"}	2026-05-08 02:17:31.32+00	2026-05-08 02:17:31.3221+00	\N	\N
6	5	X-ray	Ảnh mang tính chất thêm vào để test, nên chẳng có ý nghĩa gì cả	{"url": "http://localhost:9000/clinical-images/1778252303268-how-distributed.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20260508%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260508T145823Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=67aa6659e0857cc74b25f7922dc75c394b232b6a9a83d4d5ad2931cd2bf1e59e", "name": "how-distributed.png"}	2026-05-08 15:01:16.751+00	2026-05-08 15:01:16.751445+00	\N	\N
\.


--
-- Data for Name: lab_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lab_results (id, episode_id, biochemical_data, created_by, updated_by, created_at, updated_at, leu, fluid_analysis, hematology_tests) FROM stdin;
1	3	{"alt": {"unit": "U/L", "value": 62.3}, "ast": {"unit": "U/L", "value": 52}, "clo": {"unit": "mmol/L", "value": 90.7}, "ure": {"unit": "mmol/l", "value": 6.68}, "eGFR": {"unit": "mL/min/1.73m²", "value": 95}, "kali": {"unit": "mmol/L", "value": 3.6}, "hba1c": {"unit": "%", "value": 5.6}, "natri": {"unit": "mmol/L", "value": 128.8}, "albumin": {"unit": "g/L", "value": 41}, "glucose": {"unit": "mmol/l", "value": 9.67}, "creatinine": {"unit": "µmol/l", "value": 81}}	admin@gmail.com	admin@gmail.com	2026-03-16 15:01:10.604+00	2026-05-08 14:11:47.716+00	{"unit": "LEU/µL", "value": 9.0}	[{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "Dày đặc", "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": "91", "normalRange": ""}]	[{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": "17.97", "normalRange": "4 - 10"}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": "83.8", "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": "6.0", "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": "105", "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": "0.00", "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": "85.5", "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": "328", "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": "9", "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": "5", "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": "1", "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": "8", "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": "1", "normalRange": "< 0.12"}]
2	4	{"alt": {"unit": "U/L", "value": 44}, "ast": {"unit": "U/L", "value": 44}, "clo": {"unit": "mmol/L", "value": 2}, "ure": {"unit": "mmol/l", "value": 3}, "eGFR": {"unit": "mL/min/1.73m²", "value": 131}, "kali": {"unit": "mmol/L", "value": 3}, "hba1c": {"unit": "%", "value": 3}, "natri": {"unit": "mmol/L", "value": 111}, "albumin": {"unit": "g/L", "value": 44}, "glucose": {"unit": "mmol/l", "value": 3}, "creatinine": {"unit": "µmol/l", "value": 64}}	admin@gmail.com	admin@gmail.com	2026-04-11 03:18:56.321+00	2026-05-08 14:20:34.162+00	{"unit": "LEU/µL", "value": 11.0}	[{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "day", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": 138, "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": 96, "normalRange": ""}, {"name": "leukocyte_esterase", "value": "95"}, {"name": "alpha_defensin", "value": "100"}]	[{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": 120, "normalRange": ""}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": 45, "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": 6, "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": 6, "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": 6, "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": 99, "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": 34, "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": 36, "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": 5, "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": 1, "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": 6, "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": 1, "normalRange": "< 0.12"}, {"name": "serum_il6", "unit": "pg/mL", "value": 111}]
3	5	{"alt": {"unit": "U/L", "value": 62.3}, "ast": {"unit": "U/L", "value": 52}, "clo": {"unit": "mmol/L", "value": 90.7}, "ure": {"unit": "mmol/l", "value": 6.68}, "kali": {"unit": "mmol/L", "value": 3.6}, "hba1c": {"unit": "%", "value": 5}, "natri": {"unit": "mmol/L", "value": 128.8}, "albumin": {"unit": "g/L", "value": 45}, "glucose": {"unit": "mmol/l", "value": 9.67}, "creatinine": {"unit": "µmol/l", "value": 80}}	admin@gmail.com	\N	2026-05-08 15:01:16.637+00	2026-05-08 15:01:16.637+00	\N	[{"id": "fa_3", "name": "Bạch cầu (Dịch)", "unit": "Tế bào/Vi trường", "value": "Dày đặc", "normalRange": ""}, {"id": "fa_5", "name": "Định lượng CRP (Dịch)", "unit": "mg/l", "value": "90", "normalRange": ""}, {"id": "fa_6", "name": "%PMN (Dịch)", "unit": "%", "value": "91", "normalRange": ""}]	[{"id": "ht_1", "name": "wbc", "unit": "G/L", "value": "17.97", "normalRange": "4 - 10"}, {"id": "ht_2", "name": "%NEUT", "unit": "%", "value": "83.8", "normalRange": "40 - 74"}, {"id": "ht_4", "name": "%MONO", "unit": "%", "value": "6.0", "normalRange": "3.4 - 9"}, {"id": "ht_7", "name": "Máu lắng", "unit": "mm", "value": "105", "normalRange": "< 10"}, {"id": "ht_9", "name": "RBC", "unit": "x10^12/L", "value": "0.00", "normalRange": "3.8 - 5.5"}, {"id": "ht_12", "name": "MCV", "unit": "fL", "value": "85.5", "normalRange": "75 - 96"}, {"id": "ht_13", "name": "MCH", "unit": "pg", "value": "328", "normalRange": "24 - 33"}, {"id": "ht_15", "name": "Leukocyte Esterase", "unit": "LEU/µL", "value": "11", "normalRange": "10 - 25"}, {"id": "ht_16", "name": "IG%", "unit": "fL", "value": "5", "normalRange": "6 - 11"}, {"id": "ht_17", "name": "D-dimer", "unit": "mg/L FEU", "value": "1", "normalRange": "< 0.5"}, {"id": "ht_18", "name": "Serum IL-6", "unit": "pg/mL", "value": "6", "normalRange": "< 7.0"}, {"id": "ht_19", "name": "Alpha Defensin", "unit": "ug/mL", "value": "1", "normalRange": "< 0.12"}]
\.


--
-- Data for Name: medical_histories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medical_histories (episode_id, medical_history, process, antibiotic_history, is_allergy, allergy_note, is_drug, drug_note, is_alcohol, alcohol_note, is_smoking, smoking_note, is_other, other_note, created_by, updated_by, created_at, updated_at) FROM stdin;
3	Cao huyết áp mãn tính, từng phẫu thuật ruột thừa năm 2018	Bệnh khởi phát 3 ngày trước với triệu chứng ho khan, sau đó chuyển sang sốt cao 39°C	Nti jio lolo kakaka	t	Dị ứng hải sản (tôm, cua) và phấn hoa	t	Dị ứng thuốc kháng sinh nhóm Penicillin	f		t	Hút thuốc lá 1 bao/ngày trong khoảng 10 năm	f		admin@gmail.com	admin@gmail.com	2026-03-16 13:32:36.762+00	2026-04-10 14:25:04.367+00
4	Tăng huyết áp 5 năm (điều trị ổn định), đái tháo đường type 2.	Bệnh nhân đau tăng dần vùng khớp háng phải trong 2 tuần gần đây, kèm sưng nhẹ, nóng tại chỗ. Có sốt nhẹ 37.8°C. Đi lại khó khăn, đau khi chịu lực.	Đã dùng Amoxicillin 1g x 2 lần/ngày trong 5 ngày trước nhập viện, không cải thiện.	t	Dị ứng hải sản (tôm, cua) và phấn hoa	f		f		f		f		admin@gmail.com	\N	2026-04-11 03:18:56.194+00	2026-04-11 03:18:56.194+00
5	Đái tháo đường Tuýp 2: Phát hiện 10 năm, đang điều trị bằng Metformin. Chỉ số HbA1c xét nghiệm gần nhất: 7.8% (Kiểm soát đường huyết chưa thực sự tốt).\nTăng huyết áp: Đang duy trì Losartan 50mg/ngày, huyết áp mục tiêu 135/85 mmHg.	Cách nhập viện 3 tháng, bệnh nhân bắt đầu có cảm giác đau âm ỉ vùng gối Phải, đau tăng lên khi đi lại và cả về ban đêm.\nBệnh nhân không sốt cao, chỉ có cảm giác gai rét nhẹ vào buổi chiều. Đã tự mua thuốc giảm đau uống nhưng tình trạng không thuyên giảm.	Dị ứng: Không có tiền sử dị ứng thuốc (No known drug allergies).Sử dụng kháng sinh gần đây:\nLoại thuốc: Ciprofloxacin 500mg.	f		f		f		f		f		admin@gmail.com	\N	2026-05-08 15:01:16.58+00	2026-05-08 15:01:16.58+00
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patients (id, patient_code, full_name, date_of_birth, gender, identity_card, insurance_number, insurance_expired, nationality, ethnicity, phone, career, subject, address, relative_info, created_by, updated_by, created_at, updated_at) FROM stdin;
2	2026E4D9A6	Lê Hoàng Tùng	2003-03-15	MALE	012345678912	GD47979123456	2028-12-31	Việt Nam	Kinh	0987654321	Kỹ sư	Bảo hiểm y tế	Số 1, Đường ABC, Quận 1, TP.HCM	{"name": "Trần Thị Hoa Hu", "phone": "0909123456"}	admin@gmail.com	admin@gmail.com	2026-03-15 15:55:53.982+00	2026-03-23 13:37:10.545+00
6	20268AA6D3	Phạm Thanh Huyền	2002-03-23	FEMALE	0934228877	0568090112	2029-10-23	Việt Nam	Kinh	098765421	Sinh viên	\N	Đông Tiền Hải, Thái Bình	{"name": "Hoàng Mạnh Thắng", "phone": "082382556"}	admin@gmail.com	\N	2026-03-23 13:51:48.547+00	2026-03-23 13:51:48.547+00
7	20267FD9C1	Vũ Hồng Diệp	2003-05-01	FEMALE	04234338222	04823823577	2029-08-30	Việt Nam	Kinh	0989031123	Giảng Viên	\N	188 trương định, Hà Nội	{"name": "Vũ Mạnh Hưng", "phone": "0833811124"}	admin@gmail.com	\N	2026-04-11 13:51:39.443+00	2026-04-11 13:51:39.444+00
8	2026B46CE0	Phạm Trung Hiếu	2005-10-12	MALE	034243488873	03842877842	2029-11-28	Việt Nam	Kinh	097343482	Sinh Viên	\N	Tiền Hải, Thái Bình	{"name": "Phạm Hoàng Thắng", "phone": "0345723948"}	admin@gmail.com	\N	2026-04-11 14:29:50.29+00	2026-04-11 14:29:50.29+00
9	202694FF9B	Trịnh Khánh Linh	2005-10-12	FEMALE	034205887624	022567908166	2029-12-12	Việt Nam	Kinh	0978181619	Lập trình viên	\N	xóm 5 thôn hải nhuận xã đông quý	{"name": "Trịnh Xuân Nam update", "phone": "0835576911"}	admin@gmail.com	admin@gmail.com	2026-05-08 14:25:48.446+00	2026-05-09 11:31:37.818+00
\.


--
-- Data for Name: pending_lab_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pending_lab_tasks (id, created_at, created_by, updated_at, updated_by, assigned_to_user_id, category, created_from_run_id, field, importance, message, status, episode_id, fulfilled_lab_result_id, patient_id) FROM stdin;
1	2026-05-06 21:49:30.822	 	2026-05-07 17:20:21.509	admin@gmail.com	2	ICM_MINOR	16	serum_CRP	HIGH	CRP huyet thanh (2 diem ICM) — marker viem he thong	PENDING	4	\N	2
2	2026-05-06 21:49:30.834	 	2026-05-07 17:20:21.523	admin@gmail.com	2	ICM_MINOR	16	serum_ESR	HIGH	Toc do mau lang ESR (1 diem ICM)	PENDING	4	\N	2
3	2026-05-06 21:49:30.84	 	2026-05-07 17:20:21.531	admin@gmail.com	2	ICM_MINOR	16	serum_D_Dimer	HIGH	D-Dimer (2 diem ICM, ket hop CRP)	PENDING	4	\N	2
8	2026-05-06 21:49:30.882	 	2026-05-08 21:14:50.147	admin@gmail.com	2	ICM_MINOR	16	synovial_LE	MEDIUM	Leukocyte Esterase dich khop (3 diem ICM) — test nhanh tai cho	FULFILLED	4	2	2
7	2026-05-06 21:49:30.873	 	2026-05-08 21:16:32.014	admin@gmail.com	2	ICM_MINOR	16	synovial_alpha_defensin	HIGH	Alpha-Defensin (3 diem ICM) — do dac hieu >96%	FULFILLED	4	2	2
4	2026-05-06 21:49:30.846	 	2026-05-08 21:20:34.16	admin@gmail.com	2	ICM_MINOR	16	serum_IL6	MEDIUM	IL-6 huyet thanh (1 diem ICM)	FULFILLED	4	2	2
9	2026-05-06 21:49:30.889	 	2026-05-08 21:22:48.059	admin@gmail.com	2	ICM_MINOR	16	positive_histology	HIGH	Giai phau benh mo quanh khop (3 diem ICM) — can sinh thiet mo trong phau thuat	DISMISSED	4	\N	2
6	2026-05-06 21:49:30.862	 	2026-05-08 21:22:49.585	admin@gmail.com	2	ICM_MINOR	16	synovial_PMN	HIGH	PMN% dich khop (2 diem ICM)	DISMISSED	4	\N	2
5	2026-05-06 21:49:30.852	 	2026-05-08 21:22:51.085	admin@gmail.com	2	ICM_MINOR	16	synovial_WBC	CRITICAL	Bach cau dich khop (3 diem ICM) — marker quan trong nhat	DISMISSED	4	\N	2
10	2026-05-09 11:48:25.958	 	2026-05-09 11:48:25.958	\N	\N	ICM_MAJOR	21	culture_results	CRITICAL	Khong co ket qua nuoi cay — can it nhat 2 mau de danh gia major criterion	PENDING	5	\N	9
11	2026-05-09 11:48:25.964	 	2026-05-09 11:48:25.964	\N	\N	ICM_MINOR	21	serum_CRP	HIGH	CRP huyet thanh (2 diem ICM) — marker viem he thong	PENDING	5	\N	9
12	2026-05-09 11:48:25.967	 	2026-05-09 11:48:25.967	\N	\N	ICM_MINOR	21	serum_ESR	HIGH	Toc do mau lang ESR (1 diem ICM)	PENDING	5	\N	9
13	2026-05-09 11:48:25.971	 	2026-05-09 11:48:25.971	\N	\N	ICM_MINOR	21	serum_D_Dimer	HIGH	D-Dimer (2 diem ICM, ket hop CRP)	PENDING	5	\N	9
14	2026-05-09 11:48:25.975	 	2026-05-09 11:48:25.975	\N	\N	ICM_MINOR	21	serum_IL6	MEDIUM	IL-6 huyet thanh (1 diem ICM)	PENDING	5	\N	9
15	2026-05-09 11:48:25.978	 	2026-05-09 11:48:25.978	\N	\N	ICM_MINOR	21	synovial_WBC	CRITICAL	Bach cau dich khop (3 diem ICM) — marker quan trong nhat	PENDING	5	\N	9
16	2026-05-09 11:48:25.982	 	2026-05-09 11:48:25.982	\N	\N	ICM_MINOR	21	synovial_PMN	HIGH	PMN% dich khop (2 diem ICM)	PENDING	5	\N	9
17	2026-05-09 11:48:25.985	 	2026-05-09 11:48:25.985	\N	\N	ICM_MINOR	21	synovial_alpha_defensin	HIGH	Alpha-Defensin (3 diem ICM) — do dac hieu >96%	PENDING	5	\N	9
18	2026-05-09 11:48:25.988	 	2026-05-09 11:48:25.988	\N	\N	ICM_MINOR	21	synovial_LE	MEDIUM	Leukocyte Esterase dich khop (3 diem ICM) — test nhanh tai cho	PENDING	5	\N	9
19	2026-05-09 11:48:25.991	 	2026-05-09 11:48:25.991	\N	\N	ICM_MINOR	21	positive_histology	HIGH	Giai phau benh mo quanh khop (3 diem ICM) — can sinh thiet mo trong phau thuat	PENDING	5	\N	9
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.permissions (id, api_path, method, module, name, created_by, created_at, updated_by, updated_at) FROM stdin;
1	/api/v1/patients	POST	PATIENTS	Create a patient	 	2026-03-15 15:10:17.087+00	\N	2026-03-15 15:10:17.087+00
2	/api/v1/patients/{id}	PUT	PATIENTS	Update a patient	 	2026-03-15 15:10:17.115+00	\N	2026-03-15 15:10:17.115+00
3	/api/v1/patients/{id}	DELETE	PATIENTS	Delete a patient	 	2026-03-15 15:10:17.118+00	\N	2026-03-15 15:10:17.118+00
4	/api/v1/patients/{id}	GET	PATIENTS	Get patient by id	 	2026-03-15 15:10:17.12+00	\N	2026-03-15 15:10:17.12+00
5	/api/v1/patients	GET	PATIENTS	Get patients with pagination	 	2026-03-15 15:10:17.123+00	\N	2026-03-15 15:10:17.123+00
6	/api/v1/episodes	POST	EPISODES	Create an episode	 	2026-03-15 15:10:17.125+00	\N	2026-03-15 15:10:17.125+00
7	/api/v1/episodes/{id}	PUT	EPISODES	Update an episode	 	2026-03-15 15:10:17.128+00	\N	2026-03-15 15:10:17.128+00
8	/api/v1/episodes/{id}	DELETE	EPISODES	Delete an episode	 	2026-03-15 15:10:17.131+00	\N	2026-03-15 15:10:17.131+00
9	/api/v1/episodes/{id}	GET	EPISODES	Get episode by id	 	2026-03-15 15:10:17.134+00	\N	2026-03-15 15:10:17.134+00
10	/api/v1/episodes	GET	EPISODES	Get episodes with pagination	 	2026-03-15 15:10:17.137+00	\N	2026-03-15 15:10:17.137+00
11	/api/v1/patients/{patientId}/episodes	GET	EPISODES	Get episodes by patient	 	2026-03-15 15:10:17.14+00	\N	2026-03-15 15:10:17.14+00
12	/api/v1/episodes/{episodeId}/medical-history	POST	MEDICAL_HISTORY	Create medical history	 	2026-03-15 15:10:17.142+00	\N	2026-03-15 15:10:17.142+00
13	/api/v1/episodes/{episodeId}/medical-history	PUT	MEDICAL_HISTORY	Update medical history	 	2026-03-15 15:10:17.145+00	\N	2026-03-15 15:10:17.145+00
14	/api/v1/episodes/{episodeId}/medical-history	GET	MEDICAL_HISTORY	Get medical history	 	2026-03-15 15:10:17.148+00	\N	2026-03-15 15:10:17.148+00
15	/api/v1/clinical-records	POST	CLINICAL_RECORDS	Create clinical record	 	2026-03-15 15:10:17.151+00	\N	2026-03-15 15:10:17.151+00
16	/api/v1/clinical-records/{id}	PUT	CLINICAL_RECORDS	Update clinical record	 	2026-03-15 15:10:17.153+00	\N	2026-03-15 15:10:17.153+00
17	/api/v1/clinical-records/{id}	DELETE	CLINICAL_RECORDS	Delete clinical record	 	2026-03-15 15:10:17.156+00	\N	2026-03-15 15:10:17.156+00
18	/api/v1/clinical-records/{id}	GET	CLINICAL_RECORDS	Get clinical record by id	 	2026-03-15 15:10:17.159+00	\N	2026-03-15 15:10:17.159+00
19	/api/v1/episodes/{episodeId}/clinical-records	GET	CLINICAL_RECORDS	Get clinical records by episode	 	2026-03-15 15:10:17.161+00	\N	2026-03-15 15:10:17.161+00
20	/api/v1/surgeries	POST	SURGERIES	Create surgery	 	2026-03-15 15:10:17.164+00	\N	2026-03-15 15:10:17.164+00
21	/api/v1/surgeries/{id}	PUT	SURGERIES	Update surgery	 	2026-03-15 15:10:17.167+00	\N	2026-03-15 15:10:17.167+00
22	/api/v1/surgeries/{id}	DELETE	SURGERIES	Delete surgery	 	2026-03-15 15:10:17.17+00	\N	2026-03-15 15:10:17.17+00
23	/api/v1/surgeries/{id}	GET	SURGERIES	Get surgery by id	 	2026-03-15 15:10:17.172+00	\N	2026-03-15 15:10:17.172+00
24	/api/v1/episodes/{episodeId}/surgeries	GET	SURGERIES	Get surgeries by episode	 	2026-03-15 15:10:17.176+00	\N	2026-03-15 15:10:17.176+00
25	/api/v1/lab-results	POST	LAB_RESULTS	Create lab result	 	2026-03-15 15:10:17.179+00	\N	2026-03-15 15:10:17.179+00
26	/api/v1/lab-results/{id}	PUT	LAB_RESULTS	Update lab result	 	2026-03-15 15:10:17.182+00	\N	2026-03-15 15:10:17.182+00
27	/api/v1/lab-results/{id}	DELETE	LAB_RESULTS	Delete lab result	 	2026-03-15 15:10:17.184+00	\N	2026-03-15 15:10:17.184+00
28	/api/v1/lab-results/{id}	GET	LAB_RESULTS	Get lab result by id	 	2026-03-15 15:10:17.188+00	\N	2026-03-15 15:10:17.188+00
29	/api/v1/episodes/{episodeId}/lab-results	GET	LAB_RESULTS	Get lab results by episode	 	2026-03-15 15:10:17.189+00	\N	2026-03-15 15:10:17.189+00
30	/api/v1/image-results	POST	IMAGE_RESULTS	Create image result	 	2026-03-15 15:10:17.193+00	\N	2026-03-15 15:10:17.193+00
31	/api/v1/image-results/{id}	PUT	IMAGE_RESULTS	Update image result	 	2026-03-15 15:10:17.196+00	\N	2026-03-15 15:10:17.196+00
32	/api/v1/image-results/{id}	DELETE	IMAGE_RESULTS	Delete image result	 	2026-03-15 15:10:17.198+00	\N	2026-03-15 15:10:17.198+00
33	/api/v1/image-results/{id}	GET	IMAGE_RESULTS	Get image result by id	 	2026-03-15 15:10:17.2+00	\N	2026-03-15 15:10:17.2+00
34	/api/v1/episodes/{episodeId}/image-results	GET	IMAGE_RESULTS	Get image results by episode	 	2026-03-15 15:10:17.203+00	\N	2026-03-15 15:10:17.203+00
35	/api/v1/culture-results	POST	CULTURE_RESULTS	Create culture result	 	2026-03-15 15:10:17.205+00	\N	2026-03-15 15:10:17.205+00
36	/api/v1/culture-results/{id}	PUT	CULTURE_RESULTS	Update culture result	 	2026-03-15 15:10:17.208+00	\N	2026-03-15 15:10:17.208+00
37	/api/v1/culture-results/{id}	DELETE	CULTURE_RESULTS	Delete culture result	 	2026-03-15 15:10:17.21+00	\N	2026-03-15 15:10:17.21+00
38	/api/v1/culture-results/{id}	GET	CULTURE_RESULTS	Get culture result by id	 	2026-03-15 15:10:17.214+00	\N	2026-03-15 15:10:17.214+00
39	/api/v1/episodes/{episodeId}/culture-results	GET	CULTURE_RESULTS	Get culture results by episode	 	2026-03-15 15:10:17.217+00	\N	2026-03-15 15:10:17.217+00
40	/api/v1/sensitivity-results	POST	SENSITIVITY_RESULTS	Create sensitivity result	 	2026-03-15 15:10:17.219+00	\N	2026-03-15 15:10:17.219+00
41	/api/v1/sensitivity-results/{id}	PUT	SENSITIVITY_RESULTS	Update sensitivity result	 	2026-03-15 15:10:17.221+00	\N	2026-03-15 15:10:17.221+00
42	/api/v1/sensitivity-results/{id}	DELETE	SENSITIVITY_RESULTS	Delete sensitivity result	 	2026-03-15 15:10:17.224+00	\N	2026-03-15 15:10:17.224+00
43	/api/v1/sensitivity-results/{id}	GET	SENSITIVITY_RESULTS	Get sensitivity result by id	 	2026-03-15 15:10:17.226+00	\N	2026-03-15 15:10:17.226+00
44	/api/v1/culture-results/{cultureId}/sensitivity-results	GET	SENSITIVITY_RESULTS	Get sensitivity results by culture	 	2026-03-15 15:10:17.229+00	\N	2026-03-15 15:10:17.229+00
45	/api/v1/add-permission	POST	PERMISSIONS	Create a permission	 	2026-03-15 15:10:17.231+00	\N	2026-03-15 15:10:17.231+00
46	/api/v1/update-permission	PUT	PERMISSIONS	Update a permission	 	2026-03-15 15:10:17.233+00	\N	2026-03-15 15:10:17.233+00
47	/api/v1/delete-permission/{id}	DELETE	PERMISSIONS	Delete a permission	 	2026-03-15 15:10:17.235+00	\N	2026-03-15 15:10:17.235+00
48	/api/v1/permission/{id}	GET	PERMISSIONS	Get a permission by id	 	2026-03-15 15:10:17.238+00	\N	2026-03-15 15:10:17.238+00
49	/api/v1/permissions	GET	PERMISSIONS	Get permission with pagination	 	2026-03-15 15:10:17.24+00	\N	2026-03-15 15:10:17.24+00
50	/api/v1/add-role	POST	ROLES	Create a role	 	2026-03-15 15:10:17.243+00	\N	2026-03-15 15:10:17.243+00
51	/api/v1/update-role	PUT	ROLES	Update a role	 	2026-03-15 15:10:17.245+00	\N	2026-03-15 15:10:17.245+00
52	/api/v1/delete-role/{id}	DELETE	ROLES	Delete a role	 	2026-03-15 15:10:17.247+00	\N	2026-03-15 15:10:17.247+00
53	/api/v1/role/{id}	GET	ROLES	Get role by id	 	2026-03-15 15:10:17.249+00	\N	2026-03-15 15:10:17.249+00
54	/api/v1/roles	GET	ROLES	Get roles with pagination	 	2026-03-15 15:10:17.251+00	\N	2026-03-15 15:10:17.251+00
55	/api/v1/add-user	POST	USERS	Create a user	 	2026-03-15 15:10:17.254+00	\N	2026-03-15 15:10:17.254+00
56	/api/v1/update-user	PUT	USERS	Update a user	 	2026-03-15 15:10:17.256+00	\N	2026-03-15 15:10:17.256+00
57	/api/v1/delete-user/{id}	DELETE	USERS	Delete a user	 	2026-03-15 15:10:17.258+00	\N	2026-03-15 15:10:17.258+00
58	/api/v1/user/{id}	GET	USERS	Get a user by id	 	2026-03-15 15:10:17.26+00	\N	2026-03-15 15:10:17.26+00
59	/api/v1/users	GET	USERS	Get users with pagination	 	2026-03-15 15:10:17.262+00	\N	2026-03-15 15:10:17.262+00
60	/api/v1/files	POST	FILES	Upload file	 	2026-03-15 15:10:17.264+00	\N	2026-03-15 15:10:17.264+00
61	/api/v1/episodes/{episodeId}/ai-recommendations/generate	POST	RAG	Generate AI recommendation	admin@gmail.com	2026-04-06 13:46:25.841+00	\N	2026-04-06 13:46:25.841+00
62	/api/v1/ai-recommendations/runs/{runId}	GET	RAG	Get status	admin@gmail.com	2026-04-06 15:26:00.712+00	\N	2026-04-06 15:26:00.712+00
63	/api/v1/ai-chat/sessions	POST	RAG	Create a new AI chat session	admin@gmail.com	2026-04-09 03:13:16.405+00	\N	2026-04-09 03:13:16.405+00
64	/api/v1/ai-chat/sessions/{sessionId}/messages	POST	RAG	Send a message to AI chat and get response	admin@gmail.com	2026-04-09 03:15:39.488+00	\N	2026-04-09 03:15:39.488+00
65	/api/v1/ai-chat/sessions/{sessionId}/messages	GET	RAG	Get messages of a chat session	admin@gmail.com	2026-04-09 03:16:23.22+00	\N	2026-04-09 03:16:23.22+00
66	/api/v1/episodes/{episodeId}/ai-chat/sessions	GET	RAG	Get chat sessions for an episode	admin@gmail.com	2026-04-09 03:16:48.219+00	\N	2026-04-09 03:16:48.219+00
67	/api/v1/episodes/{episodeId}/doctor-reviews	POST	RAG	Create or update a doctor review	admin@gmail.com	2026-04-09 03:18:46.361+00	\N	2026-04-09 03:18:46.361+00
68	/api/v1/ai-recommendations/runs/{runId}/review	GET	RAG	Get doctor review for a specific AI recommendation run	admin@gmail.com	2026-04-09 03:19:28.043+00	\N	2026-04-09 03:19:28.043+00
69	/api/v1/episodes/{episodeId}/doctor-reviews	GET	RAG	Get all doctor reviews for an episode	admin@gmail.com	2026-04-09 03:20:06.092+00	\N	2026-04-09 03:20:06.092+00
70	/api/v1/episodes/{episodeId}/ai-recommendations/runs	GET	RAG	Get AI recommendation run history for an episode	admin@gmail.com	2026-04-09 04:24:42.73+00	\N	2026-04-09 04:24:42.73+00
71	/api/v1/pending-lab-tasks/my	GET	LAB_RESULTS	Fetch pending tasks	admin@gmail.com	2026-05-05 14:57:50.383+00	\N	2026-05-05 14:57:50.383+00
72	/api/v1/pending-lab-tasks/my/count	GET	LAB_RESULTS	Pending task count	admin@gmail.com	2026-05-05 15:03:14.34+00	\N	2026-05-05 15:03:14.34+00
73	/api/v1/pending-lab-tasks/{id}/dismiss	POST	LAB_RESULTS	Task dismissed	admin@gmail.com	2026-05-05 15:04:05.549+00	\N	2026-05-05 15:04:05.549+00
74	/api/v1/pending-lab-tasks/{id}/quick-entry	POST	LAB_RESULTS	quick entry	admin@gmail.com	2026-05-05 15:05:03.93+00	\N	2026-05-05 15:05:03.93+00
75	/api/v1/episodes/{episodeId}/pending-lab-tasks/from-completeness	POST	LAB_RESULTS	create from Completeness	admin@gmail.com	2026-05-05 15:05:46.376+00	\N	2026-05-05 15:05:46.376+00
76	/api/v1/extract-images/jobs	POST	EXTRACT_IMAGE	Create an extract-images job from uploaded	admin@gmail.com	2026-05-05 15:34:13.255+00	\N	2026-05-05 15:34:13.255+00
77	/api/v1/extract-images/jobs/{jobId}	GET	EXTRACT_IMAGE	Get extract-images job result	admin@gmail.com	2026-05-05 15:35:15.405+00	\N	2026-05-05 15:35:15.405+00
\.


--
-- Data for Name: pji_episodes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pji_episodes (id, patient_id, admission_date, discharge_date, department, treatment_days, direct, reason, referral_source, status, result, created_by, updated_by, created_at, updated_at) FROM stdin;
3	2	2026-02-10	2026-03-26	Khoa Nội tổng hợp	5	CC	Viêm phổi cấp tính	Bệnh viện tuyến dưới (Bệnh viện Quận 1)	Hoàn thành điều trị	Ổn định, cho xuất viện edit	admin@gmail.com	admin@gmail.com	2026-03-16 13:22:33.656+00	2026-04-10 15:42:58.517+00
4	2	2026-04-01	2026-04-09	Khoa A4C	22	KKB	We and our partners store and/or access information on a device, such as cookies and process personal data	Bệnh viện đa khoa thái bình	Hoàn thành điều trị	Ổn định, cho xuất viện	admin@gmail.com	\N	2026-04-11 03:18:56.107+00	2026-04-11 03:18:56.107+00
5	9	2026-01-25	2026-02-01	Khoa Chỉnh Hình	8	KDT	Đau khớp gối Phải kèm lỗ rò chảy dịch.	Không có	Hoàn thành điều trị	Ổn định, cho xuất viện	admin@gmail.com	\N	2026-05-08 15:01:16.533+00	2026-05-08 15:01:16.533+00
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
4	1
4	2
4	3
4	4
4	5
4	6
4	7
4	8
4	9
4	10
4	11
4	12
4	13
4	14
4	15
4	16
4	17
4	18
4	19
4	20
4	21
4	22
4	23
4	24
4	25
4	26
4	27
4	28
4	29
4	30
4	31
4	32
4	33
4	34
4	35
4	36
4	37
4	38
4	39
4	40
4	41
4	42
4	43
4	44
4	60
4	61
4	62
4	63
4	64
4	65
4	66
4	67
4	68
4	69
4	70
4	71
4	72
4	73
4	74
4	75
4	76
4	77
5	1
5	2
5	3
5	4
5	5
5	6
5	7
5	8
3	1
3	2
3	3
3	4
3	5
3	6
3	7
3	8
3	9
3	10
3	11
3	12
3	13
3	14
3	15
3	16
3	17
3	18
3	19
3	20
3	21
3	22
3	23
3	24
3	25
3	26
3	27
3	28
3	29
3	30
3	31
3	32
3	33
3	34
3	35
3	36
3	37
3	38
3	39
3	40
3	41
3	42
3	43
3	44
3	45
3	46
3	47
3	48
3	49
3	50
3	51
3	52
3	53
3	54
3	55
3	56
3	57
3	58
3	59
3	60
3	61
3	62
3	63
3	64
3	65
3	66
3	67
3	68
3	69
3	70
3	71
3	72
3	73
3	74
3	75
3	76
3	77
5	9
5	10
5	11
5	12
5	13
5	14
5	15
5	16
5	17
5	18
5	19
5	20
5	21
5	22
5	23
5	24
5	25
5	26
5	27
5	28
5	29
5	30
5	31
5	32
5	33
5	34
5	35
5	36
5	37
5	38
5	39
5	40
5	41
5	42
5	43
5	44
5	60
5	71
5	72
5	73
5	74
5	75
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, description, active, created_at, created_by, updated_by, updated_at) FROM stdin;
3	ADMIN	Contain full of permissions on this web service hihi	t	2026-03-15 15:10:17.326+00	 	admin@gmail.com	2026-05-05 15:36:18.612+00
4	DOCTOR	Doctor role	t	2026-05-07 10:35:02.276+00	admin@gmail.com	\N	2026-05-07 10:35:02.276+00
5	NURSE	nurse role	t	2026-05-07 10:36:11.528+00	admin@gmail.com	\N	2026-05-07 10:36:11.528+00
\.


--
-- Data for Name: sensitivity_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sensitivity_results (id, culture_id, antibiotic_name, mic_value, sensitivity_code, created_by, updated_by, created_at, updated_at) FROM stdin;
6	2	stack brobro	>=99	S	admin@gmail.com	\N	2026-04-10 15:42:58.89+00	2026-04-10 15:42:58.89+00
10	5	Clindamycin	>=8	R	admin@gmail.com	\N	2026-04-11 04:30:07.001+00	2026-04-11 04:30:07.001+00
11	5	Ciprofloxacin	>=4	R	admin@gmail.com	\N	2026-04-11 04:30:07.001+00	2026-04-11 04:30:07.001+00
5	1	Khoojoojo	>= 88	R	admin@gmail.com	admin@gmail.com	2026-04-10 14:25:04.78+00	2026-04-11 14:31:56.243+00
4	1	MedicinXin	>=76	R	admin@gmail.com	admin@gmail.com	2026-04-10 14:25:04.775+00	2026-04-11 14:31:56.244+00
12	6	tobramycin	16	R	admin@gmail.com	\N	2026-04-12 04:30:43.93+00	2026-04-12 04:30:43.93+00
13	6	Amikacin	8	R	admin@gmail.com	\N	2026-04-12 04:30:43.938+00	2026-04-12 04:30:43.938+00
14	6	 Piperacillin/tazobactam	8	S	admin@gmail.com	\N	2026-04-12 04:30:43.936+00	2026-04-12 04:30:43.936+00
15	6	ciprofloxacin	8	R	admin@gmail.com	\N	2026-04-12 04:30:43.944+00	2026-04-12 04:30:43.944+00
16	6	Meropenem	2	S	admin@gmail.com	\N	2026-04-12 04:30:43.961+00	2026-04-12 04:30:43.961+00
17	7	Vancomycin	>=76	S	admin@gmail.com	\N	2026-05-08 15:01:16.792+00	2026-05-08 15:01:16.792+00
\.


--
-- Data for Name: surgeries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.surgeries (id, episode_id, surgery_date, surgery_type, findings, created_at, updated_at, updated_by, created_by) FROM stdin;
1	3	2026-04-05	fgfgdfg edit	sfdsfsdfsdf edittt	2026-04-10 14:28:07.882+00	2026-04-10 15:42:58.615+00	admin@gmail.com	admin@gmail.com
3	4	2025-10-15	Thay khớp gối toàn phần	Có nhiễm trùng vết mổ sớm sau mổ	2026-04-11 04:16:50.745+00	2026-04-11 04:16:50.745+00	\N	admin@gmail.com
4	4	2024-11-24	Thay khớp háng toàn phần (Total Hip Arthroplasty)	Ca mổ thuận lợi, không biến chứng sớm	2026-04-11 04:16:50.745+00	2026-04-11 04:16:50.745+00	\N	admin@gmail.com
5	5	2025-10-20	Thay khớp gối toàn phần (TKA) bên Phả	Vết mổ ban đầu chậm liền, có tình trạng rỉ dịch thấm băng trong 2 tuần đầu nhưng sau đó ổn định mà không cần can thiệp phẫu thuật lại	2026-05-08 15:01:16.607+00	2026-05-08 15:01:16.607+00	\N	admin@gmail.com
\.


--
-- Data for Name: treatment_plan_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.treatment_plan_versions (id, episode_id, source_run_id, source_review_id, version_no, is_current, status, regimen_json, clinical_rationale, confirmed_by, confirmed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, role_id, email, password, fullname, phone, department, is_active, last_login_at, created_by, updated_by, created_at, updated_at, avatar, refresh_token, status, last_login) FROM stdin;
3	3	hoangtung@example.com	$2a$10$y1hJcNFb7Os3rlWaB/BD3ezmcxMQWko7u/Ik2hGUaDLhaGvtegjwy	Hoang Tung	0989879322	A4C	t	\N	admin@gmail.com	\N	2026-03-15 15:17:41.518+00	2026-03-15 15:17:41.518+00	\N	\N	ACTIVE	\N
2	3	admin@gmail.com	$2a$10$DN0bSuyoYJO8aVCVZHbQ/Ow.9vlh3E6u9bHydMo7cWyGymO92yAl2	Pham Trung Hiếu	0978971623	A4C	t	\N	 	admin@gmail.com	2026-03-15 15:10:17.639+00	2026-05-09 11:30:58.843+00	\N	eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJ1c2VyIGFjY291bnQiOnsiaWQiOjIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibmFtZSI6IlBoYW0gVHJ1bmcgSGnhur91In0sImV4cCI6MTc3ODkzMTA1OCwiaWF0IjoxNzc4MzI2MjU4fQ.rzZjt5Cd6RKZt_SKq2-dGlM4BX1WtdYOmihEY-19ZfvBzsIRy6ILiChhCGCxg-6onaLBouTz8upcQDlo5YqUAg	ACTIVE	2026-05-09 11:30:58.842858+00
4	4	phamvanthang786@gmail.com	$2a$10$.FnMh4Az7KGfik3KmsjdBehi9NAc5OnsuK0R8EeQH4V6b78DpCQh2	Nekowear Pham	0978971623	A4C	t	\N	admin@gmail.com	phamvanthang786@gmail.com	2026-05-07 14:35:19.236+00	2026-05-08 01:58:48.018+00	\N	\N	ACTIVE	2026-05-08 01:57:42.026972+00
\.


--
-- Name: ai_chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ai_chat_messages_id_seq', 20, true);


--
-- Name: ai_chat_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ai_chat_sessions_id_seq', 4, true);


--
-- Name: ai_rag_citations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ai_rag_citations_id_seq', 75, true);


--
-- Name: ai_recommendation_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ai_recommendation_items_id_seq', 67, true);


--
-- Name: ai_recommendation_runs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ai_recommendation_runs_id_seq', 22, true);


--
-- Name: case_clinical_snapshots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.case_clinical_snapshots_id_seq', 26, true);


--
-- Name: clinical_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clinical_records_id_seq', 4, true);


--
-- Name: culture_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.culture_results_id_seq', 7, true);


--
-- Name: doctor_recommendation_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.doctor_recommendation_reviews_id_seq', 6, true);


--
-- Name: image_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.image_results_id_seq', 6, true);


--
-- Name: lab_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lab_results_id_seq', 3, true);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.patients_id_seq', 9, true);


--
-- Name: pending_lab_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pending_lab_tasks_id_seq', 19, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permissions_id_seq', 77, true);


--
-- Name: pji_episodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pji_episodes_id_seq', 5, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 5, true);


--
-- Name: sensitivity_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sensitivity_results_id_seq', 17, true);


--
-- Name: surgeries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.surgeries_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: ai_chat_messages ai_chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_messages
    ADD CONSTRAINT ai_chat_messages_pkey PRIMARY KEY (id);


--
-- Name: ai_chat_sessions ai_chat_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_sessions
    ADD CONSTRAINT ai_chat_sessions_pkey PRIMARY KEY (id);


--
-- Name: ai_rag_citations ai_rag_citations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_rag_citations
    ADD CONSTRAINT ai_rag_citations_pkey PRIMARY KEY (id);


--
-- Name: ai_recommendation_items ai_recommendation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_recommendation_items
    ADD CONSTRAINT ai_recommendation_items_pkey PRIMARY KEY (id);


--
-- Name: ai_recommendation_runs ai_recommendation_runs_episode_id_run_no_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_recommendation_runs
    ADD CONSTRAINT ai_recommendation_runs_episode_id_run_no_key UNIQUE (episode_id, run_no);


--
-- Name: ai_recommendation_runs ai_recommendation_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_recommendation_runs
    ADD CONSTRAINT ai_recommendation_runs_pkey PRIMARY KEY (id);


--
-- Name: case_clinical_snapshots case_clinical_snapshots_episode_id_snapshot_no_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.case_clinical_snapshots
    ADD CONSTRAINT case_clinical_snapshots_episode_id_snapshot_no_key UNIQUE (episode_id, snapshot_no);


--
-- Name: case_clinical_snapshots case_clinical_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.case_clinical_snapshots
    ADD CONSTRAINT case_clinical_snapshots_pkey PRIMARY KEY (id);


--
-- Name: clinical_records clinical_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clinical_records
    ADD CONSTRAINT clinical_records_pkey PRIMARY KEY (id);


--
-- Name: culture_results culture_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.culture_results
    ADD CONSTRAINT culture_results_pkey PRIMARY KEY (id);


--
-- Name: doctor_recommendation_reviews doctor_recommendation_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_recommendation_reviews
    ADD CONSTRAINT doctor_recommendation_reviews_pkey PRIMARY KEY (id);


--
-- Name: image_results image_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_results
    ADD CONSTRAINT image_results_pkey PRIMARY KEY (id);


--
-- Name: lab_results lab_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lab_results
    ADD CONSTRAINT lab_results_pkey PRIMARY KEY (id);


--
-- Name: medical_histories medical_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_histories
    ADD CONSTRAINT medical_histories_pkey PRIMARY KEY (episode_id);


--
-- Name: patients patients_patient_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_patient_code_key UNIQUE (patient_code);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: pending_lab_tasks pending_lab_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_lab_tasks
    ADD CONSTRAINT pending_lab_tasks_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: pji_episodes pji_episodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pji_episodes
    ADD CONSTRAINT pji_episodes_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sensitivity_results sensitivity_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sensitivity_results
    ADD CONSTRAINT sensitivity_results_pkey PRIMARY KEY (id);


--
-- Name: surgeries surgeries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surgeries
    ADD CONSTRAINT surgeries_pkey PRIMARY KEY (id);


--
-- Name: treatment_plan_versions treatment_plan_versions_episode_id_version_no_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_plan_versions
    ADD CONSTRAINT treatment_plan_versions_episode_id_version_no_key UNIQUE (episode_id, version_no);


--
-- Name: treatment_plan_versions treatment_plan_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_plan_versions
    ADD CONSTRAINT treatment_plan_versions_pkey PRIMARY KEY (id);


--
-- Name: pending_lab_tasks uq_pending_episode_field; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_lab_tasks
    ADD CONSTRAINT uq_pending_episode_field UNIQUE (episode_id, field, status);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_ai_chat_messages_session_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_chat_messages_session_created_at ON public.ai_chat_messages USING btree (session_id, created_at);


--
-- Name: idx_ai_chat_sessions_episode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_chat_sessions_episode_id ON public.ai_chat_sessions USING btree (episode_id);


--
-- Name: idx_ai_chat_sessions_run_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_chat_sessions_run_id ON public.ai_chat_sessions USING btree (run_id);


--
-- Name: idx_ai_citations_run_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_citations_run_id ON public.ai_rag_citations USING btree (run_id);


--
-- Name: idx_ai_items_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_items_category ON public.ai_recommendation_items USING btree (category);


--
-- Name: idx_ai_items_json_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_items_json_gin ON public.ai_recommendation_items USING gin (item_json);


--
-- Name: idx_ai_items_run_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_items_run_id ON public.ai_recommendation_items USING btree (run_id);


--
-- Name: idx_ai_runs_assessment_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_runs_assessment_gin ON public.ai_recommendation_runs USING gin (assessment_json);


--
-- Name: idx_ai_runs_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_runs_created_at ON public.ai_recommendation_runs USING btree (created_at DESC);


--
-- Name: idx_ai_runs_episode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_runs_episode_id ON public.ai_recommendation_runs USING btree (episode_id);


--
-- Name: idx_ai_runs_snapshot_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_runs_snapshot_id ON public.ai_recommendation_runs USING btree (snapshot_id);


--
-- Name: idx_clinical_records_episode_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clinical_records_episode_time ON public.clinical_records USING btree (episode_id, recorded_at DESC);


--
-- Name: idx_culture_results_episode_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_culture_results_episode_created_at ON public.culture_results USING btree (episode_id, created_at DESC);


--
-- Name: idx_episodes_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_episodes_patient_id ON public.pji_episodes USING btree (patient_id);


--
-- Name: idx_episodes_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_episodes_status ON public.pji_episodes USING btree (status);


--
-- Name: idx_image_results_episode_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_image_results_episode_created_at ON public.image_results USING btree (episode_id, created_at DESC);


--
-- Name: idx_lab_results_episode_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lab_results_episode_created_at ON public.lab_results USING btree (episode_id, created_at DESC);


--
-- Name: idx_patients_identity_card; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_patients_identity_card ON public.patients USING btree (identity_card);


--
-- Name: idx_plan_versions_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_plan_versions_current ON public.treatment_plan_versions USING btree (episode_id, is_current);


--
-- Name: idx_plan_versions_episode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_plan_versions_episode_id ON public.treatment_plan_versions USING btree (episode_id);


--
-- Name: idx_reviews_episode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_episode_id ON public.doctor_recommendation_reviews USING btree (episode_id);


--
-- Name: idx_reviews_run_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_run_id ON public.doctor_recommendation_reviews USING btree (run_id);


--
-- Name: idx_reviews_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_status ON public.doctor_recommendation_reviews USING btree (review_status);


--
-- Name: idx_sensitivity_results_culture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sensitivity_results_culture_id ON public.sensitivity_results USING btree (culture_id);


--
-- Name: idx_snapshots_episode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_snapshots_episode_id ON public.case_clinical_snapshots USING btree (episode_id);


--
-- Name: uq_treatment_plan_current_per_episode; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_treatment_plan_current_per_episode ON public.treatment_plan_versions USING btree (episode_id) WHERE (is_current = true);


--
-- Name: ai_chat_messages ai_chat_messages_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_messages
    ADD CONSTRAINT ai_chat_messages_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.ai_chat_sessions(id) ON DELETE CASCADE;


--
-- Name: ai_chat_sessions ai_chat_sessions_current_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_sessions
    ADD CONSTRAINT ai_chat_sessions_current_item_id_fkey FOREIGN KEY (current_item_id) REFERENCES public.ai_recommendation_items(id);


--
-- Name: ai_chat_sessions ai_chat_sessions_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_sessions
    ADD CONSTRAINT ai_chat_sessions_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id);


--
-- Name: ai_chat_sessions ai_chat_sessions_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_chat_sessions
    ADD CONSTRAINT ai_chat_sessions_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.ai_recommendation_runs(id);


--
-- Name: ai_rag_citations ai_rag_citations_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_rag_citations
    ADD CONSTRAINT ai_rag_citations_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.ai_recommendation_items(id) ON DELETE CASCADE;


--
-- Name: ai_rag_citations ai_rag_citations_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_rag_citations
    ADD CONSTRAINT ai_rag_citations_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.ai_recommendation_runs(id) ON DELETE CASCADE;


--
-- Name: ai_recommendation_items ai_recommendation_items_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_recommendation_items
    ADD CONSTRAINT ai_recommendation_items_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.ai_recommendation_runs(id) ON DELETE CASCADE;


--
-- Name: ai_recommendation_runs ai_recommendation_runs_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_recommendation_runs
    ADD CONSTRAINT ai_recommendation_runs_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: ai_recommendation_runs ai_recommendation_runs_snapshot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_recommendation_runs
    ADD CONSTRAINT ai_recommendation_runs_snapshot_id_fkey FOREIGN KEY (snapshot_id) REFERENCES public.case_clinical_snapshots(id) ON DELETE CASCADE;


--
-- Name: case_clinical_snapshots case_clinical_snapshots_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.case_clinical_snapshots
    ADD CONSTRAINT case_clinical_snapshots_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: clinical_records clinical_records_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clinical_records
    ADD CONSTRAINT clinical_records_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: culture_results culture_results_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.culture_results
    ADD CONSTRAINT culture_results_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: doctor_recommendation_reviews doctor_recommendation_reviews_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_recommendation_reviews
    ADD CONSTRAINT doctor_recommendation_reviews_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: doctor_recommendation_reviews doctor_recommendation_reviews_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_recommendation_reviews
    ADD CONSTRAINT doctor_recommendation_reviews_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.ai_recommendation_runs(id) ON DELETE CASCADE;


--
-- Name: pending_lab_tasks fkjmr2xh4reh2wmnr7pcxh6c7qd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_lab_tasks
    ADD CONSTRAINT fkjmr2xh4reh2wmnr7pcxh6c7qd FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: pending_lab_tasks fkpg8v9t854cmenkii5pckcxq64; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_lab_tasks
    ADD CONSTRAINT fkpg8v9t854cmenkii5pckcxq64 FOREIGN KEY (fulfilled_lab_result_id) REFERENCES public.lab_results(id);


--
-- Name: pending_lab_tasks fkspvdm09rf3k4q78t105b4tc7s; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_lab_tasks
    ADD CONSTRAINT fkspvdm09rf3k4q78t105b4tc7s FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id);


--
-- Name: image_results image_results_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_results
    ADD CONSTRAINT image_results_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: image_results image_results_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_results
    ADD CONSTRAINT image_results_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: image_results image_results_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_results
    ADD CONSTRAINT image_results_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: lab_results lab_results_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lab_results
    ADD CONSTRAINT lab_results_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: medical_histories medical_histories_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_histories
    ADD CONSTRAINT medical_histories_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: pji_episodes pji_episodes_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pji_episodes
    ADD CONSTRAINT pji_episodes_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: sensitivity_results sensitivity_results_culture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sensitivity_results
    ADD CONSTRAINT sensitivity_results_culture_id_fkey FOREIGN KEY (culture_id) REFERENCES public.culture_results(id) ON DELETE CASCADE;


--
-- Name: surgeries surgeries_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surgeries
    ADD CONSTRAINT surgeries_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: treatment_plan_versions treatment_plan_versions_confirmed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_plan_versions
    ADD CONSTRAINT treatment_plan_versions_confirmed_by_fkey FOREIGN KEY (confirmed_by) REFERENCES public.users(id);


--
-- Name: treatment_plan_versions treatment_plan_versions_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_plan_versions
    ADD CONSTRAINT treatment_plan_versions_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.pji_episodes(id) ON DELETE CASCADE;


--
-- Name: treatment_plan_versions treatment_plan_versions_source_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_plan_versions
    ADD CONSTRAINT treatment_plan_versions_source_review_id_fkey FOREIGN KEY (source_review_id) REFERENCES public.doctor_recommendation_reviews(id) ON DELETE SET NULL;


--
-- Name: treatment_plan_versions treatment_plan_versions_source_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_plan_versions
    ADD CONSTRAINT treatment_plan_versions_source_run_id_fkey FOREIGN KEY (source_run_id) REFERENCES public.ai_recommendation_runs(id) ON DELETE SET NULL;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict sFFT4zuTQaH2jZygNTYftj7qiNLcRK0CGoixckgj3NbHQxJBgc6QYafSVo6sh9C

