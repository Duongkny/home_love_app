import 'package:flutter/material.dart';
import 'package:homelove/src/features/auth/presentation/widgets/button_back.dart';

import '../widgets/background.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background chung cho Authentication
          const Background(),

          // Nội dung màn hình
          Positioned.fill(
            child: child,
          ),

          // Nút quay lại
          const SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: ButtonBack(),
            ),
          ),
        ],
      ),
    );
  }
}
