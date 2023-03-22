import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kpu_app/utils/constants.dart';

class AnimationScreen extends StatefulWidget {
  static const String routeName = 'welcome_screen';

  const AnimationScreen({super.key});

  @override
  AnimationScreenState createState() => AnimationScreenState();
}

class AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation =
        ColorTween(begin: const Color(Constant.mainColor), end: Colors.white)
            .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    Duration duration = const Duration(seconds: 3);
    Future.delayed(
      duration,
      () {
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: TypewriterAnimatedTextKit(
            text: const ['Mendapatkan Alamat'],
            textStyle: const TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
