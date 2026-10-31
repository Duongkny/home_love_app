
import 'package:homelove/src/features/auth/domain/entites/user_token.dart';
import 'package:injectable/injectable.dart';


import '../repos/auth_repo.dart';

@injectable
class SignInUseCase {
  final AuthRepo _repo;

  const SignInUseCase(this._repo);

  Future<UserToken> call({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim();

    if (normalizedEmail.isEmpty) {
      throw ArgumentError('Vui lòng nhập email');
    }

    if (password.isEmpty) {
      throw ArgumentError('Vui lòng nhập mật khẩu');
    }

    return _repo.signIn(
      email: normalizedEmail,
      password: password,
    );
  }
}
