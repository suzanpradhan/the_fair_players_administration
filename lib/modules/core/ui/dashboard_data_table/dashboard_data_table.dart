import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/ui/dashboard_data_table/dashboard_data_group_widget.dart';
import 'package:the_fair_players_administration/modules/core/ui/dashboard_data_table/dashboard_data_header_widget.dart';

import '../../theme/app_constants.dart';
import '../../widgets/loader_widger.dart';
import '../lazy_scroll_view.dart';
import 'dashboard_data_widget.dart';

class DashboardDataTable extends StatelessWidget {
  final List<DashboardDataHeaderWidget> headers;
  final bool isLoading;
  final bool isLoaded;
  final Function() onDataTableScrollEnd;
  final int itemCount;
  final DashboardDataGroupWidget Function(BuildContext context, int index)
      itemBuilder;
  const DashboardDataTable(
      {Key? key,
      required this.headers,
      this.isLoading = false,
      required this.itemCount,
      required this.itemBuilder,
      required this.onDataTableScrollEnd,
      this.isLoaded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppConstants.largeBorderRadius),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Theme.of(context).dividerColor))),
            height: 50,
            child: Row(
              children: headers,
            ),
          ),
          if (isLoading)
            LoaderWidget(
              color: Theme.of(context).primaryColor,
            ),
          if (isLoaded && itemCount != 0)
            Expanded(
              child: LazyScrollView(
                onEndScroll: onDataTableScrollEnd,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemCount,
                  padding: EdgeInsets.symmetric(vertical: AppConstants.padxs),
                  itemBuilder: itemBuilder,
                ),
              ),
            ),
          if (isLoaded && itemCount == 0)
            Center(
              child: Text(
                "No Data Found.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
        ],
      ),
    );
  }
}
