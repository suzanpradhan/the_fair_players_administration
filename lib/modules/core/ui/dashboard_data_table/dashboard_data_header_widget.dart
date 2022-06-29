import 'package:flutter/material.dart';

import '../../../core/extensions/widget_extensions.dart';

class DashboardDataHeaderWidget extends StatelessWidget {
  final int flex;
  final String title;
  const DashboardDataHeaderWidget(
      {Key? key, this.flex = 1, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Center(
            child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.accent,
        )));
  }
}
