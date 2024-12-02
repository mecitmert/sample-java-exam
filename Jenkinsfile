pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')  // Docker Hub kimlik bilgileri
        TARGET_SERVER = "192.168.1.100"  // Konteyner çalıştırılacak ikinci Linux sunucusunun IP'si
        SSH_CREDENTIALS = credentials('target-server-ssh')  // SSH bağlantısı için kimlik bilgileri
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
                sh 'docker build -t my-java-app .'  // Dockerfile ile konteyner imajını oluştur
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Docker Hub'a login işlemi
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh """
                            echo $DOCKER_HUB_PASSWORD | docker login --username $DOCKER_HUB_USERNAME --password-stdin
                        """
                    }
                }
                sh 'docker tag my-java-app your-dockerhub-username/my-java-app:latest'  // Docker Hub için imajı etiketle
                sh 'docker push your-dockerhub-username/my-java-app:latest'  // Docker Hub’a push et
            }
        }

        stage('Deploy to Target Server') {
            steps {
                script {
                    // Hedef sunucuda Docker imajını çalıştır
                    sshagent(['target-server-ssh']) {
                        sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@$TARGET_SERVER << EOF
                            docker pull your-dockerhub-username/my-java-app:latest
                            docker stop my-java-app || true
                            docker rm my-java-app || true
                            docker run -d --name my-java-app -p 8080:8080 your-dockerhub-username/my-java-app:latest
                        EOF
                        """
                    }
                }
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
