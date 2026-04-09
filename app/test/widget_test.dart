import 'package:flutter_test/flutter_test.dart';

import 'package:shanli_drama/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the app builds without error
    expect(find.byType(App), findsOneWidget);
  });
}
