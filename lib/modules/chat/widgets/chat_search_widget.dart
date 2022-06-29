import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';

class ChatSearchWidget extends StatelessWidget {
  const ChatSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: const Color(0xffFFB618),
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          hintText: "Search for teams chat",
          hintStyle: Theme.of(context).textTheme.labelLarge,
          enabledBorder: OutlineInputBorder(
              borderRadius: AppConstants.regularBorderRadius,
              borderSide:
                  const BorderSide(color: AppColors.greyLight, width: 2)),
          border: OutlineInputBorder(
              borderRadius: AppConstants.regularBorderRadius,
              borderSide:
                  const BorderSide(color: AppColors.greyLight, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: AppConstants.regularBorderRadius,
              borderSide:
                  const BorderSide(color: AppColors.greyLight, width: 2)),
          fillColor: AppColors.whitePrimary,
          hoverColor: AppColors.whitePrimary,
          focusColor: AppColors.whitePrimary,
          filled: true,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.pads),
            child: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
            ),
          )),
    );
  }
}
