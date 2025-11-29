import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: SafeArea(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Images/second-removebg-preview.png', width: 300,height:300),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
          child: Text('Get exclusive discounts every day', style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
        ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
           child: Text('Save more with daily deals and limited-time offers designed especially for you.', style: TextStyle(color: const Color.fromARGB(255, 41, 40, 39), fontSize: 20,), textAlign: TextAlign.center),
         )
      ],
    )
    ),
    );
  }
}