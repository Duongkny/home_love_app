import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:homelove/src/features/auth/presentation/screens/forgot_password_screen.dart';

import '../core/injections/injections.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';

import 'route.dart';

final List<RouteBase> authRoutes = [
  ShellRoute(
    builder: (context, state, child) {
      return AuthScreen(child: child);
    },
    routes: [
      GoRoute(
        path: AppRoute.signIn.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: SignInScreen(
              onSignUp: () => AppRoute.signUp.go(context),
              onForgotPassword: () => AppRoute.forgotPassword.push(context),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: SignUpScreen(
              onSignIn: () => AppRoute.signIn.go(context),
              onSignUpSuccess: () => AppRoute.signUpInformation.go(context),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoute.forgotPassword.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
    ],
  ),
];
