import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/app/travel_journal_app.dart';
import 'package:travel_journal/src/core/constants/app_strings.dart';

void main() {
  testWidgets('shows foundation placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelJournalApp());

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.appTagline), findsOneWidget);
    expect(find.text(AppStrings.foundationReady), findsOneWidget);
    expect(find.text(AppStrings.nextStep), findsOneWidget);
  });
}
