pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "scam-bank-core-service"
        CONTAINER_NAME = "core-service"
        PROJECT_VERSION = "${BUILD_NUMBER}"
        USERNAME = "microseversk"
        PORT = 3000
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ScamBank/scam-bank-core-service.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Registry') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker tag $DOCKER_IMAGE $USERNAME/$DOCKER_IMAGE:latest'
                    sh 'docker push $USERNAME/$DOCKER_IMAGE:latest'
                }
            }
        }
    }
    post {
        success {
            script {
                sh '''
                echo "Cleaning up old images and containers..."
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                docker images | grep "$DOCKER_IMAGE" | awk '{print $3}' | xargs docker rmi -f || true
                docker image prune -f

                echo "Starting new container..."
                    docker run -d --name $CONTAINER_NAME -p $PORT:3000 $USERNAME/$DOCKER_IMAGE:latest
                '''
            }
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}