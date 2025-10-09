import 'package:flutter/material.dart';

/// Defines which side of the bubble the arrow will appear on.
enum BubbleSide { top, bottom, left, right }

/// A customizable chat-style container widget that draws a rounded
/// rectangle with an optional directional arrow.
///
/// Useful for chat messages, tooltips, or callouts.
///
/// Example:
/// ```dart
/// BubbleContainer(
///   color: Colors.blue[100]!,
///   side: BubbleSide.left,
///   arrowPosition: 0.5,
///   child: Text("Hello there!"),
/// )
/// ```
class BubbleContainer extends StatelessWidget {
  /// The widget displayed inside the bubble.
  final Widget child;

  /// The size (length) of the triangular arrow.
  final double arrowSize;

  /// The corner radius of the rounded rectangle.
  final double borderRadius;

  /// The curvature of the arrow tip (rounded edges).
  final double arrowRadius;

  /// The background color of the bubble.
  final Color color;

  /// The color of the bubble border.
  final Color borderColor;

  /// The width of the border stroke.
  final double borderWidth;

  /// The side where the arrow should appear.
  final BubbleSide side;

  /// The arrow’s relative position along its side (0.0 = start, 1.0 = end).
  final double arrowPosition;

  /// Internal padding around the [child].
  final EdgeInsets padding;

  const BubbleContainer({
    super.key,
    required this.child,
    this.arrowSize = 12,
    this.borderRadius = 12,
    this.arrowRadius = 0,
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 0,
    this.side = BubbleSide.bottom,
    this.arrowPosition = 0,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(
        arrowSize: arrowSize,
        borderRadius: borderRadius,
        arrowRadius: arrowRadius,
        color: color,
        borderColor: borderColor,
        borderWidth: borderWidth,
        side: side,
        arrowPosition: arrowPosition,
      ),
      // Adjust padding so child is not covered by the arrow
      child: Padding(
        padding: EdgeInsets.only(
          top: padding.top + (side == BubbleSide.top ? arrowSize : 0),
          bottom: padding.bottom + (side == BubbleSide.bottom ? arrowSize : 0),
          left: padding.left + (side == BubbleSide.left ? arrowSize : 0),
          right: padding.right + (side == BubbleSide.right ? arrowSize : 0),
        ),
        child: child,
      ),
    );
  }
}

/// Handles drawing of the bubble shape, including the rounded rectangle
/// and directional arrow.
class _BubblePainter extends CustomPainter {
  final double arrowSize;
  final double borderRadius;
  final double arrowRadius;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final BubbleSide side;
  final double arrowPosition;

