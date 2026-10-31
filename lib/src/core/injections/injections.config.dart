// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/adapters.dart' as _i170;
import 'package:homelove/src/core/api/dio_client.dart' as _i519;
import 'package:homelove/src/core/injections/module.dart' as _i939;
import 'package:homelove/src/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i389;
import 'package:homelove/src/features/auth/data/repos/auth_repo_impl.dart'
    as _i1048;
import 'package:homelove/src/features/auth/domain/repos/auth_repo.dart' as _i4;
import 'package:homelove/src/features/auth/domain/usecases/forgot_password_usecase.dart'
    as _i992;
import 'package:homelove/src/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i651;
import 'package:homelove/src/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i206;
import 'package:homelove/src/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i1053;
import 'package:homelove/src/features/auth/presentation/bloc/auth_bloc.dart'
    as _i171;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.DioClient>(() => _i519.DioClient());
    gh.lazySingleton<_i170.HiveInterface>(() => registerModule.hive);
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
    );
    gh.lazySingleton<_i974.Logger>(() => registerModule.logger);
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(gh<_i519.DioClient>()),
    );
    gh.lazySingleton<_i389.AuthRemoteDataSource>(
      () => _i389.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i4.AuthRepo>(
      () => _i1048.AuthRepoImpl(gh<_i389.AuthRemoteDataSource>()),
    );
    gh.factory<_i992.ForgotPasswordUseCase>(
      () => _i992.ForgotPasswordUseCase(gh<_i4.AuthRepo>()),
    );
    gh.factory<_i651.SignInUseCase>(
      () => _i651.SignInUseCase(gh<_i4.AuthRepo>()),
    );
    gh.factory<_i206.SignUpUseCase>(
      () => _i206.SignUpUseCase(gh<_i4.AuthRepo>()),
    );
    gh.factory<_i1053.UpdateProfileUseCase>(
      () => _i1053.UpdateProfileUseCase(gh<_i4.AuthRepo>()),
    );
    gh.factory<_i171.AuthBloc>(
      () => _i171.AuthBloc(
        gh<_i651.SignInUseCase>(),
        gh<_i206.SignUpUseCase>(),
        gh<_i1053.UpdateProfileUseCase>(),
        gh<_i992.ForgotPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i939.RegisterModule {}
