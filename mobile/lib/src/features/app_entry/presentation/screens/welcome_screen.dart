import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../expense_tracking/domain/repositories/expense_repository.dart';
import '../../../trip_management/domain/repositories/trip_repository.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    required this.tripRepository,
    required this.expenseRepository,
    super.key,
  });

  final TripRepository tripRepository;
  final ExpenseRepository expenseRepository;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.auto_stories_rounded,
                size: 72,
                color: colorScheme.primary,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                AppStrings.welcomeTitle,
                style: textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                AppStrings.welcomeSubtitle,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: const [
                  _WelcomeChip(label: AppStrings.welcomeMemoryFirst),
                  _WelcomeChip(label: AppStrings.welcomeOfflineReady),
                  _WelcomeChip(label: AppStrings.welcomeFastRecording),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => _openHome(context),
                child: const Text(AppStrings.welcomePrimaryAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => _openHome(context),
                child: const Text(AppStrings.welcomeSecondaryAction),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomeScreen(
            tripRepository: tripRepository,
            expenseRepository: expenseRepository,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}

class _WelcomeChip extends StatelessWidget {
  const _WelcomeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
