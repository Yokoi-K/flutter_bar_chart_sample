import 'package:flutter/material.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart_x_axis.dart';

class ChartYAxis extends StatelessWidget {
  const ChartYAxis({
    Key? key,
  }) : super(key: key);

  static const scaleTextWidth = 40.0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: CustomPaint(
        painter: _YAxisPainter(),
      ),
    );
  }
}

class _YAxisPainter extends CustomPainter {
  const _YAxisPainter();

  static const _textMarginTop = 8;
  static const _scaleCount = 5;
  static const _scaleTextLeftMargin = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter makeTextPainter(int i) {
      return TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 12),
          text: i.toString(),
        ),
      )..layout();
    }

    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 2;

    final yAxisHeight = size.height - ChartXAxis.scaleTextHeight;
    final yAxisWidth = size.width - ChartYAxis.scaleTextWidth;
    final yAxisScaleMarginTop = yAxisHeight / _scaleCount;

    paint.strokeWidth = 1;
    for (var i = 0; i <= _scaleCount; i++) {
      // ボーダー
      final y = yAxisScaleMarginTop * i;
      canvas.drawLine(Offset(0, y), Offset(yAxisWidth, y), paint);

      // テキスト
      final scale = yAxisHeight - yAxisScaleMarginTop * i;
      makeTextPainter(scale.toInt()).paint(
        canvas,
        Offset(yAxisWidth + _scaleTextLeftMargin, y - _textMarginTop),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
