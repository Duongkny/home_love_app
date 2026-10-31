import 'package:flutter_bloc/flutter_bloc.dart';

import '../injections/injections.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

List<BlocProvider> get appProviders => [
  BlocProvider<AuthBloc>(
    create: (_) => getIt<AuthBloc>(),
  ),
];
