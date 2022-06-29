import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  final Color? color;
  const LoaderWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: CircularProgressIndicator(
        color: color ?? AppColors.whitePrimary,
        strokeWidth: 1,
      ),
    );
  }
}
