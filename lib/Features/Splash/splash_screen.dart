import 'package:flutter/material.dart';
import 'package:marketo/Features/Onboarding/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  const SplashScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
     Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen( toggleTheme: widget.toggleTheme,
        toggleLanguage: widget.toggleLanguage,)
      ));
    }
    );
    super.initState();
   
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        Expanded(child: Center(
          child: Image.asset('assets/Images/Black_Modern_MS_Logo-removebg-preview.png', height: 400, width: 400,),
        )
        ),
        const Text('Developed by Alromisaa reda', style: TextStyle(color: Colors.grey),)
      ],
    ),
  ),

    );
  }
}
