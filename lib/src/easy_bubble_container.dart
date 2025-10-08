import 'package:flutter/material.dart';

enum BubbleSide { top, bottom, left, right }

class BubbleContainer extends StatelessWidget {
  final Widget child;
  final double arrowSize;
  final double borderRadius;
  final double arrowRadius;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final BubbleSide side;
  final double arrowPosition; // 0.0 - 1.0
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

class _BubblePainter extends CustomPainter {
  final double arrowSize;
  final double borderRadius;
  final double arrowRadius; // Using your existing parameter name
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

    final arrowPos = arrowPosition.clamp(0.0, 1.0);

    double left = borderWidth / 2;
    double top = borderWidth / 2;
    double right = size.width - borderWidth / 2;
    double bottom = size.height - borderWidth / 2;

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

    canvas.drawPath(path, paint);

    if (borderWidth > 0) {
      final borderPaint =
          Paint()
            ..color = borderColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
      canvas.drawPath(path, borderPaint);
    }
  }

  double _calculateHorizontalArrowX(double l, double r, double pos) {
    final minX = l + borderRadius + arrowSize;
    final maxX = r - borderRadius - arrowSize;
    final availableLength = maxX - minX;
    if (availableLength <= 0) return (minX + maxX) / 2;
    return minX + availableLength * pos;
  }

  double _calculateVerticalArrowY(double t, double b, double pos) {
    final minY = t + borderRadius + arrowSize;
    final maxY = b - borderRadius - arrowSize;
    final availableLength = maxY - minY;
    if (availableLength <= 0) return (minY + maxY) / 2;
    return minY + availableLength * pos;
  }

  // NOTE: Removed _drawRoundedArrow as it caused complex geometry issues.
  // We use direct lineTo/arcToPoint logic in the builders.

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
    final arcR = arrowRadius.clamp(0.0, arrowSize); // Clamp radius to arrowSize

    path.moveTo(l + borderRadius, bodyTop);
    path.lineTo(arrowX - arrowSize, bodyTop);

    // Rounded Tip Logic
    path.lineTo(arrowX - arcR, t + arcR);
    path.arcToPoint(
      Offset(arrowX + arcR, t + arcR),
      radius: Radius.circular(arcR),
      clockwise: true,
    );
    path.lineTo(arrowX + arrowSize, bodyTop);

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

    // Mirror vertically around the midline between top and bottom
    final matrix =
        Matrix4.identity()
          ..translate(0.0, t + (b - t))
          ..scale(1.0, -1.0);
    path.addPath(temp.transform(matrix.storage), Offset.zero);
  }

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

    // Rounded Tip Logic
    path.lineTo(l + arcR, arrowY + arcR);
    path.arcToPoint(
      Offset(l + arcR, arrowY - arcR),
      radius: Radius.circular(arcR),
      clockwise: false,
    );
    path.lineTo(bodyLeft, arrowY - arrowSize);

    path.lineTo(bodyLeft, t + borderRadius);
    path.arcToPoint(
      Offset(bodyLeft + borderRadius, t),
      radius: Radius.circular(borderRadius),
    );
    path.close();
  }

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

    // --- Mirror the left arrow horizontally around the center of the rect ---
    final matrix =
        Matrix4.identity()
          ..translate(l + (r - l))
          ..scale(-1.0, 1.0);
    path.addPath(temp.transform(matrix.storage), Offset.zero);
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) => true;
}
