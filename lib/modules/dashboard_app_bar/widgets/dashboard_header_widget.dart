import 'package:flutter/material.dart';

import '../../core/theme/app_constants.dart';
import '../../core/extensions/widget_extensions.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final String headerTile;
  final String headerSubtitle;
  final Widget? rightWidget;
  final Widget? leftWidget;
  const DashboardHeaderWidget(
      {Key? key,
      required this.headerTile,
      required this.headerSubtitle,
      this.leftWidget,
      this.rightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.padL),
        child: Row(
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                leftWidget ?? const SizedBox(),
                Text(headerTile,
                    style: Theme.of(context).textTheme.displayLarge!.accent),
                Padding(
                  padding: EdgeInsets.all(AppConstants.padxs),
                  child: Text("/  $headerSubtitle",
                      style: Theme.of(context).textTheme.labelLarge),
                )
              ],
            )),
            rightWidget ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
