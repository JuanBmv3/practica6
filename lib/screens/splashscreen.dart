import 'package:flutter/material.dart';
import 'package:practica6/screens/products_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage('assets/back.jpg')
         )
       ),
        child: SplashScreenView(
          navigateRoute: ListProducts(),
          duration: 8000,
          imageSrc: 'assets/logo.png',
          imageSize: 200,
          text: 'Products APP',
          textType: TextType.TyperAnimatedText,
          textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
    
  }
}