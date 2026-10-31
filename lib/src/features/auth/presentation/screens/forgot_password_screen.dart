
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:homelove/src/core/presentation/widgets/input_field.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';
import '../../../../router/route.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
      ForgotPasswordEvent(
        email: _emailController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is ForgotPasswordSuccess ||
          current is AuthError,
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Nếu email tồn tại, hướng dẫn đặt lại mật khẩu sẽ được gửi.',
              ),
            ),
          );

          AppRoute.signIn.go(context);
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message)),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 24.h,
              ),
              child: ContainerAuth(
                children: [
                  Icon(
                    Icons.mark_email_read_rounded,
                    size: 64.r,
                    color: colorScheme.primary,
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    'Quên mật khẩu',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    'Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 28.h),

                  Form(
                    key: _formKey,
                    child: InputField.email(
                      controller: _emailController,
                      hintText: 'Nhập email của bạn',
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        size: 24.r,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: FilledButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? SizedBox(
                              width: 22.r,
                              height: 22.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: colorScheme.onPrimary,
                              ),
                            )
                          : const Text('Gửi liên kết'),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () => AppRoute.signIn.go(context),
                    child: Text(
                      'Quay lại đăng nhập',
                      style: TextStyle(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
