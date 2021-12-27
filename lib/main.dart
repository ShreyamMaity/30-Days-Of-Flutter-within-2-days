// ignore_for_file: prefer_const_constructors, unused_import, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:test_application/widgets/themeCrontoller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:test_application/core/store.dart';
import 'package:test_application/pages/cartPage.dart';
import 'package:test_application/pages/homepage.dart';
import 'package:test_application/pages/loginPage.dart';
import 'package:test_application/utils/routes.dart';
import 'package:test_application/widgets/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(VxState(
    store: MyStore(),
    child: MyApp())
    );
  
}

class MyApp extends StatelessWidget {

  const MyApp({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
          themeMode: themeController().theme,
          theme: MyTheme.lightTheme(context),
          debugShowCheckedModeBanner: false,
          darkTheme: MyTheme.darkTheme(context),
          initialRoute: MyRoutes.homeRoute,
          routes: {
            MyRoutes.homeRoute : (context) => Homepage(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.cartRoute: (context) => Cartpage(),
          },
        
        );
      }
    
  }

