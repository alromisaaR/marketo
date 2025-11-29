import 'package:flutter/material.dart';
import 'package:marketo/Features/Welcom/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatelessWidget {

  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  SignupScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final mailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  final nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Register')), backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        body: Padding(
          padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/Images/Black_Modern_MS_Logo-removebg-preview.png', width: 300,),

                // Username
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: mailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }
                    String pattern =
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Email is not valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password is very short';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  controller: confirmpassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please confirm your password';
                    }
                    if (value != passController.text) {
                      return 'Not matshed';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // Sign Up Button
                InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {

                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: mailController.text.trim(),
                            password: passController.text.trim(),
                          );


                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Account created successfully!')),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(toggleTheme: toggleTheme,
                                    toggleLanguage: toggleLanguage)),
                          );
                        } catch (e) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Please fill all required fields')),
                        );
                      }
                    },
                    child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 250,
                    height: 50,
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
            ),
        ),
      ),
    );
  }
}
