import 'package:flutter/material.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/profile': (context) {
          final String token = ModalRoute.of(context)!.settings.arguments as String;
          return ProfilePage(token: token);
        },
      },
    );
  }
}
