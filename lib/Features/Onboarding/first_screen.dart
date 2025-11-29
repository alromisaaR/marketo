import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: SafeArea(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Images/first-removebg-preview.png', width: 300,height:300),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
          child: Text('Shop everything you need in one place', style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
        ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
           child: Text('Explore a world of carefully selected items that match your taste and needs.', style: TextStyle(color: const Color.fromARGB(255, 41, 40, 39), fontSize: 20,), textAlign: TextAlign.center),
         )
      ],
    )
    ),
    );
  }
}