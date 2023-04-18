import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sever/Screens/login_screen.dart';
import 'package:flutter_sever/screens/home_screen.dart';
import 'package:flutter_sever/screens/register_screen.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink, fontFamily: 'comfortaa'),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
