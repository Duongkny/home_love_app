
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homelove/src/router/route.dart';

import '../widgets/intro_layout.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IntroLayout(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.h,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // HomeLove introduction card
            Container(
              width: 260.w,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 26.h,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Icon(
                    Icons.house_rounded,
                    size: 60.r,
                    color: colorScheme.primary,
                  ),

                  SizedBox(height: 10.h),

                  // App name
                  Text(
                    'HomeLove',
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Description
                  Text(
                    'Cùng nhau lưu giữ\n'
                    'những khoảnh khắc đẹp nhất',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 3),

            // Get started button
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: FilledButton(
                onPressed: () {
                  AppRoute.onboarding.go(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Bắt đầu',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.r,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
