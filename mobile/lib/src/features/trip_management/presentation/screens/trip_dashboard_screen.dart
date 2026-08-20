import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';

class TripDashboardScreen extends StatelessWidget {
  const TripDashboardScreen({
    required this.tripName,
    required this.country,
    required this.startDate,
    required this.endDate,
    super.key,
  });

  final String tripName;
  final String country;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.tripDashboardTitle),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: AppStrings.tripDashboardSettingsTooltip,
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _TripHero(
              tripName: tripName,
              country: country,
              dateRange: '${_formatDate(startDate)} - ${_formatDate(endDate)}',
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(AppStrings.tripDashboardOverview, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            const _OverviewRow(),
            const SizedBox(height: AppSpacing.xl),
            Text(
              AppStrings.tripDashboardQuickActions,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            const _DashboardActionGrid(),
            const SizedBox(height: AppSpacing.xl),
            Text(
              AppStrings.tripDashboardRecentActivity,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            _ActivityEmptyState(colorScheme: colorScheme, textTheme: textTheme),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }
}

class _TripHero extends StatelessWidget {
  const _TripHero({
    required this.tripName,
    required this.country,
    required this.dateRange,
  });

  final String tripName;
  final String country;
  final String dateRange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Text(
                  AppStrings.tripDashboardStatus,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(tripName, style: textTheme.displaySmall),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(Icons.public_rounded, color: colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(country, style: textTheme.bodyLarge)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(Icons.date_range_rounded, color: colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(dateRange, style: textTheme.bodyMedium)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  const _OverviewRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _MetricCard(value: '0', label: 'Expenses'),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _MetricCard(value: '0', label: 'Photos'),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _MetricCard(value: '0', label: 'Notes'),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Text(
              value,
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _DashboardActionGrid extends StatelessWidget {
  const _DashboardActionGrid();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        _DashboardActionTile(
          icon: Icons.payments_outlined,
          label: AppStrings.tripDashboardAddExpense,
        ),
        _DashboardActionTile(
          icon: Icons.photo_camera_outlined,
          label: AppStrings.tripDashboardAddPhoto,
        ),
        _DashboardActionTile(
          icon: Icons.mood_outlined,
          label: AppStrings.tripDashboardAddEmotion,
        ),
        _DashboardActionTile(
          icon: Icons.edit_note_outlined,
          label: AppStrings.tripDashboardAddNote,
        ),
        _DashboardActionTile(
          icon: Icons.timeline_rounded,
          label: AppStrings.tripDashboardTimeline,
        ),
        _DashboardActionTile(
          icon: Icons.auto_stories_outlined,
          label: AppStrings.tripDashboardSummary,
        ),
      ],
    );
  }
}

class _DashboardActionTile extends StatelessWidget {
  const _DashboardActionTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 140,
      child: Card(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: colorScheme.secondary, size: 28),
                const SizedBox(height: AppSpacing.md),
                Text(label, style: textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityEmptyState extends StatelessWidget {
  const _ActivityEmptyState({
    required this.colorScheme,
    required this.textTheme,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Icon(Icons.auto_awesome_rounded, color: colorScheme.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.tripDashboardNoActivity,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppStrings.tripDashboardNoActivitySubtitle,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
