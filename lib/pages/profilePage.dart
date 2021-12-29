// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:test_application/models/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = UserPrefernces.MyUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: MyDrawer(),
      backgroundColor: context.canvasColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ImageWidget(
            imagePath: user.image,
            onClicked: () async {
              print('clicked');
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: user.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "John Doe",
              labelText: "Full Name",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            onChanged: (value) {
              var name = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: user.email,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "example@gmail.com",
              labelText: "Email",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            onChanged: (value) {
              var email = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: user.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "XXXXXXXXXX",
              labelText: "Mobile Number",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mobile Number is required';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            onChanged: (value) {
              var phone = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: user.gender,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Male/Female/Prefer Not to say",
              labelText: "Gender",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Gender is required';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            onChanged: (value) {
              var gender = value;
            },
          ),

        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  const ImageWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.theme.buttonColor;
    return Center(
      child: Stack(
        children: [
          buildImage(imagePath, onClicked),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }
}

Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
          size: 20,
        ),
      ),
    );

Widget buildCircle(
    {required Color color, required double all, required Widget child}) {
  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    ),
  );
}

Widget buildImage(String imagePath, VoidCallback onClicked) {
  final image = NetworkImage(imagePath);

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        height: 128,
        width: 128,
        child: InkWell(
          onTap: onClicked,
        ),
      ),
    ),
  );
}
