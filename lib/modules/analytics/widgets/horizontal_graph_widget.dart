import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/analytics/repositories/analytic_repository.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';

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
      child: FutureBuilder(
          future: AnalyticRepository().getMontlyUsers(),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              return Row(
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
                        snapshot.data!["totalUsersOfThisMonth"].toString(),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        "Total active users",
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
                                id: "ActiveUsers",
                                seriesColor: ColorUtil.fromDartColor(
                                    AppColors.yellowPrimary),
                                data: snapshot.data!["listOfActiveUsers"],
                                domainFn: (List list, _) => list[0],
                                measureFn: (List list, _) => list[1])
                          ],
                        )),
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
