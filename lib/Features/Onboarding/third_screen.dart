import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: SafeArea(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Images/third-removebg-preview.png', width: 300,height:300),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
          child: Text('Shop anytime, anywhere with ease', style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
        ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
           child: Text('Experience a smooth, fast, and secure shopping journey, With just a few clicks', style: TextStyle(color: const Color.fromARGB(255, 41, 40, 39), fontSize: 20,), textAlign: TextAlign.center),
         )
      ],
    )
    ),
    );
  }
}