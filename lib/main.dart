
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:homelove/src/core/firebase/firebase_options_dev.dart';

import 'src/core/app/my_app.dart';

import 'src/core/injections/injections.dart';


bool isInitializedFirebase = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive CE
  await Hive.initFlutter();

  // Dependency Injection
  await configureDependencies();

  // Run App
  runApp(const MyApp());
}
