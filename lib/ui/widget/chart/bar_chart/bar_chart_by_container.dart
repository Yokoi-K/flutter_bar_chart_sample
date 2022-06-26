import 'package:flutter/material.dart';
import 'package:flutter_bar_chart_sample/ui/page/top.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart_x_axis.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart_y_axis.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/model/bar_chart_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BarChartByContainer extends HookWidget {
  const BarChartByContainer({
    Key? key,
    required this.barChartItems,
    required this.maxBarHeight,
    required this.barAnimationDuration,
  }) : super(key: key);

  final List<BarChartItem> barChartItems;
  final double maxBarHeight;
  final Duration barAnimationDuration;

  static const _barRatio = 0.8;
  static const _barTopRadius = Radius.circular(8);

  @override
  Widget build(BuildContext context) {
    // 水平のpaddingを引いたものを、描画可能な横幅とする
    final layoutWidth =
        MediaQuery.of(context).size.width - TopPage.chartHorizontalPadding * 2;
    // 棒グラフ一つ当たりの横幅を算出
    final barWidth = (layoutWidth - ChartYAxis.scaleTextWidth) /
        barChartItems.length *
        _barRatio;

    final animationController =
        useAnimationController(duration: barAnimationDuration);

    final animationHeight = useMemoized(
      () => animationController.drive(
        Tween(
          begin: 0.0,
          end: maxBarHeight,
        ).chain(
          CurveTween(
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
      [maxBarHeight],
    );

    useEffect(() {
      // [barChartItems]が更新されたタイミングでアニメーション発火
      Future.microtask(animationController.forward);

      return animationController.reset;
    }, [barChartItems]);

    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: animationHeight,
        builder: (context, _) => Padding(
          padding: const EdgeInsets.only(
            right: ChartYAxis.scaleTextWidth,
            bottom: ChartXAxis.scaleTextHeight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            // 与えられた[barChartItems]の数だけ[Container]を表示させる
            children: barChartItems
                .map(
                  (item) => Container(
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: const BorderRadius.only(
                        topLeft: _barTopRadius,
                        topRight: _barTopRadius,
                      ),
                    ),
                    width: barWidth,
                    // それぞれの棒グラフの高さに応じてアニメーションの進捗を変える
                    height: item.height * animationHeight.value / maxBarHeight,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
