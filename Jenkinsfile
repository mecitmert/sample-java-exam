pipeline {
    agent any  // Herhangi bir ajan (worker) kullanabiliriz

    stages {  // Farklı aşamaları tanımlar
        stage('Build') {  // Build aşaması
            steps {
                script {
                    // Projeyi derlemek için gerekli komutlar
                    sh 'mvn clean install'  // Maven ile projeyi derleyin
                }
            }
        }
        stage('Test') {  // Test aşaması
            steps {
                script {
                    // Testleri çalıştırma komutları
                    sh 'mvn test'  // Maven ile testleri çalıştırın
                }
            }
        }
        stage('Deploy') {  // Dağıtım aşaması
            steps {
                script {
                    // Projenin dağıtımını yapmak için gerekli komutlar
                    echo 'Deploying to the server'  // Bu örnekte sadece bir mesaj yazdırıyoruz
                }
            }
        }
    }
}
