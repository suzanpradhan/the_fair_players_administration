import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/ui/dashboard_data_table/dashboard_data_widget.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_constants.dart';

class DashboardDataGroupWidget extends StatefulWidget {
  final List<DashboardDataWidget> datas;
  const DashboardDataGroupWidget({Key? key, required this.datas})
      : super(key: key);

  @override
  State<DashboardDataGroupWidget> createState() =>
      _DashboardDataGroupWidgetState();
}

class _DashboardDataGroupWidgetState extends State<DashboardDataGroupWidget> {
  late bool isHovered;

  @override
  void initState() {
    isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.padr, vertical: AppConstants.padm),
      child: InkWell(
        onHover: (isHover) {
          setState(() {
            isHovered = isHover;
          });
        },
        onTap: () {},
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: isHovered ? AppColors.greenLight : AppColors.whitePrimary,
              borderRadius: AppConstants.regularBorderRadius),
          child: Row(
            children: widget.datas,
          ),
        ),
      ),
    );
  }
}
