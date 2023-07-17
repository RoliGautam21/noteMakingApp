import 'package:flutter/material.dart';
import 'package:notemakngapp/screen/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage().routname, (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/img.gif'),
      ),
    );
  }
}
