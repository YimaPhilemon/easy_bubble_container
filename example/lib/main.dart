import 'package:easy_bubble_container/bubble_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EasyBubbleExampleApp());
}

class EasyBubbleExampleApp extends StatelessWidget {
  const EasyBubbleExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Bubble Container Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final examples = [
      _ExampleItem(
        label: 'Top Arrow',
        side: BubbleSide.top,
        color: Colors.lightBlue.shade50,
      ),
      _ExampleItem(
        label: 'Bottom Arrow',
        side: BubbleSide.bottom,
        color: Colors.green.shade50,
      ),
      _ExampleItem(
        label: 'Left Arrow',
        side: BubbleSide.left,
        color: Colors.purple.shade50,
      ),
      _ExampleItem(
        label: 'Right Arrow',
        side: BubbleSide.right,
        color: Colors.orange.shade50,
      ),
      _ExampleItem(
        label: 'Custom Arrow Position',
        side: BubbleSide.bottom,
        arrowPosition: 0.8,
        color: Colors.pink.shade50,
      ),
      _ExampleItem(
        label: 'With Border',
        side: BubbleSide.left,
        borderColor: Colors.black54,
        borderWidth: 2,
        color: Colors.white,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Easy Bubble Container Example')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: examples.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, i) => examples[i],
      ),
    );
  }
}

class _ExampleItem extends StatelessWidget {
  final String label;
  final BubbleSide side;
  final double? arrowPosition;
  final Color color;
  final Color? borderColor;
  final double? borderWidth;

  const _ExampleItem({
    required this.label,
    required this.side,
    required this.color,
    this.arrowPosition,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: BubbleContainer(
        side: side,
        color: color,
        borderColor: borderColor ?? Colors.transparent,
        borderWidth: borderWidth ?? 0,
        arrowSize: 14,
        arrowPosition: arrowPosition ?? 0.5,
        borderRadius: 12,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
