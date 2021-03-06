import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _startSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(ImagePath.appIcon),
      ),
    );
  }

  _startSplashScreen() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, _navigationPage);
  }

  void _navigationPage() {
    Modular.to.pushReplacementNamed(Modular.get<Routes>().welcome);
  }
}
