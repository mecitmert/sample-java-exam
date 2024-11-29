package com.example;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.web.WebView;
import javafx.stage.Stage;

public class App extends Application {

    @Override
    public void start(Stage primaryStage) {
        // WebView nesnesi oluşturuyoruz
        WebView webView = new WebView();

        // WebView motorunu kullanarak bir web sayfası yüklüyoruz
        webView.getEngine().load("https://bolvadi.com"); // Bolvadi.com sitesini yükle

        // Scene'i oluşturuyoruz ve WebView bileşenini ekliyoruz
        // Pencere boyutlarını ekranın boyutlarına göre ayarlıyoruz
        double screenWidth = java.awt.Toolkit.getDefaultToolkit().getScreenSize().getWidth();
        double screenHeight = java.awt.Toolkit.getDefaultToolkit().getScreenSize().getHeight();
        Scene scene = new Scene(webView, screenWidth * 0.8, screenHeight * 0.8); // Pencere boyutlarını ekranın %80'i olarak ayarlıyoruz

        // Pencereyi başlatıyoruz
        primaryStage.setTitle("Web Browser");
        primaryStage.setScene(scene);
        primaryStage.show(); // Pencereyi göster
    }

    public static void main(String[] args) {
        launch(args); // JavaFX uygulamasını başlat
    }
}
