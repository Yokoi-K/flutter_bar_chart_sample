import 'package:flutter/material.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart_y_axis.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/model/bar_chart_item.dart';

class ChartXAxis extends StatelessWidget {
  const ChartXAxis({
    Key? key,
    required this.barChartItems,
  }) : super(key: key);

  static const scaleTextHeight = 40.0;

  final List<BarChartItem> barChartItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _XAxisPainter(
          barChartItems: barChartItems,
        ),
      ),
    );
  }
}

class _XAxisPainter extends CustomPainter {
  const _XAxisPainter({
    required this.barChartItems,
  });

  static const _scaleTextLeftMargin = 2.0;
  static const _dividedCount = 5;

  final List<BarChartItem> barChartItems;

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
      ..strokeWidth = 1;

    final xAxisWidth = size.width - ChartYAxis.scaleTextWidth;
    final barWidth = xAxisWidth / barChartItems.length;

    final threshold = barChartItems.length ~/ _dividedCount;

    for (var i = 0; i < barChartItems.length; i++) {
      if (i != 0 && i % threshold != 0) {
        continue;
      }

      final x = barWidth * i;
      final textPainter = makeTextPainter(i);
      final textY = size.height - textPainter.height;

      // ボーダー
      canvas.drawVerticalDottedLine(
        paint: paint,
        x: x,
        maxY: size.height,
      );

      // テキスト
      textPainter.paint(
        canvas,
        Offset(x + _scaleTextLeftMargin, textY),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension on Canvas {
  static const _dotHeight = 2.0;
  static const _dotSpace = 2.0;

  /// {x, y} から {x, maxY} までドットボーダーラインを描画
  void drawVerticalDottedLine({
    required Paint paint,
    required double x,
    double y = 0,
    required double maxY,
  }) {
    while (y < maxY) {
      drawLine(Offset(x, y), Offset(x, y + _dotHeight), paint);
      y += _dotHeight + _dotSpace;
    }
  }
}
