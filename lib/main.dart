import 'package:flutter/material.dart';
import 'package:nxcar/presenter/pages/OTP_screen.dart';
import 'package:nxcar/presenter/pages/onboarding_view.dart';
import 'package:nxcar/presenter/pages/signup_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nxcar',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Noto Sans'
      ),
      home: const OnBoardingView(),
    );
  }
}

