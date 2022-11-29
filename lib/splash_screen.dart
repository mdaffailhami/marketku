import 'package:flutter/material.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({
    super.key,
    required this.duration,
    required this.home,
  });

  final Duration duration;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      duration,
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => home),
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/marketku-logo.png',
          width: 180,
        ),
      ),
    );
  }
}
