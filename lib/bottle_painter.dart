import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottlePainter extends CustomPainter {
  const BottlePainter({ required this.waterHeightFraction});
  final double waterHeightFraction;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style= PaintingStyle.fill;
    
    double neckHeight = size.height*0.2;
    double bodyHeight = size.height*0.8;
    double bottleNeckWidth = size.width/2;
    double bottleBodyWidth = size.width;
    
    paint.color = Colors.white;

    ///Bottle cap
    canvas.drawRRect( RRect.fromRectAndCorners(
      Rect.fromLTRB(
        (size.width - bottleNeckWidth) / 2,
        size.height - bodyHeight - neckHeight,
        (size.width + bottleNeckWidth) / 2,
        size.height - (bodyHeight - 20),
      ),
        topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),

    ),
      paint,
    );
  ///Bottle body canvas
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTRB(
          (size.width - bottleBodyWidth) / 2,
          size.height - bodyHeight,
          (size.width + bottleBodyWidth) / 2,
          size.height,
        ),
        topLeft: Radius.circular(size.width * 0.3),
        topRight: Radius.circular(size.width * 0.3),
        bottomLeft: Radius.circular(size.width * 0.1),
        bottomRight: Radius.circular(size.width * 0.1),
      ),
      paint,
    );
  ///Water color
    paint.color = Colors.blue;

    ///water height
    double waterHeight = size.height * waterHeightFraction;
    double waterTop = size.height - waterHeight;

    if (waterHeightFraction >= 0.79) {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(
            (size.width - bottleNeckWidth) / 2,
            size.height - bodyHeight - neckHeight + (waterTop * 1.5),
            (size.width + bottleNeckWidth) / 2,
            size.height - (bodyHeight - 20),
          ),
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(
            (size.width - bottleBodyWidth) / 2,
            size.height * 0.2,
            (size.width + bottleBodyWidth) / 2,
            size.height,
          ),
          topLeft: Radius.circular(size.width * 0.3),
          topRight: Radius.circular(size.width * 0.3),
          bottomLeft: Radius.circular(size.width * 0.1),
          bottomRight: Radius.circular(size.width * 0.1),
        ),
        paint,
      );
    }
    else {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(
            (size.width - bottleBodyWidth) / 2,
            waterTop,
            (size.width + bottleBodyWidth) / 2,
            size.height,
          ),
          topLeft: waterHeightFraction >= 0.79
              ? Radius.circular(size.width * 0.3)
              : Radius.zero,
          topRight: waterHeightFraction >= 0.79
              ? Radius.circular(size.width * 0.3)
              : Radius.zero,
          bottomLeft: Radius.circular(size.width * 0.1),
          bottomRight: Radius.circular(size.width * 0.1),
        ),
        paint,
      );
    }
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
