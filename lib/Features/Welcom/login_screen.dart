import 'package:flutter/material.dart';
import 'package:marketo/Features/Products/Persentation/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Products/Persentation/Cubits/home_cubit.dart';
import '../Products/data/data/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Products/data/data/api_service.dart';



class LoginScreen extends StatelessWidget {

  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  LoginScreen({
    super.key,
    required this.toggleTheme,
    required this.toggleLanguage,
  });

  final _formKey = GlobalKey<FormState>();

  final mailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Image.asset(
                    'assets/Images/Black_Modern_MS_Logo-removebg-preview.png',
                    width: 300,
                  ),

                  // Email
                  TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                        return 'Password is too short';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Username
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                  SizedBox(height: 24),

                  // Login Button
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {

                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: mailController.text.trim(),
                            password: passController.text.trim(),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Successful!')),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomeScreen(
                                toggleTheme: toggleTheme,
                                toggleLanguage: toggleLanguage,
                              ),
                            ),
                      );
                        } catch (e) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all required fields')),
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
                        'Login',
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
