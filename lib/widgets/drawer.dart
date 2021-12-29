// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, prefer_const_constructors, dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_application/models/profile.dart';
import 'package:test_application/utils/authService.dart';
import 'package:test_application/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:test_application/widgets/themeCrontoller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

// bool isDark = false;

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final user = UserPrefernces.MyUser;
    var name = '';
    var email = '';



    launchMailto() async {
      final mailtoLink = Mailto(
        to: ['sm8967724231@gmail.com'],
        subject: 'Hello',
        body: 'Hi, I am using this app',
      );
      await launch('$mailtoLink');
    }

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
                accountName: Text(user.name),
                accountEmail: Text(user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: context.accentColor,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(color: context.accentColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.homeRoute);
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: context.accentColor,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: context.accentColor,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.profileRoute);
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: context.accentColor,
              ),
              title: Text(
                "Email me",
                textScaleFactor: 1.2,
                style: TextStyle(color: context.accentColor),
              ),
              onTap: () {
                Navigator.pop(context);
                launchMailto();
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.settings,
                color: context.accentColor,
              ),
              title: Text(
                "Settings",
                textScaleFactor: 1.2,
                style: TextStyle(color: context.accentColor),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: "Coming Soon...".text.make(),
                ));
              },
            ),
            ListTile(
              title: "Theme".text.scale(1.2).bold.make(),
              leading: Icon(CupertinoIcons.moon, color: context.accentColor),
              onTap: () {
                themeController().setTheme();
              },
            ),
            ListTile(
              title: Text(
                "Log Out",
                textScaleFactor: 1.2,
                style: TextStyle(color: context.accentColor),
              ),
              leading: Icon(
                CupertinoIcons.return_icon,
                color: context.accentColor,
              ),
              onTap: () {
                context.read<AuthenticationService>().signOut();
                Navigator.pushNamed(context, MyRoutes.loginRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}