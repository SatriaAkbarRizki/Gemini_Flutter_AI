import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Illustration/ask.png",
            height: 200,
            width: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's find out",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  width: 5,
                ),
                DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!,
                    child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                      TyperAnimatedText('Food',
                          speed: const Duration(milliseconds: 100)),
                      TyperAnimatedText('Travel',
                          speed: const Duration(milliseconds: 100)),
                      TyperAnimatedText('Healthing',
                          speed: const Duration(milliseconds: 100)),
                      TyperAnimatedText('Programming',
                          speed: const Duration(milliseconds: 100)),
                      TyperAnimatedText('Latest News',
                          speed: const Duration(milliseconds: 100)),
                    ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
