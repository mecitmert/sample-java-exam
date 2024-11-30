# Temel imaj olarak OpenJDK 17 kullanıyoruz
FROM openjdk:17-jdk-slim

# Çalışma dizinini ayarlıyoruz
WORKDIR /app

# Proje dosyalarını Docker imajına kopyalıyoruz
COPY . /app

# Maven'i kuruyoruz
RUN apt-get update && apt-get install -y maven

# Maven komutuyla projeyi derliyoruz
RUN mvn clean install

# Uygulamanın çalışması için komutu belirliyoruz
CMD ["java", "-jar", "target/sample-java-app-1.0-SNAPSHOT.jar"]
