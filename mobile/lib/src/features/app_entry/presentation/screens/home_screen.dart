import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../trip_management/domain/repositories/trip_repository.dart';
import '../../../trip_management/presentation/screens/create_trip_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.tripRepository, super.key});

  final TripRepository tripRepository;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateTrip(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text(AppStrings.homeCreateTrip),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxl + AppSpacing.lg,
          ),
          children: [
            Text(AppStrings.homeGreeting, style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(AppStrings.homeTitle, style: textTheme.displaySmall),
            const SizedBox(height: AppSpacing.sm),
            Text(AppStrings.homeSubtitle, style: textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.xl),
            _EmptyTripCard(
              colorScheme: colorScheme,
              textTheme: textTheme,
              onCreateTrip: () => _openCreateTrip(context),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(AppStrings.homeQuickActions, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            const _QuickActionGrid(),
            const SizedBox(height: AppSpacing.xl),
            Text(AppStrings.homeRecentTrips, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            _RecentTripsPlaceholder(
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }

  void _openCreateTrip(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => CreateTripScreen(tripRepository: tripRepository),
      ),
    );
  }
}

class _EmptyTripCard extends StatelessWidget {
  const _EmptyTripCard({
    required this.colorScheme,
    required this.textTheme,
    required this.onCreateTrip,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onCreateTrip;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Icon(
                  Icons.luggage_rounded,
                  color: colorScheme.primary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(AppStrings.homeEmptyTitle, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(AppStrings.homeEmptySubtitle, style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onCreateTrip,
              icon: const Icon(Icons.add_rounded),
              label: const Text(AppStrings.homeCreateTrip),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionGrid extends StatelessWidget {
  const _QuickActionGrid();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        _QuickActionTile(
          icon: Icons.payments_outlined,
          label: AppStrings.homeActionExpense,
        ),
        _QuickActionTile(
          icon: Icons.photo_camera_outlined,
          label: AppStrings.homeActionPhoto,
        ),
        _QuickActionTile(
          icon: Icons.mood_outlined,
          label: AppStrings.homeActionMood,
        ),
        _QuickActionTile(
          icon: Icons.edit_note_outlined,
          label: AppStrings.homeActionNote,
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.icon, required this.label});

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

class _RecentTripsPlaceholder extends StatelessWidget {
  const _RecentTripsPlaceholder({
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
            Icon(Icons.map_outlined, color: colorScheme.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                AppStrings.homeEmptySubtitle,
                style: textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
