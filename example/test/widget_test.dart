import 'package:flutter_test/flutter_test.dart';

import 'package:easy_bubble_container_example/main.dart';

void main() {
  testWidgets('example app renders bubble variants', (WidgetTester tester) async {
    await tester.pumpWidget(const EasyBubbleExampleApp());

    expect(find.text('Easy Bubble Container Example'), findsOneWidget);
    expect(find.text('Top Arrow'), findsOneWidget);
    expect(find.text('With Border'), findsOneWidget);
  });
}
