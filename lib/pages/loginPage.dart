// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, implementation_imports, await_only_futures, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_application/utils/authService.dart';
import 'package:test_application/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String name = "";
  String pass = "";
  bool isPressed = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isPressed = true;
      });
      await Future.delayed(Duration(milliseconds: 500));
      var error = await context
          .read<AuthenticationService>()
          .signIn(email: name, password: pass);
      print(await error);
      if (error != null) {
        if (error == "Signed In") {
          Navigator.pushNamed(context, MyRoutes.homeRoute);
        }
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text("$error"),
                ));
      }
      setState(() {
        isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.canvasColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/login_image.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome $name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Enter Email",
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          pass = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(isPressed ? 50 : 8),
                        color:
                            isPressed ? Colors.blue : context.theme.buttonColor,
                        child: InkWell(
                          onTap: () {
                            moveToHome(context);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: isPressed ? 50 : 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: isPressed
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.signupRoute);
                          ;
                        },
                        child: Text(
                          'Not Registered?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
