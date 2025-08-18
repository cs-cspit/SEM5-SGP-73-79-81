import 'package:flutter_test/flutter_test.dart';
import 'package:sediment_learner/app.dart'; // Import your app

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App()); // Use your App class
  });
}
