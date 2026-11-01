
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:homelove/src/core/firebase/firebase_options_dev.dart'
    as dev;
import 'package:homelove/src/core/firebase/firebase_options_prod.dart'
    as prod;

import 'src/core/app/my_app.dart';
import 'src/core/injections/injections.dart';

const String environment = String.fromEnvironment(
  'ENV',
  defaultValue: 'development',
);

bool isInitializedFirebase = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase
  await _initializeFirebase();

  // 2. Hive CE
  await Hive.initFlutter();

  // 3. Dependency Injection
  await configureDependencies();

  // 4. Run App
  runApp(const MyApp());
}

Future<void> _initializeFirebase() async {
  if (environment != 'development' &&
      environment != 'production') {
    throw StateError('Unsupported environment: $environment');
  }

  final options = environment == 'production'
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform;

  final existingApps = Firebase.apps;

  if (existingApps.isEmpty) {
    await Firebase.initializeApp(options: options);
  } else {
    debugPrint('Firebase đã được khởi tạo trước đó.');
  }

  final app = Firebase.app();

  debugPrint('Environment: $environment');
  debugPrint('Firebase Project: ${app.options.projectId}');

  if (app.options.projectId != options.projectId) {
    throw StateError(
      'Sai Firebase Project: '
      'expected=${options.projectId}, '
      'actual=${app.options.projectId}. '
      'Kiểm tra google-services.json và Android flavor.',
    );
  }
}
