import 'dart:async';

import 'package:flutter/material.dart';

class spalesh extends StatefulWidget {
  const spalesh({super.key});

  @override
  State<spalesh> createState() => _spaleshState();
}

class _spaleshState extends State<spalesh> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0F1035),
      body: Center(
        child: Text("Quotes",style: TextStyle(fontSize: 60,color: Color(0xff7FC7D9)),),
      ),
    );
  }
}
