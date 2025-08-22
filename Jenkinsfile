pipeline {
    agent any

    environment {
        compose_service_name = "demo-reactapp"
        workspace = "/home/jenkins/project/demo-reactapp"
        DOCKER_COMPOSE_CMD = "sudo docker compose" // Use sudo if needed
    }

    stages {
        stage('Checkout Source') {
            steps {
                ws("${workspace}") {
                    git branch: 'main',
                        url: 'https://github.com/hnincho/demo-reactapp.git'
                }
            }
        }

        stage('Docker Compose Down & Build') {
            steps {
                ws("${workspace}") {
                    sh """
                        ${DOCKER_COMPOSE_CMD} down || true
                        ${DOCKER_COMPOSE_CMD} build --no-cache ${compose_service_name}
                    """
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                ws("${workspace}") {
                    sh "${DOCKER_COMPOSE_CMD} up -d ${compose_service_name}"
                }
            }
        }
    }

    post {
        always {
            ws("${workspace}") {
                sh "${DOCKER_COMPOSE_CMD} ps || true"
            }
        }
        failure {
            echo "❌ Build or Deployment failed. Please check logs."
        }
        success {
            echo "✅ React App deployed successfully with Docker Compose!"
        }
    }
}
