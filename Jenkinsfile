pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "scam-bank-core-service"
        CONTAINER_NAME = "core-service"
        PROJECT_NAME = "${JOB_NAME.tokenize('/')[0]}"
        PROJECT_VERSION = "${BRANCH_NAME}+${BUILD_NUMBER}"
        USERNAME = 'microseversk'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ScamBank/scam-bank-core-service.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $PROJECT_NAME .'
            }
        }

        stage('Push to Registry') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker tag $DOCKER_IMAGE $USERNAME/$DOCKER_IMAGE:$PROJECT_VERSION'
                    sh 'docker push $USERNAME/$DOCKER_IMAGE:$PROJECT_VERSION'
                }
            }
        }
    }
    post {
        success: {
            echo 'Pipeline completed successfully!'
        },
        failure: {
            echo 'Pipeline failed!'
        }
    }
}