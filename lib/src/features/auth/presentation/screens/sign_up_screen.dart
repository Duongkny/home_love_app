
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homelove/src/core/presentation/widgets/input_field.dart';


import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.onSignIn,
    required this.onSignUpSuccess,
    this.onPrivacyPolicy,
  });

  final VoidCallback onSignIn;
  final VoidCallback onSignUpSuccess;
  final VoidCallback? onPrivacyPolicy;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isAgreePolicy = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthError || current is SignedUp,
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

        if (state is SignedUp) {
          widget.onSignUpSuccess();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 24.h,
            ),
            child: ContainerAuth(
              children: [
                Icon(
                  Icons.house_rounded,
                  size: 52.r,
                  color: colorScheme.primary,
                ),

                SizedBox(height: 8.h),

                Text(
                  'HomeLove',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Tạo tài khoản mới',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  'Bắt đầu hành trình yêu thương của bạn',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 28.h),

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
                        hintText: 'Tạo mật khẩu',
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          size: 24.r,
                        ),
                      ),

                      SizedBox(height: 14.h),

                      InputField.password(
                        controller: _confirmPasswordController,
                        labelText: 'Confirm Password',
                        hintText: 'Xác nhận mật khẩu',
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icon(
                          Icons.lock_reset_rounded,
                          size: 24.r,
                        ),
                        onFieldSubmitted: (_) {
                          if (!isLoading) {
                            _onSignUpButtonClicked();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                // Điều khoản và chính sách
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isAgreePolicy,
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _isAgreePolicy = value ?? false;
                              });
                            },
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Wrap(
                          crossAxisAlignment:
                              WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Tôi đồng ý với ',
                              style: textTheme.bodySmall,
                            ),
                            InkWell(
                              onTap: widget.onPrivacyPolicy,
                              child: Text(
                                'Điều khoản và Chính sách bảo mật',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Nút đăng ký
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: FilledButton(
                    onPressed:
                        isLoading ? null : _onSignUpButtonClicked,
                    child: isLoading
                        ? SizedBox(
                            height: 22.r,
                            width: 22.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : Text(
                            'Đăng ký',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 24.h),

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

                SizedBox(height: 20.h),

                // Google Sign-Up chưa tích hợp
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.account_circle_outlined,
                    ),
                    label: const Text('Tiếp tục với Google'),
                  ),
                ),

                SizedBox(height: 24.h),

                // Chuyển sang đăng nhập
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản?',
                      style: textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed:
                          isLoading ? null : widget.onSignIn,
                      child: const Text('Đăng nhập'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSignUpButtonClicked() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    // Kiểm tra mật khẩu xác nhận
    if (_passwordController.text !=
        _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu xác nhận không khớp'),
        ),
      );
      return;
    }

    // Kiểm tra điều khoản
    if (!_isAgreePolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Vui lòng đồng ý với điều khoản sử dụng',
          ),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
      SignUpEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ),
    );
  }
}
