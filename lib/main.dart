import 'package:flutter/material.dart';
import 'package:quotes_api_app/screen/home_screen.dart';
import 'package:quotes_api_app/screen/spalesh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: 'spalesh',
      routes: {
        '/': (context) => const HomePage(),
        'spalesh': (context) => const IntroScreen(),
      },
    );
  }
}
