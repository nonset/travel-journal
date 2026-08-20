import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/models/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import 'trip_dashboard_screen.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({required this.tripRepository, super.key});

  final TripRepository tripRepository;

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _countryController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;
  var _isSaving = false;

  @override
  void initState() {
    super.initState();
    final today = DateUtils.dateOnly(DateTime.now());
    _startDate = today;
    _endDate = today.add(const Duration(days: 3));
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.createTripTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(AppStrings.createTripTitle, style: textTheme.displaySmall),
              const SizedBox(height: AppSpacing.sm),
              Text(AppStrings.createTripSubtitle, style: textTheme.bodyLarge),
              const SizedBox(height: AppSpacing.xl),
              TextFormField(
                controller: _tripNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: AppStrings.createTripNameLabel,
                  hintText: AppStrings.createTripNameHint,
                  prefixIcon: Icon(Icons.luggage_rounded),
                ),
                validator: _requiredValidator(
                  AppStrings.createTripNameRequired,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _countryController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: AppStrings.createTripCountryLabel,
                  hintText: AppStrings.createTripCountryHint,
                  prefixIcon: Icon(Icons.public_rounded),
                ),
                validator: _requiredValidator(
                  AppStrings.createTripCountryRequired,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _DatePickerRow(
                startDate: _startDate,
                endDate: _endDate,
                onPickStartDate: () => _pickStartDate(context),
                onPickEndDate: () => _pickEndDate(context),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _CoverPhotoPlaceholder(),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: _isSaving ? null : _saveTrip,
                icon: const Icon(Icons.check_rounded),
                label: const Text(AppStrings.createTripSave),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FormFieldValidator<String> _requiredValidator(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }

      return null;
    };
  }

  Future<void> _pickStartDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() {
      _startDate = DateUtils.dateOnly(pickedDate);
      if (_endDate.isBefore(_startDate)) {
        _endDate = _startDate;
      }
    });
  }

  Future<void> _pickEndDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime(2100),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() {
      _endDate = DateUtils.dateOnly(pickedDate);
    });
  }

  Future<void> _saveTrip() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    if (_endDate.isBefore(_startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.createTripDateInvalid)),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final trip = Trip.create(
      id: 'trip-${DateTime.now().microsecondsSinceEpoch}',
      title: _tripNameController.text,
      country: _countryController.text,
      startDate: _startDate,
      endDate: _endDate,
      createdAt: DateTime.now(),
    );

    await widget.tripRepository.saveTrip(trip);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(AppStrings.createTripSaved)));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) {
          return TripDashboardScreen(
            tripName: trip.title,
            country: trip.country,
            startDate: trip.startDate,
            endDate: trip.endDate,
          );
        },
      ),
    );
  }
}

class _DatePickerRow extends StatelessWidget {
  const _DatePickerRow({
    required this.startDate,
    required this.endDate,
    required this.onPickStartDate,
    required this.onPickEndDate,
  });

  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DatePickerCard(
            label: AppStrings.createTripStartDate,
            date: startDate,
            onPressed: onPickStartDate,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _DatePickerCard(
            label: AppStrings.createTripEndDate,
            date: endDate,
            onPressed: onPickEndDate,
          ),
        ),
      ],
    );
  }
}

class _DatePickerCard extends StatelessWidget {
  const _DatePickerCard({
    required this.label,
    required this.date,
    required this.onPressed,
  });

  final String label;
  final DateTime date;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(AppSpacing.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.labelSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _formatDate(date),
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }
}

class _CoverPhotoPlaceholder extends StatelessWidget {
  const _CoverPhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  color: colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.createTripCoverTitle,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppStrings.createTripCoverSubtitle,
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
