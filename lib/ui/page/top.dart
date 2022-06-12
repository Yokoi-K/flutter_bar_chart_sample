import 'package:flutter/material.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/chart.dart';
import 'package:flutter_bar_chart_sample/ui/widget/chart/model/bar_chart_item.dart';
import 'package:flutter_bar_chart_sample/ui/widget/snack_bar/snack_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class TopPage extends HookWidget {
  const TopPage({
    Key? key,
  }) : super(key: key);

  static const chartHorizontalPadding = 16;
  static const _defaultBarLength = 10;
  static const _canvasChartColor = Colors.teal;
  static const _containerChartColor = Colors.brown;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController(
      text: _defaultBarLength.toString(),
    );

    final canvasBarChartItems = useState(
      BarChartItem.createList(
        length: textEditingController.intText!,
        color: _canvasChartColor,
      ),
    );
    final containerBarChartItems = useState(
      BarChartItem.createList(
        length: textEditingController.intText!,
        color: _containerChartColor,
      ),
    );

    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_bar_chart_sample'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Canvas'),
            Tab(text: 'Container'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Chart.canvas(
                      barChartItems: canvasBarChartItems.value,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Chart.container(
                      barChartItems: containerBarChartItems.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black87,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                const Gap(8),
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final intText = textEditingController.intText;

                      if (intText == null) {
                        showSnackBar(context, 'Integer only.');
                        return;
                      }

                      if (intText < 5) {
                        showSnackBar(context, '5 or higher only.');
                        return;
                      }

                      if (tabController.index == 0) {
                        canvasBarChartItems.value = BarChartItem.createList(
                          length: textEditingController.intText!,
                          color: _canvasChartColor,
                        );
                      } else {
                        containerBarChartItems.value = BarChartItem.createList(
                          length: textEditingController.intText!,
                          color: _containerChartColor,
                        );
                      }
                    },
                    child: const Text('Create!'),
                  ),
                ),
                const Gap(32),
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension on TextEditingController {
  int? get intText => int.tryParse(text);
}
