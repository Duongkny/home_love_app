import 'package:flutter/material.dart';
import 'package:homelove/src/constant/assets.dart';


class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        Assets.backgroundAuth,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}