import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/provider/provider_quotes.dart';
import 'package:quotes_api_app/screen/detailpage.dart';
import 'package:quotes_api_app/screen/fev.dart';
import 'package:quotes_api_app/screen/home_screen.dart';
import 'package:quotes_api_app/screen/spalesh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuotesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'spalesh',
        routes: {
          '/': (context) => const HomePage(),
          'spalesh': (context) => const spalesh(),
          'detail': (context) => const DetailPage(),
          'fev': (context) => const favorite()
        },
      ),
    );
  }
}
