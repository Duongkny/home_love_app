
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:homelove/src/features/auth/domain/entites/profile_information.dart';
import 'package:homelove/src/features/auth/domain/entites/user_token.dart';
import 'package:injectable/injectable.dart';


import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._updateProfileUseCase,
    this._forgotPasswordUseCase,
  ) : super(const AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetAuthEvent>(_onResetAuth);
  }

  // SIGN IN
  Future<void> _onSignIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final userToken = await _signInUseCase(
        email: event.email,
        password: event.password,
      );

      emit(SignedIn(userToken));
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // SIGN UP
  Future<void> _onSignUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _signUpUseCase(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      emit(const SignedUp());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // UPDATE PROFILE
  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _updateProfileUseCase(
        information: event.information,
      );

      emit(const ProfileUpdated());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // FORGOT PASSWORD
  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _forgotPasswordUseCase(
        email: event.email,
      );

      emit(const ForgotPasswordSuccess());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // RESET AUTH STATE
  void _onResetAuth(
    ResetAuthEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthInitial());
  }

  // ERROR HANDLING
  String _getErrorMessage(Object error) {
    if (error is ArgumentError) {
      return error.message?.toString() ??
          'Dữ liệu không hợp lệ';
    }

    if (error is UnimplementedError) {
      return 'Chức năng đang được phát triển';
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Kết nối quá thời gian. Vui lòng thử lại';

        case DioExceptionType.connectionError:
          return 'Không thể kết nối đến máy chủ';

        default:
          break;
      }

      switch (error.response?.statusCode) {
        case 400:
          return 'Thông tin không hợp lệ';

        case 401:
          return 'Xác thực thất bại';

        case 403:
          return 'Bạn không có quyền thực hiện thao tác';

        case 404:
          return 'Không tìm thấy tài nguyên';

        case 409:
          return 'Thông tin đã tồn tại';

        case 429:
          return 'Bạn thao tác quá nhiều lần. '
              'Vui lòng thử lại sau';

        case 500:
        case 502:
        case 503:
          return 'Máy chủ đang gặp sự cố';

        default:
          return 'Có lỗi kết nối. Vui lòng thử lại';
      }
    }

    return 'Đã xảy ra lỗi. Vui lòng thử lại';
  }
}
