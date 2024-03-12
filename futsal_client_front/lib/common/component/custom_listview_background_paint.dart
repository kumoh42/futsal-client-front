import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';

class CustomListViewBackgroundPaint extends CustomPainter {
  final Color? color;
  const CustomListViewBackgroundPaint({
    this.color = kMainColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 30, size.height / 2); // 시작점 설정
    path.lineTo(size.width / 10 * 1, size.height / 10 * 6.5);
    path.lineTo(size.width / 10 * 1, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 10 * 1, 0);
    path.lineTo(size.width / 10 * 1, size.height / 10 * 3.5);
    path.lineTo(size.width / 30, size.height / 2);

    path.close(); // 경로 닫기
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
