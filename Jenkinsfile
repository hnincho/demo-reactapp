pipeline {
    agent any
    
    environment {
        compose_service_name = "demo-reactapp"
        workspace = "/home/jenkins/project/demo-reactapp"
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

        stage('Docker Compose Build') {
            steps {
                ws("${workspace}") {
                    sh """
                        docker compose down
                        docker compose build --no-cache ${compose_service_name}
                    """
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                ws("${workspace}") {
                    sh "docker compose up -d ${compose_service_name}"
                }
            }
        }
    }

    post {
        always {
            ws("${workspace}") {
                sh "docker compose ps"
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
