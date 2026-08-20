import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/app/travel_journal_app.dart';
import 'package:travel_journal/src/core/constants/app_strings.dart';

void main() {
  testWidgets('shows splash screen before welcome', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TravelJournalApp());

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.loading), findsOneWidget);
  });

  testWidgets('opens welcome screen after splash', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelJournalApp());
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.welcomeTitle), findsOneWidget);
    expect(find.text(AppStrings.welcomeSubtitle), findsOneWidget);
    expect(find.text(AppStrings.welcomePrimaryAction), findsOneWidget);
    expect(find.text(AppStrings.welcomeSecondaryAction), findsOneWidget);
  });

  testWidgets('opens home screen from welcome', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelJournalApp());
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.welcomePrimaryAction));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.homeTitle), findsOneWidget);
    expect(find.text(AppStrings.homeEmptyTitle), findsOneWidget);
    expect(find.text(AppStrings.homeCreateTrip), findsWidgets);
    expect(find.text(AppStrings.homeQuickActions), findsOneWidget);
  });
}
