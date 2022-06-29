import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';

class HorizontalGraphWidget extends StatelessWidget {
  const HorizontalGraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      padding: EdgeInsets.all(AppConstants.padr),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppConstants.largeBorderRadius,
          border: Border.all(width: 1, color: Theme.of(context).cardColor)),
      child: Row(
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
            width: 20,
          ),
          Expanded(
            child: Container(
                height: 280,
                color: AppColors.whitePrimary,
                child: OrdinalComboChart(
                  domainAxis: const OrdinalAxisSpec(
                    showAxisLine: false,
                  ),
                  primaryMeasureAxis:
                      const NumericAxisSpec(showAxisLine: false),
                  defaultRenderer: LineRendererConfig(
                      strokeWidthPx: 5,
                      roundEndCaps: true,
                      stacked: true,
                      areaOpacity: 0.1,
                      includeArea: true),
                  [
                    Series<List, String>(
                        id: "Sales",
                        seriesColor:
                            ColorUtil.fromDartColor(AppColors.greenPrimary),
                        data: [
                          ["SEP", 5],
                          ["OCT", 20],
                          ["NOV", 100],
                          ["DEC", 75],
                          ["JAN", 75],
                          ["FEB", 75],
                        ],
                        domainFn: (List list, _) => list[0],
                        measureFn: (List list, _) => list[1]),
                    Series<List, String>(
                        id: "Sales",
                        seriesColor:
                            ColorUtil.fromDartColor(AppColors.yellowPrimary),
                        data: [
                          ["SEP", 10],
                          ["OCT", 40],
                          ["NOV", 80],
                          ["DEC", 10],
                          ["JAN", 75],
                          ["FEB", 75],
                        ],
                        domainFn: (List list, _) => list[0],
                        measureFn: (List list, _) => list[1])
                  ],
                )),
          )
        ],
      ),
    );
  }
}
