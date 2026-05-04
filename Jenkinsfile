pipeline {
    agent any

    parameters {
        string(name: 'DOCKERHUB_REPO', defaultValue: 'hieupahmet', trim: true, description: 'Docker Hub repository namespace')
        string(name: 'RAG_REPO_URL', defaultValue: 'https://github.com/HieuPahm-R2/Medical_RAG_PJI_latest.git', trim: true, description: 'Git URL for the RAG service repository')
        string(name: 'DEPLOY_HOST', defaultValue: '', trim: true, description: 'Production VPS hostname or IP')
        string(name: 'DEPLOY_USER', defaultValue: 'root', trim: true, description: 'SSH user for deployment')
        string(name: 'DEPLOY_PATH', defaultValue: '/opt/pji-advisor', trim: true, description: 'Remote directory containing docker-compose.yml')
        booleanParam(name: 'RUN_SONAR', defaultValue: false, description: 'Run SonarQube analysis')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Deploy after pushing images')
    }

    environment {
        RAG_SERVICE_DIR = 'Rag_Agentic'
        DOCKER_BUILDKIT = '1'
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
                checkout scm
                script {
                    env.GIT_COMMIT_SHORT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    env.SAFE_BRANCH = (env.BRANCH_NAME ?: 'manual').replaceAll('[^A-Za-z0-9_.-]', '-')
                    env.IMAGE_TAG = "${env.SAFE_BRANCH}-${env.BUILD_NUMBER}"
                }
                sh '''
                    if [ ! -d "${RAG_SERVICE_DIR}/.git" ]; then
                      git clone --depth 1 "${RAG_REPO_URL}" "${RAG_SERVICE_DIR}"
                    fi
                '''
            }
        }

        stage('Validate Layout') {
            steps {
                sh '''
                    test -f backend/pom.xml
                    test -f backend/Dockerfile
                    test -f frontend/package.json
                    test -f frontend/Dockerfile
                    test -f docker-compose.yml
                    test -f Caddyfile
                    test -f "${RAG_SERVICE_DIR}/pyproject.toml"
                    test -f "${RAG_SERVICE_DIR}/Dockerfile"
                '''
            }
        }

        stage('Test') {
            parallel {
                stage('Backend') {
                    steps {
                        dir('backend') {
                            sh './mvnw -B test -Dspring.profiles.active=test'
                        }
                    }
                    post {
                        always {
                            junit testResults: 'backend/target/surefire-reports/*.xml', allowEmptyResults: true
                        }
                    }
                }

                stage('Frontend') {
                    steps {
                        dir('frontend') {
                            sh '''
                                npm ci
                                npm run build
                            '''
                        }
                    }
                }

                stage('RAG Service') {
                    steps {
                        dir("${env.RAG_SERVICE_DIR}") {
                            sh '''
                                python3 -m pip install --upgrade pip uv
                                uv sync --frozen --dev
                                uv run pytest --junitxml=test-results.xml -v
                            '''
                        }
                    }
                    post {
                        always {
                            junit testResults: "${env.RAG_SERVICE_DIR}/test-results.xml", allowEmptyResults: true
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
                    dir('backend') {
                        sh './mvnw -B sonar:sonar -Dsonar.projectKey=pji-backend -Dsonar.projectName="PJI Backend"'
                    }
                    dir('frontend') {
                        sh '''
                            npm ci
                            npx sonar-scanner \
                              -Dsonar.projectKey=pji-frontend \
                              -Dsonar.projectName="PJI Frontend" \
                              -Dsonar.sources=src
                        '''
                    }
                    dir("${env.RAG_SERVICE_DIR}") {
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
                        dir('backend') {
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
                        dir('frontend') {
                            sh """
                                docker build \
                                  -t ${params.DOCKERHUB_REPO}/pji-frontend:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-frontend:latest \
                                  .
                            """
                        }
                    }
                }

                stage('RAG Image') {
                    steps {
                        dir("${env.RAG_SERVICE_DIR}") {
                            sh """
                                docker build \
                                  -t ${params.DOCKERHUB_REPO}/pji-rag-service:${env.IMAGE_TAG} \
                                  -t ${params.DOCKERHUB_REPO}/pji-rag-service:latest \
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
                        docker logout
                    '''
                }
            }
        }

        stage('Approve Production Deploy') {
            when {
                allOf {
                    expression { return params.DEPLOY }
                    branch 'main'
                }
            }
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input message: "Deploy build ${env.IMAGE_TAG} to production?", ok: 'Deploy'
                }
            }
        }

        stage('Deploy to Production') {
            when {
                allOf {
                    expression { return params.DEPLOY }
                    branch 'main'
                }
            }
            steps {
                script {
                    if (!params.DEPLOY_HOST?.trim()) {
                        error('DEPLOY_HOST must be provided when DEPLOY=true')
                    }
                }
                sshagent(credentials: ['deploy-server-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no "${DEPLOY_USER}@${DEPLOY_HOST}" "mkdir -p '${DEPLOY_PATH}/docker'"
                        scp -o StrictHostKeyChecking=no docker-compose.yml Caddyfile "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/"
                        scp -o StrictHostKeyChecking=no -r docker/* "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/docker/"
                        ssh -o StrictHostKeyChecking=no "${DEPLOY_USER}@${DEPLOY_HOST}" "
                          cd '${DEPLOY_PATH}' && \
                          DOCKERHUB_REPO='${DOCKERHUB_REPO}' IMAGE_TAG='${IMAGE_TAG}' docker compose pull pji-backend pji-frontend pji-rag-service caddy && \
                          DOCKERHUB_REPO='${DOCKERHUB_REPO}' IMAGE_TAG='${IMAGE_TAG}' docker compose up -d --remove-orphans caddy pji-backend pji-frontend pji-rag-service
                        "
                    '''
                }
            }
        }

        stage('Smoke Test') {
            when {
                allOf {
                    expression { return params.DEPLOY }
                    branch 'main'
                }
            }
            steps {
                sshagent(credentials: ['deploy-server-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no "${DEPLOY_USER}@${DEPLOY_HOST}" '
                          set -eu
                          for container in pji-backend pji-frontend pji-rag-service pji-caddy; do
                            tries=0
                            while [ "$tries" -lt 30 ]; do
                              status="$(docker inspect --format="{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}" "$container" 2>/dev/null || true)"
                              if [ "$status" = "healthy" ] || [ "$status" = "running" ]; then
                                break
                              fi
                              tries=$((tries + 1))
                              sleep 5
                            done
                            status="$(docker inspect --format="{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}" "$container" 2>/dev/null || true)"
                            if [ "$status" != "healthy" ] && [ "$status" != "running" ]; then
                              echo "Container $container is not healthy: $status"
                              exit 1
                            fi
                          done
                          curl -fsS http://localhost >/dev/null
                        '
                    '''
                }
            }
        }
    }

    post {
        always {
            sh '''
                docker image rm "${DOCKERHUB_REPO}/pji-backend:${IMAGE_TAG}" 2>/dev/null || true
                docker image rm "${DOCKERHUB_REPO}/pji-frontend:${IMAGE_TAG}" 2>/dev/null || true
                docker image rm "${DOCKERHUB_REPO}/pji-rag-service:${IMAGE_TAG}" 2>/dev/null || true
            '''
            cleanWs()
        }
    }
}
