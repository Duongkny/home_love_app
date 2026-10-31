import 'package:homelove/src/features/auth/domain/entites/profile_information.dart';
import 'package:homelove/src/features/auth/domain/entites/user_token.dart';


abstract class AuthRepo {
  Future<UserToken> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<void> updateProfile(
    ProfileInformation information,
  );

  Future<void> forgotPassword({
    required String email,
  });
}
