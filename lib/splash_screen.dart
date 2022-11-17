import 'package:flutter/material.dart';
import 'widgets/marketku_logotype.dart';

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
        child: Theme.of(context).brightness == Brightness.dark
            ? MyMarketKuLogotype.light(fontSize: 40)
            : MyMarketKuLogotype.dark(fontSize: 40),
      ),
    );
  }
}
