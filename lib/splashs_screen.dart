import 'package:flutter/material.dart';
import 'package:gutenberg_project/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  void splash() async {
    await Future.delayed(const Duration(milliseconds: 3500));

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: ((BuildContext context) => const Gutenberg())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(211, 209, 238, 0.5),
        child: const Center(
            child: Image(image: AssetImage("assets/images/bookicon1.png"))),
      ),
    );
  }
}
