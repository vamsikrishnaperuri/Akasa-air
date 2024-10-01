import 'dart:async';
import 'package:flutter/foundation.dart'; // Import this for kIsWeb
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _State();
}

class _State extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/login'); // Update to use '/home'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb ? webView() : mobileView(),
    );
  }

  Widget mobileView() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/mobilesplash.jpeg"), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: content(),
    );
  }

  Widget webView() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/splash_web.jpg"), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: content(),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset("assets/flight.json", width: 1000),
      ),
    );
  }
}
