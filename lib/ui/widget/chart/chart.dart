import 'package:flutter/material.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/bar_chart/bar_chart_by_canvas.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/bar_chart/bar_chart_by_container.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart_x_axis.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart_y_axis.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/model/bar_chart_item.dart';

class Chart extends StatelessWidget {
  const Chart.canvas({
    Key? key,
    required this.barChartItems,
  })  : _barChartType = _BarChartType.canvas,
        super(key: key);

  const Chart.container({
    Key? key,
    required this.barChartItems,
  })  : _barChartType = _BarChartType.container,
        super(key: key);

  final List<BarChartItem> barChartItems;
  final _BarChartType _barChartType;

  static const _chartHeight = 340.0;
  static const _chartFadeAnimationDuration = Duration(milliseconds: 200);
  static const _barAnimationDuration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    Widget barChart() {
      switch (_barChartType) {
        case _BarChartType.canvas:
          return BarChartByCanvas(
            barChartItems: barChartItems,
            maxBarHeight: _chartHeight - ChartXAxis.scaleTextHeight,
            barAnimationDuration: _barAnimationDuration,
          );
        case _BarChartType.container:
          return BarChartByContainer(
            barChartItems: barChartItems,
            maxBarHeight: _chartHeight - ChartXAxis.scaleTextHeight,
            barAnimationDuration: _barAnimationDuration,
          );
      }
    }

    return AnimatedSwitcher(
      duration: _chartFadeAnimationDuration,
      child: SizedBox(
        key: ValueKey(barChartItems),
        height: _chartHeight,
        child: Stack(
          children: [
            ChartXAxis(
              barChartItems: barChartItems,
            ),
            const ChartYAxis(),
            barChart(),
          ],
        ),
      ),
    );
  }
}

enum _BarChartType {
  canvas,
  container,
}
