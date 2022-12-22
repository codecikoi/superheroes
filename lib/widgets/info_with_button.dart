import 'package:flutter/material.dart';

import '../resources/superheroes_colors.dart';
import 'action_button.dart';

class InfoWithButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String assetImage;
  final double imageWidth;
  final double imageHeight;
  final double imageTopPadding;

  const InfoWithButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.assetImage,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageTopPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SuperheroesColors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: imageTopPadding),
              child: Image.asset(
                assetImage,
                width: imageWidth,
                height: imageHeight,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 32.0,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 20),
        Text(
          subtitle.toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        ActionButton(
          text: buttonText,
          onTap: () {},
        ),
      ],
    ));
  }
}
