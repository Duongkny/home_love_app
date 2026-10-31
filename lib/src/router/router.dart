
import 'package:go_router/go_router.dart';

import 'router.auth.dart';
import 'router.main.dart';
import 'route.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoute.signIn.path,
  routes: [
    ...authRoutes,
    // ...mainRoutes,
  ],
);
