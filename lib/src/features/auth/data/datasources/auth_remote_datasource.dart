
import 'package:dio/dio.dart';
import 'package:homelove/src/constant/end_point.dart';
import 'package:homelove/src/features/auth/domain/entites/profile_information.dart';
import 'package:homelove/src/features/auth/domain/entites/user_token.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Never _notConfigured(String feature) {
    throw UnimplementedError(
      '$feature chưa có API từ backend Spring Boot',
    );
  }

  // Đăng nhập
  Future<UserToken> signIn({
    required String email,
    required String password,
  }) async {
    final endpoint = EndPoint.authSignIn;

    if (endpoint.isEmpty) {
      _notConfigured('Sign In');
    }

    // TODO: Tích hợp API đăng nhập.
    // Request dự kiến:
    // {
    //   "email": email,
    //   "password": password
    // }

    _notConfigured('Sign In response');
  }

  // Đăng ký
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final endpoint = EndPoint.authSignUp;

    if (endpoint.isEmpty) {
      _notConfigured('Sign Up');
    }

    // TODO: Tích hợp API đăng ký.
    // Request dự kiến:
    // {
    //   "email": email,
    //   "password": password
    // }

    _notConfigured('Sign Up request');
  }

  // Quên mật khẩu
  Future<void> forgotPassword({
    required String email,
  }) async {
    final endpoint = EndPoint.authForgotPassword;

    if (endpoint.isEmpty) {
      _notConfigured('Forgot Password');
    }

    // TODO: Tích hợp API gửi email đặt lại mật khẩu.
    _notConfigured('Forgot Password request');
  }

  // Cập nhật thông tin cá nhân
  Future<void> updateProfile(
    ProfileInformation information,
  ) async {
    final endpoint = EndPoint.userUpdateInformation;

    if (endpoint.isEmpty) {
      _notConfigured('Update Profile');
    }

    // TODO: Xác nhận backend nhận JSON
    // hay multipart/form-data.

    // Dữ liệu dự kiến:
    // fullName
    // dateOfBirth
    // gender
    // nickname
    // address
    // phoneNumber
    // avatar

    _notConfigured('Update Profile request');
  }

  // Làm mới token
  Future<UserToken> refreshToken({
    required String refreshToken,
  }) async {
    final endpoint = EndPoint.authRefreshToken;

    if (endpoint.isEmpty) {
      _notConfigured('Refresh Token');
    }

    // TODO: Tích hợp API refresh token.
    _notConfigured('Refresh Token response');
  }

  // Đăng xuất
  Future<void> signOut() async {
    final endpoint = EndPoint.authSignOut;

    if (endpoint.isEmpty) {
      _notConfigured('Sign Out');
    }

    // TODO: Gọi API logout / revoke token nếu backend có.
    _notConfigured('Sign Out request');
  }
}
