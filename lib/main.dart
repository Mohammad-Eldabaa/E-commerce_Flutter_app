import 'package:final_project/auth/Loginpage.dart';
import 'package:final_project/home/home.dart';
import 'package:final_project/auth/registration.dart';
import 'package:final_project/category/showCategory.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-commerce app',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        // '/': (context) => HomePage(),
        '/registration': (context) => RegistrationScreen(),
        '/homescreen': (context) => HomePage(),
        '/categoryshow': (context) => Showcategory(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Color(0xFFFFA451)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(children: [LoginPage()]),
      ),
    );
  }
}
