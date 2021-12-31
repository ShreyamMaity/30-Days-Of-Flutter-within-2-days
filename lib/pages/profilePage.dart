// ignore_for_file: prefer_const_constructors, duplicate_ignore


import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_application/utils/authService.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:test_application/models/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isPressed = false;
  var name = '';
  var email = '';
  var phone = '';
  var gender = '';


  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    var uid = await FirestoreService().getUserUID();
    await FirestoreService().loadData(uid: uid.toString());
    setStateIfMounted(() {});
  }

  void setStateIfMounted(f) {
  if (mounted) setState(f);
  }

  SaveData() async {
      setState(() {
        isPressed = true;
      });
      await Future.delayed(Duration(milliseconds: 500));
      var uid = await FirestoreService().getUserUID();
      var error = await FirestoreService().updateData(phone: phone, gender: gender, uid: uid.toString());
      print(await error);
      if (error != null) {
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

  UserInfo user = UserPrefernces.MyUser;

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
            enabled: false,
            initialValue: usersname,
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
              if(value == ''){
                name = usersname;
              }
              else{
                name = value;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: false,
            initialValue: useremail,
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
              if(value == ''){
                email = useremail;
              }
              else{
                email = value;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: usersmob,
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
              if(value == ''){
                phone = usersmob;
              }
              else{
                phone = value;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: usersgender,
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
              if(value == ''){
                gender = usersgender;
              }
              else{
                gender = value;
              }
            },
          ),
          SizedBox(height: 20,),
          Material(
            borderRadius: BorderRadius.circular(isPressed ? 50 : 8),
            color: isPressed ? Colors.blue : context.theme.buttonColor,
            child: InkWell(
              onTap: () {
                SaveData();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: isPressed ? 50 : 150,
                height: 50,
                alignment: Alignment.center,
                child: isPressed? Icon(Icons.done,color: Colors.white,): Text('Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  ),
                  ),
              ),
            ),
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
