import 'dart:developer';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/analytics/repositories/analytic_repository.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../../core/widgets/loader_widger.dart';

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
      child: FutureBuilder(
          future: AnalyticRepository().getNewUsers(),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              log(DateTime.now().millisecondsSinceEpoch.toString());
              log(snapshot.data!["listOfNewUsers"].toString());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This week",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        snapshot.data!["totalNewUsers"].toString(),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        "Total new users",
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
                              seriesColor: ColorUtil.fromDartColor(
                                  AppColors.yellowPrimary),
                              data: snapshot.data!["listOfNewUsers"],
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
              );
            } else {
              return Center(
                child: LoaderWidget(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          }),
    );
  }
}
