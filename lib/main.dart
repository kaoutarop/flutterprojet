import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/screen/home.page.dart';
import 'package:flutter_project/screen/login.page.dart';
import 'package:flutter_project/screen/register.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme:ColorScheme.fromSeed(seedColor: Colors.blue)
      ),

      title: 'El hachemy Kaoutar flutter application',
      //home: HomePage()
      initialRoute: '/login',
      routes: {
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        '/home':(context)=>HomePage()
      },
    );
  }
}
