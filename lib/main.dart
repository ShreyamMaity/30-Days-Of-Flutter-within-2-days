// ignore_for_file: prefer_const_constructors, unused_import, import_of_legacy_library_into_null_safe, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_application/pages/signupPage.dart';
import 'package:test_application/utils/authService.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:test_application/widgets/themeCrontoller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:test_application/core/store.dart';
import 'package:test_application/pages/cartPage.dart';
import 'package:test_application/pages/homepage.dart';
import 'package:test_application/pages/loginPage.dart';
import 'package:test_application/utils/routes.dart';
import 'package:test_application/widgets/themes.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(VxState(
    store: MyStore(),
    child: MyApp())
    );
  
}

class MyApp extends StatelessWidget {

  const MyApp({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,),
      ],
      child: GetMaterialApp(
            themeMode: themeController().theme,
            theme: MyTheme.lightTheme(context),
            debugShowCheckedModeBanner: false,
            darkTheme: MyTheme.darkTheme(context),
            initialRoute: MyRoutes.authWrapper,
            routes: {
              MyRoutes.authWrapper: (context) => AuthenticationWrapper(),
              MyRoutes.homeRoute : (context) => Homepage(),
              MyRoutes.loginRoute: (context) => LoginPage(),
              MyRoutes.signupRoute: (context) => SignupPage(),
              MyRoutes.cartRoute: (context) => Cartpage(),
            },
          
          ),
    );
    }
    
  }

  class AuthenticationWrapper extends StatelessWidget {
    const AuthenticationWrapper({ Key? key }) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      final firebaseuser =  context.watch<User?>();
      

      if (firebaseuser == null) {
        return LoginPage();
      } else {
        return Homepage();
      }
    }
  }

