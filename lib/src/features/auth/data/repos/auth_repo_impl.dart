
import 'package:homelove/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:homelove/src/features/auth/domain/entites/profile_information.dart';
import 'package:homelove/src/features/auth/domain/entites/user_token.dart';
import 'package:homelove/src/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';



@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remote;

  AuthRepoImpl(this._remote);

  @override
  Future<UserToken> signIn({
    required String email,
    required String password,
  }) {
    return _remote.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _remote.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> updateProfile(
    ProfileInformation information,
  ) {
    return _remote.updateProfile(information);
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) {
    return _remote.forgotPassword(
      email: email,
    );
  }
}
