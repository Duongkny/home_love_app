
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/injections/injections.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';

import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/get_started_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';

import 'route.dart';

final List<RouteBase> authRoutes = [
  // ==========================================
  // GET STARTED
  // ==========================================
  GoRoute(
    path: AppRoute.getStarted.path,
    builder: (context, state) {
      return const GetStartedScreen();
    },
  ),

  // ==========================================
  // ONBOARDING
  // ==========================================

GoRoute(
  path: AppRoute.onboarding.path,
  pageBuilder: (context, state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const OnboardingScreen(),
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.12, 0),
          end: Offset.zero,
        ).animate(curvedAnimation);

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
    );
  },
),


  // ==========================================
  // AUTHENTICATION
  // ==========================================
  ShellRoute(
    builder: (context, state, child) {
      return AuthScreen(
        child: child,
      );
    },
    routes: [
      // SIGN IN
      GoRoute(
        path: AppRoute.signIn.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: SignInScreen(
              onSignUp: () {
                AppRoute.signUp.go(context);
              },
              onForgotPassword: () {
                AppRoute.forgotPassword.push(context);
              },
            ),
          );
        },
      ),

      // SIGN UP
      GoRoute(
        path: AppRoute.signUp.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: SignUpScreen(
              onSignIn: () {
                AppRoute.signIn.go(context);
              },
              onSignUpSuccess: () {
                AppRoute.signUpInformation.go(context);
              },
            ),
          );
        },
      ),

      // FORGOT PASSWORD
      GoRoute(
        path: AppRoute.forgotPassword.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: const ForgotPasswordScreen(),
          );
        },
      ),
    ],
  ),
];
