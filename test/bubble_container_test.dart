import 'package:easy_bubble_container/easy_bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BubbleContainer', () {
    testWidgets('paints with default arrowRadius on every side', (
      WidgetTester tester,
    ) async {
      for (final side in BubbleSide.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: BubbleContainer(
                  side: side,
                  child: const Text('Hello'),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(BubbleContainer), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('adds arrow padding on the selected side', (
      WidgetTester tester,
    ) async {
      const arrowSize = 14.0;
      const basePadding = EdgeInsets.all(8);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BubbleContainer(
              side: BubbleSide.right,
              arrowSize: arrowSize,
              padding: basePadding,
              child: SizedBox(width: 20, height: 10),
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.descendant(
          of: find.byType(BubbleContainer),
          matching: find.byType(Padding),
        ),
      );

      expect(
        paddingWidget.padding,
        const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 8,
          right: 8 + arrowSize,
        ),
      );
    });

    testWidgets('reuses the painter configuration when inputs are unchanged', (
      WidgetTester tester,
    ) async {
      Widget buildSubject() {
        return const MaterialApp(
          home: Scaffold(
            body: BubbleContainer(
              side: BubbleSide.left,
              arrowPosition: 0.5,
              arrowRadius: 4,
              borderWidth: 1,
              child: Text('Stable'),
            ),
          ),
        );
      }

      await tester.pumpWidget(buildSubject());
      final renderObject = tester.renderObject(find.byType(CustomPaint))
          as RenderCustomPaint;
      final dynamic painter = renderObject.painter!;

      expect(painter.shouldRepaint(painter), isFalse);

      await tester.pumpWidget(buildSubject());
      final updatedRenderObject = tester.renderObject(find.byType(CustomPaint))
          as RenderCustomPaint;
      final dynamic updatedPainter = updatedRenderObject.painter!;

      expect(updatedPainter.shouldRepaint(painter), isFalse);
    });
  });
}
