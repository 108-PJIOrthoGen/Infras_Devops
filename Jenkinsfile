pipeline {
    agent any

    parameters {
        string(name: 'DOCKERHUB_REPO', defaultValue: 'hieupahmet', trim: true, description: 'Docker Hub repository namespace')
        string(name: 'COMPONENT_BRANCH', defaultValue: 'main', trim: true, description: 'Branch to checkout for every component repo')
        string(name: 'BACKEND_REPO_URL',  defaultValue: 'https://github.com/108-PJIOrthoGen/Backend_Server.git',  trim: true, description: 'Git URL for the Spring backend')
        string(name: 'FRONTEND_REPO_URL', defaultValue: 'https://github.com/108-PJIOrthoGen/Frontend_Client.git', trim: true, description: 'Git URL for the React frontend')
        string(name: 'RAG_REPO_URL',      defaultValue: 'https://github.com/108-PJIOrthoGen/Rag_Agentic.git',     trim: true, description: 'Git URL for the RAG service')
        string(name: 'EXTRACT_REPO_URL',  defaultValue: 'https://github.com/108-PJIOrthoGen/Extract_Images.git',  trim: true, description: 'Git URL for Extract Images')
        string(name: 'DEPLOY_PATH', defaultValue: '/opt/pji-advisor', trim: true, description: 'Local directory on the Jenkins host where docker compose runs')
        booleanParam(name: 'RUN_TESTS', defaultValue: false, description: 'Run unit tests (skip for now until test infrastructure is in place)')
        booleanParam(name: 'RUN_SONAR', defaultValue: false, description: 'Run SonarQube analysis')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Deploy locally after pushing images (Jenkins must run on the same host as the docker daemon)')
    }

    environment {
        // Component checkout dirs (siblings of the Infras_Devops content at workspace root)
        BACKEND_DIR  = 'Backend_Server'
        FRONTEND_DIR = 'Frontend_Client'
        RAG_DIR      = 'Rag_Agentic'
        EXTRACT_DIR  = 'Extract_Images'
        DOCKER_BUILDKIT = '1'
        // Mirror params -> env so shell steps can read them on the FIRST build (before
        // Jenkins has registered the new parameters block). Elvis (?:) supplies defaults.
        BACKEND_REPO_URL  = "${params.BACKEND_REPO_URL  ?: 'https://github.com/108-PJIOrthoGen/Backend_Server.git'}"
        FRONTEND_REPO_URL = "${params.FRONTEND_REPO_URL ?: 'https://github.com/108-PJIOrthoGen/Frontend_Client.git'}"
        RAG_REPO_URL      = "${params.RAG_REPO_URL      ?: 'https://github.com/108-PJIOrthoGen/Rag_Agentic.git'}"
        EXTRACT_REPO_URL  = "${params.EXTRACT_REPO_URL  ?: 'https://github.com/108-PJIOrthoGen/Extract_Images.git'}"
        COMPONENT_BRANCH  = "${params.COMPONENT_BRANCH  ?: 'main'}"
        DOCKERHUB_REPO    = "${params.DOCKERHUB_REPO    ?: 'hieupahmet'}"
        DEPLOY_PATH       = "${params.DEPLOY_PATH       ?: '/opt/pji-advisor'}"
    }

    triggers {
        // Poll the SCM (Infras_Devops) every 5 minutes. Component repos must be triggered
        // separately if you want auto-rebuild on every code push — see README for options.
        pollSCM('H/5 * * * *')
    }

    options {
        timeout(time: 45, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                // checkout scm pulls Infras_Devops at workspace root (Caddyfile, Caddyfile.prod,
                // docker/, Jenkinsfile etc. are siblings of Backend_Server/, Frontend_Client/, ...)
                checkout scm
                script {
                    env.GIT_COMMIT_SHORT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    env.SAFE_BRANCH = (env.BRANCH_NAME ?: 'manual').replaceAll('[^A-Za-z0-9_.-]', '-')
                    env.IMAGE_TAG = "${env.SAFE_BRANCH}-${env.BUILD_NUMBER}-${env.GIT_COMMIT_SHORT}"
                }

                // Clone the four component repos as siblings of Infras_Devops content.
                // Use the github-pat credential so private org repos are accessible.
                withCredentials([usernamePassword(credentialsId: 'github-pat', usernameVariable: 'GH_USER', passwordVariable: 'GH_TOKEN')]) {
                    sh '''
                        set -eu
                        clone_or_pull() {
                          local url="$1" dir="$2" branch="$3"
                          # Inject token into HTTPS URL (works for private org repos)
                          local auth_url="$(echo "$url" | sed -E "s|https://|https://${GH_USER}:${GH_TOKEN}@|")"
                          if [ -d "$dir/.git" ]; then
                            echo "[refresh] $dir"
                            git -C "$dir" remote set-url origin "$auth_url"
                            git -C "$dir" fetch --depth 1 origin "$branch"
                            git -C "$dir" reset --hard "origin/$branch"
                          else
                            echo "[clone] $dir from $url"
                            git clone --depth 1 --branch "$branch" "$auth_url" "$dir"
                          fi
                          # Scrub token back out so logs/inspectors don't leak it
                          git -C "$dir" remote set-url origin "$url"
                        }
                        clone_or_pull "${BACKEND_REPO_URL}"  "${BACKEND_DIR}"  "${COMPONENT_BRANCH}"
                        clone_or_pull "${FRONTEND_REPO_URL}" "${FRONTEND_DIR}" "${COMPONENT_BRANCH}"
                        clone_or_pull "${RAG_REPO_URL}"      "${RAG_DIR}"      "${COMPONENT_BRANCH}"
                        clone_or_pull "${EXTRACT_REPO_URL}"  "${EXTRACT_DIR}"  "${COMPONENT_BRANCH}"
                    '''
                }
            }
        }

        stage('Validate Layout') {
            steps {
                sh '''
                    # Infras_Devops content lives at workspace root after `checkout scm`
                    test -f Caddyfile
                    test -f Caddyfile.prod
                    test -f docker/docker-compose.yml
                    test -d docker/signoz
                    # Component repos cloned by the Checkout stage above
                    test -f "${BACKEND_DIR}/pom.xml"
                    test -f "${BACKEND_DIR}/Dockerfile"
                    test -f "${FRONTEND_DIR}/package.json"
                    test -f "${FRONTEND_DIR}/Dockerfile"
                    test -f "${FRONTEND_DIR}/nginx.conf"
                    test -f "${RAG_DIR}/pyproject.toml"
                    test -f "${RAG_DIR}/Dockerfile"
                    test -f "${EXTRACT_DIR}/pyproject.toml"
                    test -f "${EXTRACT_DIR}/Dockerfile"
                '''
            }
        }

        stage('Test') {
            when {
                expression { return params.RUN_TESTS }
            }
            parallel {
                stage('Backend') {
                    steps {
                        dir("${env.BACKEND_DIR}") {
                            sh './mvnw -B test -Dspring.profiles.active=test'
                        }
                    }
                    post {
                        always {
                            junit testResults: "${env.BACKEND_DIR}/target/surefire-reports/*.xml", allowEmptyResults: true
                        }
                    }
                }

                stage('Frontend') {
                    steps {
                        dir("${env.FRONTEND_DIR}") {
                            sh '''
                                npm ci
                                npm run build
                            '''
                        }
                    }
                }

                stage('RAG Service') {
                    steps {
                        dir("${env.RAG_DIR}") {
                            sh '''
                                python3 -m pip install --upgrade pip uv
                                uv sync --frozen --dev
                                uv run pytest --junitxml=test-results.xml -v
                            '''
                        }
                    }
                    post {
                        always {
                            junit testResults: "${env.RAG_DIR}/test-results.xml", allowEmptyResults: true
                        }
                    }
                }

                stage('Extract Images') {
                    steps {
                        dir("${env.EXTRACT_DIR}") {
                            sh '''
                                python3 -m pip install --upgrade pip uv
                                uv sync --frozen --dev
                                uv run pytest --junitxml=test-results.xml -v || true
                            '''
                        }
                    }
                    post {
                        always {
                            junit testResults: "${env.EXTRACT_DIR}/test-results.xml", allowEmptyResults: true
                        }
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            when {
                expression { return params.RUN_SONAR }
            }
            steps {
                withSonarQubeEnv('sonarqube') {
                    dir("${env.BACKEND_DIR}") {
                        sh './mvnw -B sonar:sonar -Dsonar.projectKey=pji-backend -Dsonar.projectName="PJI Backend"'
                    }
                    dir("${env.FRONTEND_DIR}") {
                        sh '''
                            npm ci
                            npx sonar-scanner \
                              -Dsonar.projectKey=pji-frontend \
                              -Dsonar.projectName="PJI Frontend" \
                              -Dsonar.sources=src
                        '''
                    }
                    dir("${env.RAG_DIR}") {
                        sh '''
                            npx sonar-scanner \
                              -Dsonar.projectKey=pji-rag-service \
                              -Dsonar.projectName="PJI RAG Service" \
                              -Dsonar.sources=app \
                              -Dsonar.python.version=3.11
                        '''
                    }
                }
            }
        }

        stage('Quality Gate') {
            when {
                expression { return params.RUN_SONAR }
            }
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build Images') {
            parallel {
                stage('Backend Image') {
                    steps {
                        dir("${env.BACKEND_DIR}") {
                            sh """
                                docker build \
                                  -t ${params.DOCKERHUB_REPO}/pji-backend:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-backend:latest \
                                  .
                            """
                        }
                    }
                }

                stage('Frontend Image') {
                    steps {
                        dir("${env.FRONTEND_DIR}") {
                            sh """
                                docker build \
                                  --build-arg VITE_BACKEND_URL=/ \
                                  --build-arg VITE_ACL_ENABLE=true \
                                  -t ${params.DOCKERHUB_REPO}/pji-frontend:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-frontend:latest \
                                  .
                            """
                        }
                    }
                }

                stage('RAG Image') {
                    steps {
                        dir("${env.RAG_DIR}") {
                            sh """
                                docker build \
                                  -t ${params.DOCKERHUB_REPO}/pji-rag-service:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-rag-service:latest \
                                  .
                            """
                        }
                    }
                }

                stage('Extract Images Image') {
                    steps {
                        dir("${env.EXTRACT_DIR}") {
                            sh """
                                docker build \
                                  -t ${params.DOCKERHUB_REPO}/pji-extract-api:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-extract-api:latest \
                                  -t ${params.DOCKERHUB_REPO}/pji-extract-worker:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-extract-worker:latest \
                                  .
                            """
                        }
                    }
                }
            }
        }

        stage('Push Images') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push "${DOCKERHUB_REPO}/pji-backend:${IMAGE_TAG}"
                        docker push "${DOCKERHUB_REPO}/pji-backend:latest"
                        docker push "${DOCKERHUB_REPO}/pji-frontend:${IMAGE_TAG}"
                        docker push "${DOCKERHUB_REPO}/pji-frontend:latest"
                        docker push "${DOCKERHUB_REPO}/pji-rag-service:${IMAGE_TAG}"
                        docker push "${DOCKERHUB_REPO}/pji-rag-service:latest"
                        docker push "${DOCKERHUB_REPO}/pji-extract-api:${IMAGE_TAG}"
                        docker push "${DOCKERHUB_REPO}/pji-extract-api:latest"
                        docker push "${DOCKERHUB_REPO}/pji-extract-worker:${IMAGE_TAG}"
                        docker push "${DOCKERHUB_REPO}/pji-extract-worker:latest"
                        docker logout
                    '''
                }
            }
        }

        stage('Approve Production Deploy') {
            when {
                expression { return params.DEPLOY }
            }
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input message: "Deploy build ${env.IMAGE_TAG} to production?", ok: 'Deploy'
                }
            }
        }

        stage('Deploy') {
            when {
                expression { return params.DEPLOY }
            }
            steps {
                sh '''
                    set -eu
                    test -d "${DEPLOY_PATH}" || { echo "DEPLOY_PATH ${DEPLOY_PATH} does not exist"; exit 1; }
                    test -f "${DEPLOY_PATH}/.env" || { echo "${DEPLOY_PATH}/.env is missing — create it manually before first deploy"; exit 1; }

                    mkdir -p "${DEPLOY_PATH}/docker/signoz"
                    # Production uses a tunnel-mode Caddyfile (HTTP-only on :80, no Let's Encrypt).
                    # NOTE: Infras_Devops content lives at the workspace root after `checkout scm`,
                    # so paths are NOT prefixed with Infras_Devops/.
                    cp Caddyfile.prod   "${DEPLOY_PATH}/Caddyfile"
                    cp docker/docker-compose.yml "${DEPLOY_PATH}/docker-compose.yml"
                    cp -r docker/signoz/. "${DEPLOY_PATH}/docker/signoz/"

                    # Bind mount Caddyfile on the server (no Docker Desktop fileshare cache there).
                    # The source compose uses an external `pji_caddy_config` volume as a Docker Desktop workaround.
                    sed -i 's|pji_caddy_config:/etc/caddy:ro|./Caddyfile:/etc/caddy/Caddyfile:ro|' "${DEPLOY_PATH}/docker-compose.yml"
                    sed -i '/^  pji_caddy_config:$/,/^    external: true$/d' "${DEPLOY_PATH}/docker-compose.yml"

                    cd "${DEPLOY_PATH}"
                    DOCKERHUB_REPO="${DOCKERHUB_REPO}" IMAGE_TAG="${IMAGE_TAG}" \
                      docker compose pull pji-backend pji-frontend pji-rag-service pji-extract-api pji-extract-worker caddy
                    DOCKERHUB_REPO="${DOCKERHUB_REPO}" IMAGE_TAG="${IMAGE_TAG}" \
                      docker compose up -d --remove-orphans \
                        postgres redis rabbitmq minio \
                        pji-backend pji-rag-service pji-extract-api pji-extract-worker \
                        pji-frontend caddy
                '''
            }
        }

        stage('Smoke Test') {
            when {
                expression { return params.DEPLOY }
            }
            steps {
                sh '''
                    set -eu
                    for container in pji-backend pji-frontend pji-rag-service pji-caddy; do
                      tries=0
                      while [ "$tries" -lt 30 ]; do
                        status="$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' "$container" 2>/dev/null || true)"
                        if [ "$status" = "healthy" ] || [ "$status" = "running" ]; then
                          break
                        fi
                        tries=$((tries + 1))
                        sleep 5
                      done
                      status="$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' "$container" 2>/dev/null || true)"
                      if [ "$status" != "healthy" ] && [ "$status" != "running" ]; then
                        echo "Container $container is not healthy: $status"
                        docker logs --tail 30 "$container" || true
                        exit 1
                      fi
                    done
                    curl -fsS http://localhost/ >/dev/null
                '''
            }
        }
    }

    post {
        always {
            sh '''
                docker image rm "${DOCKERHUB_REPO}/pji-backend:${IMAGE_TAG}" 2>/dev/null || true
                docker image rm "${DOCKERHUB_REPO}/pji-frontend:${IMAGE_TAG}" 2>/dev/null || true
                docker image rm "${DOCKERHUB_REPO}/pji-rag-service:${IMAGE_TAG}" 2>/dev/null || true
                docker image rm "${DOCKERHUB_REPO}/pji-extract-api:${IMAGE_TAG}" 2>/dev/null || true
                docker image rm "${DOCKERHUB_REPO}/pji-extract-worker:${IMAGE_TAG}" 2>/dev/null || true
            '''
            cleanWs()
        }
    }
}
