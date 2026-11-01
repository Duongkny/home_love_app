
import 'package:go_router/go_router.dart';

import 'router.auth.dart';
import 'router.main.dart';
import 'route.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoute.getStarted.path,
  routes: [
    ...authRoutes,
    // ...mainRoutes,
  ],
);
