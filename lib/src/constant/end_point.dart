import 'package:homelove/src/constant/enviroment.dart';

class EndPoint {
  EndPoint._();

  static String get apiUrl => '${Environment.getApiUrl}/api';

  // Authentication
  static String get _auth => '$apiUrl/auth';

  static String get authSignIn => '';
  static String get authSignUp => '';
  static String get authForgotPassword => '';
  static String get authRefreshToken => '';
  static String get authSignOut => '';

  // User
  static String get _user => '$apiUrl/user';

  static String get userGetUser => '';
  static String get userUpdateInformation => '';
  static String get userUpdateAvatar => '';
  static String get userUpdateFcmToken => '';
}
