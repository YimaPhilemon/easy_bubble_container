# 🧩 API Reference

## `BubbleContainer`

A customizable chat-style container widget that draws a rounded rectangle with an optional directional arrow.

Useful for chat bubbles, tooltips, or message UI elements.

---

### **Constructor**

```dart
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

Parameters
Parameter	Type	Default	Description
child	Widget	—	The widget inside the bubble.
arrowSize	double	12	Size of the arrow in logical pixels.
borderRadius	double	12	Radius of the bubble corners.
arrowRadius	double	0	Corner radius for the arrow tip.
color	Color	Colors.white	Background color of the bubble.
borderColor	Color	Colors.black	Border color of the bubble.
borderWidth	double	0	Border width in logical pixels.
side	BubbleSide	BubbleSide.bottom	Position of the arrow (top, bottom, left, right).
arrowPosition	double	0	Arrow offset position (0.0–1.0).
padding	EdgeInsets	EdgeInsets.all(8)	Inner padding for the child widget.
Enum: BubbleSide
enum BubbleSide {
  top,
  bottom,
  left,
  right,
}


Defines which side the arrow appears on.

Example Usage
BubbleContainer(
  color: Colors.blue.shade100,
  side: BubbleSide.left,
  arrowPosition: 0.3,
  borderRadius: 10,
  arrowRadius: 4,
  padding: const EdgeInsets.all(12),
  child: const Text('Hello there! 👋'),
)

💡 Tip

You can combine BubbleContainer with Row, Column, or Wrap to create chat layouts, tooltips, or speech bubbles for avatars.


---

✅ This version is **fully compliant** with pub.dev formatting — no image links, clean markdown tables, and formatted code blocks.  

Would you like me to also make a **matching `README.md`** that links to this API reference and includes a sample runnable example for Android and Windows?
