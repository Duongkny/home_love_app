
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  getStarted('/get-started'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  signUpInformation('/sign-up-information'),
  forgotPassword('/forgot-password'),
  home('/home');

  const AppRoute(this.path);

  final String path;

  void go(BuildContext context) {
    context.go(path);
  }

  Future<T?> push<T extends Object?>(
    BuildContext context,
  ) {
    return context.push<T>(path);
  }

  void pushReplacement(BuildContext context) {
    context.pushReplacement(path);
  }
}
