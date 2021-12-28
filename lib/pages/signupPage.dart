// ignore_for_file: prefer_const_constructors, await_only_futures, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_application/utils/authService.dart';
import 'package:test_application/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  String username = "";
  String name = "";
  String pass = "";
  bool isPressed = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {isPressed = true;});
    await Future.delayed(Duration(milliseconds: 500));
    var error = await context.read<AuthenticationService>().signUp(email: username, password: pass);
    print(await error);
    if (error != null) {
      if (error == "Signed Up") {
      Navigator.pushNamed(context, MyRoutes.homeRoute);
      }
      showDialog(context: context, builder: (context) => AlertDialog(content: Text("$error"),));}
    
    setState(() {isPressed = false;});
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
              Image.asset('assets/images/signup_image.png',fit: BoxFit.cover,),
              SizedBox(height: 20),
              Text('Welcome $name',style: TextStyle(
                fontSize: 24,
                fontWeight : FontWeight.bold,
              ),),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 16.0,horizontal: 32),
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "John Smith",
                      labelText: "Name", 
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'name is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                        name = value;
                        setState(() {});
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Mail ID",
                      labelText: "Email", 
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'email is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                        username = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Password is required';
                      }
                      else if(value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onChanged: (value){
                      pass = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 20,),
                  Material(
                    borderRadius: BorderRadius.circular(isPressed?50: 8),
                    color: isPressed?Colors.blue: context.theme.buttonColor,
                    child: InkWell(
                      onTap: (){
                        moveToHome(context);
                      },
                      
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: isPressed?50: 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: isPressed? Icon(Icons.done, color: Colors.white,): Text('Sign Up',style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    },
                    child: Text('Login Instead',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],),
              )
            ],
          ),
        ),
      )
    );
  







  }
}