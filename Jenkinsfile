pipeline{
    agent{
        label "node"
    }
    environment{
        DOCKER_IMAGE = "scam-bank-core-service"
        CONTAINER_NAME = "core-service"
        SERVER_IP = "45.130.146.135"
        DEPLOY_PATH = "/opt/scam-bank-core-service"
    }
    
    stages {
        stage('Checkout') {
            steps{
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
                    sh 'docker tag $DOCKER_IMAGE microseversk/$DOCKER_IMAGE:latest'
                    sh 'docker push microseversk/$DOCKER_IMAGE:latest'
                }
            }
        }
    }
}