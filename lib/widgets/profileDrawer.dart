// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:test_application/utils/firebaseService.dart';
import 'package:shimmer/shimmer.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
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

  @override
  Widget build(BuildContext context) {

    if (usersname == null) {
      // return CircularProgressIndicator().centered().expand();
      return Shimmer.fromColors(
          baseColor: Colors.deepPurple,
          highlightColor: Colors.deepPurple[400]!,
          enabled: true,
          child: UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(''),
          ),
      );
    } else {
      return UserAccountsDrawerHeader(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
        ),
        accountName: Text(usersname),
        accountEmail: Text(useremail),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(profilePic),
        ),
      );
    }
  }
}
