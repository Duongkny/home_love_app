
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:homelove/src/constant/assets.dart';
import 'package:homelove/src/core/extension/context.dart';
import 'package:homelove/src/router/route.dart';

import '../widgets/intro_layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  static const List<_OnboardingItem> _pages = [
    _OnboardingItem(
      image: Assets.onboardingMemory,
      icon: Icons.auto_stories_rounded,
    ),
    _OnboardingItem(
      image: Assets.onboardingCalendar,
      icon: Icons.calendar_month_rounded,
    ),
    _OnboardingItem(
      image: Assets.onboardingLetter,
      icon: Icons.favorite_rounded,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.hasClients &&
        _currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _skipOnboarding() {
    AppRoute.signIn.go(context);
  }

  Widget _buildIllustration(
    _OnboardingItem page,
    Color primaryColor,
  ) {
    return Image.asset(
      page.image,
      width: 170.w,
      height: 170.h,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: 170.w,
          height: 170.h,
          child: Icon(
            page.icon,
            size: 100.r,
            color: primaryColor,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = context.loc;

    final titles = [
      loc.onboardingMemoryTitle,
      loc.onboardingHabitsTitle,
      loc.onboardingConnectionTitle,
    ];

    final descriptions = [
      loc.onboardingMemoryDescription,
      loc.onboardingHabitsDescription,
      loc.onboardingConnectionDescription,
    ];

    return IntroLayout(
      child: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          final isLastPage = index == _pages.length - 1;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 28.h,
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
                    // Illustration
                    _buildIllustration(
                      page,
                      colorScheme.primary,
                    ),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      titles[index],
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Description
                    Text(
                      descriptions[index],
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // Worm Page Indicator - nằm TRONG card
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: WormEffect(
                        spacing: 8.w,
                        dotWidth: 8.w,
                        dotHeight: 8.h,
                        radius: 12.r,
                        activeDotColor: colorScheme.primary,
                        dotColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      onDotClicked: (dotIndex) {
                        if (!_pageController.hasClients) return;

                        _pageController.animateToPage(
                          dotIndex,
                          duration: const Duration(milliseconds: 450),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    ),

                    SizedBox(height: 30.h),

                    if (!isLastPage) ...[
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: _skipOnboarding,
                            child: Text(loc.skip),
                          ),
                          IconButton.filled(
                            onPressed: _nextPage,
                            icon: const Icon(
                              Icons.arrow_forward_rounded,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: FilledButton(
                          onPressed: () {
                            AppRoute.signUp.go(context);
                          },
                          child: Text(loc.createAccount),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: OutlinedButton(
                          onPressed: _skipOnboarding,
                          child: Text(loc.signIn),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OnboardingItem {
  const _OnboardingItem({
    required this.image,
    required this.icon,
  });

  final String image;
  final IconData icon;
}
