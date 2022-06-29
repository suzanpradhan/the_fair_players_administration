import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_fair_players_administration/modules/analytics/models/analytics_model.dart';
import 'package:the_fair_players_administration/modules/analytics/widgets/analytic_card_widget.dart';
import 'package:the_fair_players_administration/modules/analytics/widgets/horizontal_graph_widget.dart';
import 'package:the_fair_players_administration/modules/analytics/widgets/vertical_graph_widget.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';
import 'package:the_fair_players_administration/modules/core/wrapper/dashboard_wrapper.dart';

import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../blocs/analytic_dates/analytic_dates_bloc.dart';

class AnalyticsScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  const AnalyticsScreen({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticDatesBloc(),
      child: DashboardWrapper(
        appBar: const DashboardAppBar(
          title: "Dashboard",
          isCountryFilterEnable: true,
        ),
        title: title,
        subtitle: subtitle,
        rightWidget: BlocBuilder<AnalyticDatesBloc, AnalyticDatesState>(
          builder: (context, state) {
            if (state is AnalyticDatesState) {
              return PopupMenuButton<int>(
                  offset: const Offset(0, 50),
                  itemBuilder: ((context) {
                    return [
                      PopupMenuItem(
                          onTap: () {
                            context
                                .read<AnalyticDatesBloc>()
                                .add(ChangeToDayAnalytic());
                          },
                          height: 34,
                          child: Text(
                            "daily",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                          onTap: () {
                            context
                                .read<AnalyticDatesBloc>()
                                .add(ChangeToWeekAnalytic());
                          },
                          height: 34,
                          child: Text(
                            "last week",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                          onTap: () {
                            context
                                .read<AnalyticDatesBloc>()
                                .add(ChangeToMonthAnalytic());
                          },
                          height: 34,
                          child: Text(
                            "last 30 days",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    ];
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.padr,
                        vertical: AppConstants.pads),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: AppConstants.regularBorderRadius),
                    child: Row(
                      children: [
                        Text(
                          state.title.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Theme.of(context).iconTheme.color,
                        )
                      ],
                    ),
                  ));
            } else {
              return const SizedBox();
            }
          },
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.padL),
            child: Column(
              children: [
                BlocBuilder<AnalyticDatesBloc, AnalyticDatesState>(
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: AppConstants.largeBorderRadius),
                      padding: EdgeInsets.all(AppConstants.padr),
                      // margin: EdgeInsets.symmetric(horizontal: AppConstants.padr),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: listOfAnalysis.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: AppConstants.padm,
                                  crossAxisSpacing: AppConstants.padm,
                                  maxCrossAxisExtent: 280,
                                  mainAxisExtent: 120,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            return AnalyticCardWidget(
                              subtitle: listOfAnalysis[index].title,
                              stream: listOfAnalysis[index]
                                  .stream(timeszone: state.startAtTimeStamp),
                            );
                          }),
                    );
                  },
                ),
                SizedBox(
                  height: AppConstants.padr,
                ),
                (ScreenUtil().screenWidth > 768)
                    ? Row(
                        children: [
                          const Expanded(
                              flex: 3, child: HorizontalGraphWidget()),
                          SizedBox(
                            width: AppConstants.padr,
                          ),
                          const Expanded(flex: 2, child: VerticalGraphWidget())
                        ],
                      )
                    : Column(
                        children: [
                          const HorizontalGraphWidget(),
                          SizedBox(
                            height: AppConstants.padr,
                          ),
                          const VerticalGraphWidget()
                        ],
                      ),
                SizedBox(
                  height: AppConstants.padr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
