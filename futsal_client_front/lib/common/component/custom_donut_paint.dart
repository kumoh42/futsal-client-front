import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';

class CustomDonutPainter extends CustomPainter {
  final bool isLast;

  const CustomDonutPainter({this.isLast = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = kMainColor // 도넛의 색상 설정
      ..style = PaintingStyle.fill; // 도넛 내부를 채움

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY); // 도넛의 반지름
    final double ringRadius = radius * 2 / 3; // 도넛 중심 원의 반지름
    final double rectangleWidth = radius / 3; // 직사각형의 가로 길이
    final double rectangleHeight = size.height; // 직사각형의 세로 길이

    if (!isLast) {
      // 직사각형 그리기
      paint.color = kMainColor; // 직사각형의 색상 설정
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, centerY + radius + rectangleHeight / 2),
          width: rectangleWidth,
          height: rectangleHeight,
        ),
        paint,
      );
    }

    // 바깥 원
    paint.color = kMainColor; // 도넛의 색상 설정
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // 내부 원 (중심 원)
    paint.color = Colors.white; // 중심 원의 색상 설정
    canvas.drawCircle(Offset(centerX, centerY), ringRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
