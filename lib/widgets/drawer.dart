// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_application/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:test_application/widgets/themeCrontoller.dart';

// bool isDark = false;

class MyDrawer extends StatelessWidget {

  
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    final ImageUrl = "https://res.cloudinary.com/practicaldev/image/fetch/s--AUy_lRQk--/c_fill,f_auto,fl_progressive,h_320,q_auto,w_320/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/731756/8fc92f26-beed-427b-8f98-2ee186963428.jpeg";

    return Drawer(
      child: Container(
        color: context.canvasColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                accountName: Text("Shreyam Maity"),
                accountEmail: Text("sm8967724231@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(ImageUrl),
                ),
                ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.home,color: context.accentColor,),
              title: Text("Home",textScaleFactor: 1.2,style: TextStyle(color: context.accentColor),),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.profile_circled,color: context.accentColor,),
              title: Text("Profile",textScaleFactor: 1.2,style: TextStyle(color: context.accentColor, ),),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.mail,color: context.accentColor,),
              title: Text("Email me",textScaleFactor: 1.2,style: TextStyle(color: context.accentColor),),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.settings,color: context.accentColor,),
              title: Text("Settings",textScaleFactor: 1.2,style: TextStyle(color: context.accentColor),),
            ),
            ListTile(
              title: "Theme".text.scale(1.2).bold.make(),
              trailing: Switch(
                value: false,
                onChanged: bloc.changeTheme,
              ),
              ),
          ],
        ),
      ),
    );
  }
}


