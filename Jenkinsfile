pipeline {
    agent any  // Herhangi bir ajanı kullan
    environment {
        // Docker Hub için kimlik bilgileri
        DOCKER_HUB_CREDENTIALS = credentials('docker-hob-token')  // Docker Hub kimlik bilgileri 'docker-hub-token' olarak ayarlandı
        // GitHub için kimlik bilgileri
        GITHUB_CREDENTIALS = credentials('github-token')  // GitHub kimlik bilgileri 'github-token' olarak ayarlandı
    }

    stages {
        stage('Checkout') {
            steps {
                // GitHub'dan projeyi çekmek için kimlik bilgileri kullanılır
                git credentialsId: 'github-token', url: 'https://github.com/mecitmert/sample-java-exam.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'  // Maven ile kaynak kodunu derle
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mecitmert/sample_java_repo .'  // Dockerfile ile konteyner imajını oluştur
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Docker Hub giriş işlemi
                sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login --username $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                // Docker Hub'a push et
                sh 'docker push mecitmert/sample_java_repo:latest'  // Docker Hub’a push et
            }
        }
    }

    post {
        success {
            echo 'Pipeline başarıyla tamamlandı!'
        }
        failure {
            echo 'Pipeline başarısız oldu!'
        }
    }
}
