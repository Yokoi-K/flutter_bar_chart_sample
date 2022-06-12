import 'dart:math';

import 'package:flutter/material.dart';

class BarChartItem {
  BarChartItem._({
    required this.height,
    required this.color,
  });

  final double height;
  final Color color;

  static List<BarChartItem> createList({
    required int length,
    required Color color,
  }) {
    final random = Random();

    return List.generate(
      length,
      (_) => BarChartItem._(
        // 200 ~ 300 の[height]を生成
        height: random.nextInt(200) + 101,
        color: color,
      ),
    );
  }
}
