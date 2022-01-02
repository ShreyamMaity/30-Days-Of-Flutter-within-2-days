// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_application/utils/firebaseService.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';


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
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    var uid = await FirestoreService().getUserUID();
    await CloudstoreService().getImageUrl(uid: uid.toString());
    await FirestoreService().loadData(uid: uid.toString());
    setStateIfMounted(() {});
  }

  void setStateIfMounted(f) {
  if (mounted) setState(f);
  }

  void SaveData() async {
      setState(() {
        isPressed = true;
      });
      await Future.delayed(Duration(milliseconds: 500));
      var uid = await FirestoreService().getUserUID();
      if (_imageFile != null) {
        await CloudstoreService().uploadFile(_imageFile!.path, uid!);
      }
      await CloudstoreService().getImageUrl(uid: uid.toString());
      var error = await FirestoreService().updateData(
        phone: phone==''?usersmob: phone,
         gender: gender==''?usersgender: gender,
          uid: uid.toString(),
           profilePic: profilePic
           );
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

  void takePhoto(ImageSource source) async{
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (usersname == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        drawer: MyDrawer(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else{
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
            imagePath: _imageFile==null? NetworkImage(profilePic): FileImage(File(_imageFile!.path)) as ImageProvider,
            onClicked: () async {
              takePhoto(ImageSource.gallery);
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
                name = value;
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
                email = value;
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
                phone = value;
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
                gender = value;
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
}

class ImageWidget extends StatelessWidget {
  final ImageProvider imagePath;
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

Widget buildImage(ImageProvider imagePath, VoidCallback onClicked) {

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: imagePath,
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
