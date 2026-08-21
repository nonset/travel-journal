import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/app/travel_journal_app.dart';
import 'package:travel_journal/src/core/constants/app_strings.dart';
import 'package:travel_journal/src/features/expense_tracking/data/repositories/in_memory_expense_repository.dart';
import 'package:travel_journal/src/features/expense_tracking/domain/models/expense.dart';
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

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.tripDashboardNoActivity), findsOneWidget);

    final trips = await repository.getTrips();
    expect(trips, hasLength(1));
    expect(trips.single.title, 'Taiwan Beta Trip 2026');
    expect(trips.single.country, 'Taiwan');
  });

  testWidgets('opens locally saved trips from home', (
    WidgetTester tester,
  ) async {
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

    await tester.tap(find.text('Taiwan Beta Trip 2026'));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.tripDashboardTitle), findsOneWidget);
    expect(find.text('Taiwan Beta Trip 2026'), findsOneWidget);
    expect(find.text('Taiwan'), findsOneWidget);
    expect(find.text('2026-10-05 - 2026-10-08'), findsOneWidget);
    expect(find.text(AppStrings.tripDashboardQuickActions), findsOneWidget);
  });

  testWidgets('saves add expense from trip dashboard', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    final tripRepository = InMemoryTripRepository();
    final expenseRepository = InMemoryExpenseRepository();

    await tester.pumpWidget(
      TravelJournalApp(
        tripRepository: tripRepository,
        expenseRepository: expenseRepository,
      ),
    );
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

    await tester.drag(find.byType(ListView), const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.tripDashboardAddExpense));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.addExpenseTitle), findsWidgets);
    expect(find.text('Taiwan Beta Trip 2026'), findsOneWidget);
    expect(find.text(AppStrings.addExpenseAmountLabel), findsOneWidget);
    expect(find.text(AppStrings.addExpenseCategoryLabel), findsOneWidget);
    expect(find.text(AppStrings.addExpensePaymentMethodLabel), findsOneWidget);

    await tester.enterText(
      find.bySemanticsLabel(AppStrings.addExpenseAmountLabel),
      '245.75',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.addExpenseCurrencyLabel), findsOneWidget);
    expect(find.text(AppStrings.addExpenseDateLabel), findsOneWidget);
    expect(find.text(AppStrings.addExpenseNoteLabel), findsOneWidget);
    expect(find.text(AppStrings.addExpenseSave), findsOneWidget);

    final saveExpenseButton = find.widgetWithText(
      FilledButton,
      AppStrings.addExpenseSave,
    );
    await tester.ensureVisible(saveExpenseButton);
    await tester.pumpAndSettle();
    await tester.tap(saveExpenseButton);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.tripDashboardTitle), findsOneWidget);

    final trips = await tripRepository.getTrips();
    final expenses = await expenseRepository.getExpensesForTrip(
      trips.single.id,
    );
    expect(expenses, hasLength(1));
    expect(expenses.single.tripId, trips.single.id);
    expect(expenses.single.amount, 245.75);
    expect(expenses.single.currency, 'THB');
    expect(expenses.single.category, ExpenseCategory.food);
  });
}

TravelJournalApp _buildTestApp() {
  return TravelJournalApp(tripRepository: InMemoryTripRepository());
}
