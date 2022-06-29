import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/extensions/widget_extensions.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../../core/theme/app_text_styles.dart';

class AnalyticCardWidget extends StatelessWidget {
  final String subtitle;
  final Stream<DatabaseEvent> stream;
  const AnalyticCardWidget(
      {Key? key, required this.subtitle, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: stream,
        builder: (context, snapshot) {
          return Container(
            // padding: const EdgeInsets.symmetric(
            //     vertical: AppConstants.padL, horizontal: AppConstants.padxs),
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).dividerColor),
                borderRadius: AppConstants.largeBorderRadius,
                color: AppColors.whiteShade),
            width: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    (snapshot.hasData)
                        ? snapshot.data!.snapshot.children.length.toString()
                        : "N/A",
                    style: AppTextStyles.textBold.accent.exxl),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          );
        });
  }
}
