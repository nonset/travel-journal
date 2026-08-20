import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../core/database/app_database.dart';
import '../core/theme/app_theme.dart';
import '../features/trip_management/data/repositories/drift_trip_repository.dart';
import '../features/trip_management/domain/repositories/trip_repository.dart';
import '../features/app_entry/presentation/screens/splash_screen.dart';

class TravelJournalApp extends StatefulWidget {
  const TravelJournalApp({super.key, this.tripRepository});

  final TripRepository? tripRepository;

  @override
  State<TravelJournalApp> createState() => _TravelJournalAppState();
}

class _TravelJournalAppState extends State<TravelJournalApp> {
  AppDatabase? _database;
  late final TripRepository _tripRepository;

  @override
  void initState() {
    super.initState();
    final providedRepository = widget.tripRepository;
    if (providedRepository != null) {
      _tripRepository = providedRepository;
      return;
    }

    final database = AppDatabase();
    _database = database;
    _tripRepository = DriftTripRepository(database);
  }

  @override
  void dispose() {
    _database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: SplashScreen(tripRepository: _tripRepository),
    );
  }
}
