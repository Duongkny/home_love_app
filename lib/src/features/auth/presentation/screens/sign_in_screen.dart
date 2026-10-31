
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homelove/src/core/presentation/widgets/input_field.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    required this.onSignUp,
    required this.onForgotPassword,
    this.onSignInSuccess,
  });

  final VoidCallback onSignUp;
  final VoidCallback onForgotPassword;
  final VoidCallback? onSignInSuccess;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInButtonClicked() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
      SignInEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthError || current is SignedIn,
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }

        if (state is SignedIn) {
          widget.onSignInSuccess?.call();
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: ContainerAuth(
                children: [
                  // =========================
                  // LOGO
                  // =========================
                  Icon(
                    Icons.house_rounded,
                    size: 52.r,
                    color: colorScheme.primary,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    'HomeLove',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    'Chào mừng bạn quay trở lại',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // FORM
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField.email(
                          controller: _emailController,
                          
                          hintText: 'Nhập email của bạn',
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            size: 24.r,
                          ),
                        ),

                        SizedBox(height: 14.h),

                        InputField.password(
                          controller: _passwordController,
                          hintText: 'Nhập mật khẩu',
                          textInputAction: TextInputAction.done,
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            size: 24.r,
                          ),
                          onFieldSubmitted: (_) {
                            if (!isLoading) {
                              _onSignInButtonClicked();
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // FORGOT PASSWORD
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isLoading
                          ? null
                          : widget.onForgotPassword,
                      child: Text(
                        'Quên mật khẩu?',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // SIGN IN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: FilledButton(
                      onPressed: isLoading
                          ? null
                          : _onSignInButtonClicked,
                      child: isLoading
                          ? SizedBox(
                              width: 22.r,
                              height: 22.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              'Đăng nhập',
                              style: textTheme.titleMedium?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // DIVIDER
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          'hoặc',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // GOOGLE SIGN IN
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(
                        Icons.account_circle_outlined,
                      ),
                      label: const Text(
                        'Đăng nhập với Google',
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // SIGN UP
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Chưa có tài khoản?',
                        style: textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : widget.onSignUp,
                        child: const Text('Đăng ký ngay'),
                      ),
                    ],
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
