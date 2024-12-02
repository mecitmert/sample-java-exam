pipeline {
    agent any  // Herhangi bir ajanı kullan
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('merID')  // Docker Hub kimlik bilgileri (merID olarak ayarlandı)
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mecitmert/sample-java-exam.git'  // Git reposundan kod çek
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'  // Maven ile kaynak kodu derle
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mecitmert/sample_java_repo .'  // Dockerfile ile konteyner imajını oluştur
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login --username $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                sh 'docker push mecitmert/sample_java_repo:latest'  // Docker Hub’a push et
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
