import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica6/screens/add_product.dart';
import 'package:practica6/screens/products_screen.dart';
import 'package:practica6/screens/splashscreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value){
   runApp(MyApp());
  });
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home' : (BuildContext context) => ListProducts(),
        '/agregar' : (BuildContext context) => AddProductScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
