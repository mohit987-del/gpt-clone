import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.label, required this.left});
  final String label;
  final bool left;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: left ? Alignment.centerLeft : Alignment.centerRight,
        child: left
            ? AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    label,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 20),
                  ),
                ],
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
