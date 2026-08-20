import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/app/travel_journal_app.dart';
import 'package:travel_journal/src/core/constants/app_strings.dart';
import 'package:travel_journal/src/features/trip_management/data/repositories/in_memory_trip_repository.dart';
import 'package:travel_journal/src/features/trip_management/domain/models/trip.dart';

void main() {
  testWidgets('shows splash screen before welcome', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.loading), findsOneWidget);
  });

  testWidgets('opens welcome screen after splash', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.welcomeTitle), findsOneWidget);
    expect(find.text(AppStrings.welcomeSubtitle), findsOneWidget);
    expect(find.text(AppStrings.welcomePrimaryAction), findsOneWidget);
    expect(find.text(AppStrings.welcomeSecondaryAction), findsOneWidget);
  });

  testWidgets('opens home screen from welcome', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.welcomePrimaryAction));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.homeTitle), findsOneWidget);
    expect(find.text(AppStrings.homeEmptyTitle), findsOneWidget);
    expect(find.text(AppStrings.homeCreateTrip), findsWidgets);
    expect(find.text(AppStrings.homeQuickActions), findsOneWidget);
  });

  testWidgets('opens create trip screen from home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.welcomePrimaryAction));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.homeCreateTrip).first);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.createTripTitle), findsWidgets);
    expect(find.text(AppStrings.createTripNameLabel), findsOneWidget);
    expect(find.text(AppStrings.createTripCountryLabel), findsOneWidget);
    expect(find.text(AppStrings.createTripSave), findsOneWidget);
  });

  testWidgets('validates required create trip fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.welcomePrimaryAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.homeCreateTrip).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.createTripSave));
    await tester.pump();

    expect(find.text(AppStrings.createTripNameRequired), findsOneWidget);
    expect(find.text(AppStrings.createTripCountryRequired), findsOneWidget);
  });

  testWidgets('opens trip dashboard after creating a trip', (
    WidgetTester tester,
  ) async {
    final repository = InMemoryTripRepository();

    await tester.pumpWidget(TravelJournalApp(tripRepository: repository));
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.welcomePrimaryAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.homeCreateTrip).first);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.bySemanticsLabel(AppStrings.createTripNameLabel),
      'Taiwan Beta Trip 2026',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppStrings.createTripCountryLabel),
      'Taiwan',
    );
    await tester.tap(find.text(AppStrings.createTripSave));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.tripDashboardTitle), findsOneWidget);
    expect(find.text('Taiwan Beta Trip 2026'), findsOneWidget);
    expect(find.text('Taiwan'), findsOneWidget);
    expect(find.text(AppStrings.tripDashboardQuickActions), findsOneWidget);
    expect(find.text(AppStrings.tripDashboardAddExpense), findsOneWidget);

    await tester.drag(find.byType(Scrollable), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.tripDashboardNoActivity), findsOneWidget);

    final trips = await repository.getTrips();
    expect(trips, hasLength(1));
    expect(trips.single.title, 'Taiwan Beta Trip 2026');
    expect(trips.single.country, 'Taiwan');
  });

  testWidgets('shows locally saved trips on home', (WidgetTester tester) async {
    final repository = InMemoryTripRepository(
      initialTrips: [
        Trip.create(
          id: 'trip-1',
          title: 'Taiwan Beta Trip 2026',
          country: 'Taiwan',
          startDate: DateTime(2026, 10, 5),
          endDate: DateTime(2026, 10, 8),
          createdAt: DateTime(2026, 8, 20),
        ),
      ],
    );

    await tester.pumpWidget(TravelJournalApp(tripRepository: repository));
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.welcomePrimaryAction));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Scrollable), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.homeRecentTrips), findsOneWidget);
    expect(find.text('Taiwan Beta Trip 2026'), findsOneWidget);
    expect(find.textContaining('Taiwan - 2026-10-05'), findsOneWidget);
    expect(find.text(AppStrings.homeTripStatus), findsOneWidget);
  });
}

TravelJournalApp _buildTestApp() {
  return TravelJournalApp(tripRepository: InMemoryTripRepository());
}
