const BubbleContainer({
  Key? key,
  required Widget child,
  double arrowSize = 12,
  double borderRadius = 12,
  double arrowRadius = 0,
  Color color = Colors.white,
  Color borderColor = Colors.black,
  double borderWidth = 0,
  BubbleSide side = BubbleSide.bottom,
  double arrowPosition = 0,
  EdgeInsets padding = const EdgeInsets.all(8),
})

enum BubbleSide {
  top,
  bottom,
  left,
  right,
}

BubbleContainer(
  color: Colors.blue.shade100,
  side: BubbleSide.left,
  arrowPosition: 0.3,
  borderRadius: 10,
  arrowRadius: 4,
  padding: const EdgeInsets.all(12),
  child: const Text('Hello there! 👋'),
)
