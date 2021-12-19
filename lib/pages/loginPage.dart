// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:test_application/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/login_image.png',fit: BoxFit.cover,),
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
                    hintText: "Enter Username",
                    labelText: "Username", 
                  ),
                  onChanged: (value) {
                      name = value;
                      setState(() {});
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                  )
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () async{
                    setState(() {
                      isPressed = true;
                    });
                    await Future.delayed(Duration(milliseconds: 500));
                    Navigator.pushNamed(context, MyRoutes.homeRoute);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: isPressed?50: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: isPressed? Icon(Icons.done, color: Colors.white,): Text('Login',style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(isPressed?50: 8)
                    ),
                  ),
                )

                // ElevatedButton(
                //   child: Text('Login'),
                //   style: TextButton.styleFrom(
                //     minimumSize: Size(150,40),
                //   ),
                //   onPressed: () {
                //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                //   },
                //   )
              ],),
            )
          ],
        ),
      )
    );
  







  }
}