package DOANJAVA;

import java.sql.Connection;
import java.sql.DriverManager;

import javafx.application.Application;
import javafx.concurrent.Worker;
import javafx.scene.Scene;
import javafx.scene.web.WebEngine;
import javafx.scene.web.WebView;
import javafx.stage.Stage;
import netscape.javascript.JSObject;
import java.time.*;
import java.time.format.DateTimeFormatter;

public class main extends Application {
    //tao 1 cai ket noi database
    class connectDatabase {
        public Connection getConnection(){
            try{
                 String url = "jdbc:mysql://127.0.0.1:3306/conveniencestore";
                String user = "root"; 
                String password = "123456";

                System.out.println("connected successful");
                return DriverManager.getConnection(url, user, password); 
            }
            catch(Exception e){
                System.out.println(e.getMessage());
                return null; 
            }
        }
    }

     WebEngine webEngine; 
     Stage stage; 


     public class Bridge{
        public String getTime() {
            return LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
        }

     }
    
     @Override 
     public void start(Stage stage){
        this.stage = stage; 
        WebView webView = new WebView(); 
        webEngine = webView.getEngine(); 

        Bridge bridge = new Bridge(); 

        webEngine.getLoadWorker().stateProperty().addListener((obs, obstate, newstate) ->{
            if(newstate == Worker.State.SUCCEEDED){
                JSObject window = (JSObject) webEngine.executeScript("window"); 
                window.setMember("app", bridge);
            }
        });

        loadloginpage1();

        stage.setTitle("Project");
        stage.setScene( new Scene(webView , 1440, 1024));
        stage.show();
     }

     public void loadloginpage1(){
         var resource = getClass().getResource("login.html"); 
         webEngine.load(resource.toExternalForm()); 
     }

     public static void main (String[] args){
        launch(args);
     }
}
