import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:homelove/src/core/api/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  @LazySingleton()
  HiveInterface get hive => Hive;

  @LazySingleton()
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @LazySingleton()
  Logger get logger => Logger();
  
  @lazySingleton
  Dio dio(DioClient client) => client.dio;
}

class $RegisterModule extends RegisterModule {}