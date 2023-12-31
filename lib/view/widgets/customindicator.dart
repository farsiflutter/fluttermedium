import 'package:flutter/material.dart';

class CustomIndicator extends Decoration {
  final Color color;
  final double radius;
  const CustomIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CustomPaint(color: color, radius: radius);
  }
}

class CustomPaint extends BoxPainter {
  final Color color;
  final double radius;
  CustomPaint({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var paint = Paint()..color = color;
    var c = offset +
        Offset(configuration.size!.width / 2, configuration.size!.height / 1.2);
    canvas.drawCircle(c, radius, paint);
  }
}
