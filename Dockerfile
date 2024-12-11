# Temel imaj olarak OpenJDK 17 kullanıyoruz
FROM openjdk:17-jdk-slim

# Çalışma dizinini ayarlıyoruz
WORKDIR /app

# Gerekli bağımlılıkları yükleyelim (JavaFX, grafik kütüphaneleri ve Maven)
RUN apt-get update && apt-get install -y \
    libopenjfx-java \
    libgl1-mesa-glx \
    libxext6 \
    libxrender1 \
    libxrandr2 \
    maven && \
    apt-get clean

# Proje dosyalarını Docker imajına kopyalıyoruz
COPY . /app

# Maven komutuyla projeyi derliyoruz
RUN mvn clean install

# JavaFX runtime ile uygulamayı başlatacak komutu belirliyoruz
CMD ["java", "--module-path", "/usr/share/openjfx/lib", "--add-modules", "javafx.controls,javafx.web", "-jar", "target/sample-java-app-1.0-SNAPSHOT.jar"]