  _BubblePainter({
    required this.arrowSize,
    required this.borderRadius,
    required this.arrowRadius,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.side,
    required this.arrowPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Clamp the arrow position between 0 and 1
    final arrowPos = arrowPosition.clamp(0.0, 1.0);

    // Define the drawable bounds (accounting for border width)
    double left = borderWidth / 2;
    double top = borderWidth / 2;
    double right = size.width - borderWidth / 2;
    double bottom = size.height - borderWidth / 2;

    // Draw bubble shape based on which side the arrow should appear
    switch (side) {
      case BubbleSide.top:
        _buildTopArrow(path, left, top, right, bottom, arrowPos);
        break;
      case BubbleSide.bottom:
        _buildBottomArrow(path, left, top, right, bottom, arrowPos);
        break;
      case BubbleSide.left:
        _buildLeftArrow(path, left, top, right, bottom, arrowPos);
        break;
      case BubbleSide.right:
        _buildRightArrow(path, left, top, right, bottom, arrowPos);
        break;
    }

    // Fill the bubble background
    canvas.drawPath(path, paint);

    // Draw the border if specified
    if (borderWidth > 0) {
      final borderPaint =
          Paint()
            ..color = borderColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
      canvas.drawPath(path, borderPaint);
    }
  }

  /// Calculates the X position for horizontally aligned arrows.
  double _calculateHorizontalArrowX(double l, double r, double pos) {
    final minX = l + borderRadius + arrowSize;
    final maxX = r - borderRadius - arrowSize;
    final availableLength = maxX - minX;
    if (availableLength <= 0) return (minX + maxX) / 2;
    return minX + availableLength * pos;
  }

  /// Calculates the Y position for vertically aligned arrows.
  double _calculateVerticalArrowY(double t, double b, double pos) {
    final minY = t + borderRadius + arrowSize;
    final maxY = b - borderRadius - arrowSize;
    final availableLength = maxY - minY;
    if (availableLength <= 0) return (minY + maxY) / 2;
    return minY + availableLength * pos;
  }

  /// Builds a bubble with an arrow on the top.
  void _buildTopArrow(
    Path path,
    double l,
    double t,
    double r,
    double b,
    double pos,
  ) {
    final bodyTop = t + arrowSize;
    final arrowX = _calculateHorizontalArrowX(l, r, pos);
    final arcR = arrowRadius.clamp(0.0, arrowSize);

    // Start bottom-left of the top arc
    path.moveTo(l + borderRadius, bodyTop);
    path.lineTo(arrowX - arrowSize, bodyTop);

    // Draw arrow tip
    path.lineTo(arrowX - arcR, t + arcR);
    path.arcToPoint(
      Offset(arrowX + arcR, t + arcR),
      radius: Radius.circular(arcR),
      clockwise: true,
    );
    path.lineTo(arrowX + arrowSize, bodyTop);

    // Continue drawing rounded rectangle
    path.lineTo(r - borderRadius, bodyTop);
    path.arcToPoint(
      Offset(r, bodyTop + borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(r, b - borderRadius);
    path.arcToPoint(
      Offset(r - borderRadius, b),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(l + borderRadius, b);
    path.arcToPoint(
      Offset(l, b - borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(l, bodyTop + borderRadius);
    path.arcToPoint(
      Offset(l + borderRadius, bodyTop),
      radius: Radius.circular(borderRadius),
    );
    path.close();
  }

  /// Builds a bubble with an arrow on the bottom.
  void _buildBottomArrow(
    Path path,
    double l,
    double t,
    double r,
    double b,
    double pos,
  ) {
    final temp = Path();
    final arrowCenterX = _calculateHorizontalArrowX(l, r, pos);
    final arcR = arrowRadius.clamp(0.0, arrowSize);
    final bodyTop = t + arrowSize;

    // Draw rectangle body and top arc
    temp.moveTo(l + borderRadius, b);
    temp.arcToPoint(
      Offset(l, b - borderRadius),
      radius: Radius.circular(borderRadius),
    );
    temp.lineTo(l, bodyTop + borderRadius);
    temp.arcToPoint(
      Offset(l + borderRadius, bodyTop),
      radius: Radius.circular(borderRadius),
    );

    // Draw arrow shape
    temp.lineTo(arrowCenterX - arrowSize, bodyTop);
    if (arcR > 0) {
      temp.arcToPoint(
        Offset(arrowCenterX - arcR, t + arcR),
        radius: Radius.circular(arcR),
        clockwise: false,
      );
    }
    temp.lineTo(arrowCenterX, t);
    if (arcR > 0) {
      temp.arcToPoint(
        Offset(arrowCenterX + arcR, t + arcR),
        radius: Radius.circular(arcR),
        clockwise: false,
      );
    }
    temp.lineTo(arrowCenterX + arrowSize, bodyTop);

    // Complete rectangle path
    temp.lineTo(r - borderRadius, bodyTop);
    temp.arcToPoint(
      Offset(r, bodyTop + borderRadius),
      radius: Radius.circular(borderRadius),
    );
    temp.lineTo(r, b - borderRadius);
    temp.arcToPoint(
      Offset(r - borderRadius, b),
      radius: Radius.circular(borderRadius),
    );
    temp.close();

    // Mirror vertically to make the arrow point downward
    final matrix =
        Matrix4.identity()
          ..translate(0.0, t + (b - t))
          ..scale(1.0, -1.0);
    path.addPath(temp.transform(matrix.storage), Offset.zero);
  }

  /// Builds a bubble with an arrow on the left side.
  void _buildLeftArrow(
    Path path,
    double l,
    double t,
    double r,
    double b,
    double pos,
  ) {
    final bodyLeft = l + arrowSize;
    final arrowY = _calculateVerticalArrowY(t, b, pos);
    final arcR = arrowRadius.clamp(0.0, arrowSize);

    path.moveTo(r - borderRadius, t);
    path.arcToPoint(
      Offset(r, t + borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(r, b - borderRadius);
    path.arcToPoint(
      Offset(r - borderRadius, b),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(bodyLeft + borderRadius, b);
    path.arcToPoint(
      Offset(bodyLeft, b - borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(bodyLeft, arrowY + arrowSize);

    // Draw rounded arrow tip
    path.lineTo(l + arcR, arrowY + arcR);
    path.arcToPoint(
      Offset(l + arcR, arrowY - arcR),
      radius: Radius.circular(arcR),
      clockwise: false,
    );
    path.lineTo(bodyLeft, arrowY - arrowSize);

    // Close top-left corner
    path.lineTo(bodyLeft, t + borderRadius);
    path.arcToPoint(
      Offset(bodyLeft + borderRadius, t),
      radius: Radius.circular(borderRadius),
    );
    path.close();
  }

  /// Builds a bubble with an arrow on the right side.
  void _buildRightArrow(
    Path path,
    double l,
    double t,
    double r,
    double b,
    double pos,
  ) {
    final temp = Path();
    final arrowCenterY = _calculateVerticalArrowY(t, b, pos);
    final arcR = arrowRadius.clamp(0.0, arrowSize);
    final bodyLeft = l + arrowSize;

    // Build path similar to left arrow
    temp.moveTo(r - borderRadius, t);
    temp.arcToPoint(
      Offset(r, t + borderRadius),
      radius: Radius.circular(borderRadius),
    );
    temp.lineTo(r, b - borderRadius);
    temp.arcToPoint(
      Offset(r - borderRadius, b),
      radius: Radius.circular(borderRadius),
    );
    temp.lineTo(bodyLeft + borderRadius, b);
    temp.arcToPoint(
      Offset(bodyLeft, b - borderRadius),
      radius: Radius.circular(borderRadius),
    );
    temp.lineTo(bodyLeft, arrowCenterY + arrowSize);

    // Rounded arrow tip
    if (arcR > 0) {
      temp.arcToPoint(
        Offset(bodyLeft - arcR, arrowCenterY + arrowSize - arcR),
        radius: Radius.circular(arcR),
        clockwise: false,
      );
    }
    temp.lineTo(l, arrowCenterY);
    if (arcR > 0) {
      temp.arcToPoint(
        Offset(bodyLeft - arcR, arrowCenterY - arrowSize + arcR),
        radius: Radius.circular(arcR),
        clockwise: false,
      );
    } else {
      temp.lineTo(bodyLeft, arrowCenterY - arrowSize);
    }

    temp.lineTo(bodyLeft, t + borderRadius);
    temp.arcToPoint(
      Offset(bodyLeft + borderRadius, t),
      radius: Radius.circular(borderRadius),
    );
    temp.close();

    // Mirror horizontally so the arrow points right
    final matrix =
        Matrix4.identity()
          ..translate(l + (r - l))
          ..scale(-1.0, 1.0);
    path.addPath(temp.transform(matrix.storage), Offset.zero);
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) => true;
}
