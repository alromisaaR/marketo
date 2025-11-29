import 'package:flutter/material.dart';
import 'package:marketo/Features/Onboarding/first_screen.dart';
import 'package:marketo/Features/Onboarding/second_screen.dart';
import 'package:marketo/Features/Onboarding/third_screen.dart';
import 'package:marketo/Features/Welcom/Welcom_screen.dart';

class OnboardingScreen extends StatefulWidget {


  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  OnboardingScreen({
    super.key,
    required this.toggleTheme,
    required this.toggleLanguage,
  });


  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int index=0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: SafeArea(child: 
   Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child:
      PageView(
        controller: _controller,
        onPageChanged: (int newIndex) {
        setState(() {
      index = newIndex;
    });
  },
        children: [
          FirstScreen(),
          SecondScreen(),
          ThirdScreen(),
        ],
      )
      ),
 
      Row(
        
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
      CustomIndicator(active: index ==0,),
      const SizedBox(width: 8),
      CustomIndicator(active: index ==1,),
      const SizedBox(width: 8),
      CustomIndicator(active: index ==2,),
      ],),

      Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        InkWell(
          onTap: (){

            if (index ==0){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomScreen(toggleTheme: widget.toggleTheme,
              toggleLanguage: widget.toggleLanguage,)));

            }else {
              _controller.animateToPage(index-1, duration: Duration(milliseconds: 250), curve: Curves.linear);
            }
          },
          
            
          child: (Text( index ==0? 'Welcome' : 'Previous', style: TextStyle(fontSize: 20),)),),
        
        
        
        InkWell(
           onTap: () => { if (index ==2){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomScreen(toggleTheme: widget.toggleTheme,
                    toggleLanguage: widget.toggleLanguage,))),
           }else{
          _controller.animateToPage(index+1, duration: Duration(milliseconds: 250), curve: Curves.linear)},
           },
          child: (Container
        
        (
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(30)
          ),
          child: (Text(index ==2 ? 'Welcom' : 'Next', style: TextStyle(fontSize: 20),)),)),)
        
        ],),
      ),
    ],
   ),
      ),
    );
  }
}


class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(milliseconds: 250),
 decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(100),
  color: active ?Colors.amber:  Colors.grey ,
 ),
 width: active? 30 : 10,
 height: 10,
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<bool>('active', active));
  // }
}
