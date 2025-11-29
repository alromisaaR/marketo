import 'package:flutter/material.dart';
import 'package:marketo/Features/Products/Persentation/home_screen.dart';
import 'package:marketo/Features/Welcom/login_screen.dart';
import 'package:marketo/Features/Welcom/signup_screen.dart';

class WelcomScreen extends StatelessWidget {

  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  WelcomScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: SafeArea(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/Images/welcome.jpg', width: 300,height:300),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
          child: Text('Welcome to MARKETOO', style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
        ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
           child: Text('Explore, Discover, and Bring Home the Best Products, All in One Place.', style: TextStyle(color: const Color.fromARGB(255, 41, 40, 39), fontSize: 20,), textAlign: TextAlign.center),
         ),
         
               InkWell(
          onTap: () => {
         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(toggleTheme: toggleTheme,
             toggleLanguage: toggleLanguage)))
          },
          child: (Container
        (
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 250,
          height: 50,
          child: (Text('Sign In', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),)),),


 InkWell(
           onTap: () => {
         Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(toggleTheme: toggleTheme,
             toggleLanguage: toggleLanguage)))
          },
          child: (Container
        (
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 250,
           height: 50,
          child: (Text('Sign Up', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),)),),

  Padding(
    padding: const EdgeInsets.all(20),
    child: InkWell(
       onTap: () => {
         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(toggleTheme: toggleTheme,
             toggleLanguage: toggleLanguage)))
          },
      child: 
            Text('Skip', style: TextStyle(fontSize: 20 ),),
    ),
  ),
      ],
    )
    ),
    );
  }
}