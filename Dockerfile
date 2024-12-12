# Temel imaj olarak OpenJDK 17 kullanıyoruz
FROM openjdk:17-jdk-slim

# Çalışma dizinini ayarlıyoruz
WORKDIR /app

# Gerekli bağımlılıkları yükleyelim (JavaFX için uygun kütüphaneler dahil)
RUN apt-get update && apt-get install -y \
    libopenjfx-java \
    libgl1-mesa-glx \
    libxext6 \
    libxrender1 \
    libxrandr2 && \
    apt-get clean

# Maven için bağımlılıkları yükleme
COPY pom.xml /app
RUN apt-get update && apt-get install -y maven && \
    mvn dependency:resolve

# Proje dosyalarını kopyalayalım
COPY . /app

# Maven komutuyla projeyi derliyoruz
RUN mvn clean install

ENV GDK_SYNCHRONIZE=1
CMD ["java", "--module-path", "/home/admin/Downloads/openjfx-17.0.13_linux-x64_bin-sdk/javafx-sdk-17.0.13/lib", "--add-modules", "javafx.controls,javafx.web", "-jar", "target/sample-java-app-1.0-SNAPSHOT.jar"]
