
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Đăng nhập bằng Email và Password
final class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}

/// Đăng ký tài khoản
final class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
  ];
}

/// Cập nhật thông tin cá nhân sau đăng ký
final class UpdateProfileEvent extends AuthEvent {
  final ProfileInformation information;

  const UpdateProfileEvent({
    required this.information,
  });

  @override
  List<Object?> get props => [information];
}

/// Yêu cầu khôi phục mật khẩu qua Email
final class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

/// Đưa trạng thái Auth về ban đầu
final class ResetAuthEvent extends AuthEvent {
  const ResetAuthEvent();
}
