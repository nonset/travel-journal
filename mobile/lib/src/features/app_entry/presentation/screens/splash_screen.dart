import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Icon(
                        Icons.travel_explore_rounded,
                        size: 64,
                        color: colorScheme.primary,
                        semanticLabel: AppStrings.appName,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    AppStrings.appName,
                    style: textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2),
                  Semantics(
                    label: AppStrings.loading,
                    child: const CircularProgressIndicator(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    AppStrings.loading,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
