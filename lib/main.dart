import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kpu_app/ui/views/data_screen/view/voter_list_screen.dart';
import 'package:kpu_app/ui/views/form_screen/view/form_screen.dart';
import 'package:kpu_app/ui/views/home_screen/view/home_screen.dart';
import 'package:kpu_app/ui/views/information_screen/view/information_screen.dart';
import 'package:kpu_app/ui/views/login_screen/view/login_screen.dart';
import 'package:kpu_app/utils/constants.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(Constant.mainColor),
        ),
      ),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        InformationScreen.routeName: (context) => const InformationScreen(),
        FormScreen.routeName: (context) => const FormScreen(),
        VoterListScreen.routeName: (context) => const VoterListScreen(),
      },
    );
  }
}
