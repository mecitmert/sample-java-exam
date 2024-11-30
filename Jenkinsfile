pipeline {
    agent any  // Herhangi bir ajan (worker) kullanabiliriz

    environment {
        // Docker Hub kullanıcı adı ve şifresi (gizli olarak saklanabilir)
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
    }

    stages {
        stage('Checkout') {  // Git reposundan kodu almak için
            steps {
                // Git reposundan kodu çekme
                git 'https://github.com/mecitmert/sample-java-exam.git'
            }
        }

        stage('Build') {  // Build aşaması
            steps {
                script {
                    // Maven ile projeyi derlemek için
                    sh 'mvn clean install'  // Maven ile projeyi derleyin
                }
            }
        }

        stage('Test') {  // Test aşaması
            steps {
                script {
                    // Maven ile testleri çalıştırma
                    sh 'mvn test'  // Maven ile testleri çalıştırın
                }
            }
        }

        stage('Build Docker Image') {  // Docker imajını oluşturma
            steps {
                script {
                    // Docker imajını inşa etme
                    sh 'docker build -t my-java-app .'  // Dockerfile kullanarak imajı oluştur
                }
            }
        }

        stage('Push to Docker Hub') {  // Docker Hub'a push etme
            steps {
                script {
                    // Docker Hub’a login olma (credentials kullanarak)
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login --username $DOCKER_HUB_CREDENTIALS_USR --password-stdin"

                    // Docker imajını Docker Hub’a gönderme
                    sh 'docker tag my-java-app mydockerhubusername/my-java-app:latest'  // İmajı etiketle
                    sh 'docker push mydockerhubusername/my-java-app:latest'  // Docker Hub'a push et
                }
            }
        }

        stage('Deploy') {  // Dağıtım aşaması
            steps {
                script {
                    // Burada dağıtım komutları eklenebilir
                    echo 'Deploying the app to the server'  // Bu örnekte sadece bir mesaj yazdırıyoruz
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
