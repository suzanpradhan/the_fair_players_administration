import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';

class VerticalGraphWidget extends StatelessWidget {
  const VerticalGraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      padding: EdgeInsets.all(AppConstants.padr),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppConstants.largeBorderRadius,
          border: Border.all(width: 1, color: Theme.of(context).cardColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "This month",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                "7.5K",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                "Total users",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              color: AppColors.whitePrimary,
              child: BarChart(
                domainAxis: const OrdinalAxisSpec(
                  showAxisLine: false,
                ),
                [
                  Series<List, String>(
                      id: "Sales",
                      seriesColor:
                          ColorUtil.fromDartColor(AppColors.yellowPrimary),
                      data: [
                        ["00", 5],
                        ["04", 20],
                        ["08", 100],
                        ["12", 75],
                        ["14", 60],
                        ["16", 75],
                        ["18", 50],
                      ],
                      domainFn: (List list, _) => list[0],
                      measureFn: (List list, _) => list[1]),
                ],
                defaultRenderer: BarRendererConfig(
                    maxBarWidthPx: 20,
                    cornerStrategy: const ConstCornerStrategy(30)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
