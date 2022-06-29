import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';

import '../blocs/search_input/search_input_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchInputBloc, SearchInputState>(
      listener: (context, state) {},
      child: TextField(
        controller: searchController,
        cursorColor: const Color(0xffFFB618),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (value) {},
        onSubmitted: (value) {
          context.read<SearchInputBloc>().add(SearchInputAttempt(value: value));
        },
        decoration: InputDecoration(
            hintText: "Search for chats or people",
            hintStyle: Theme.of(context).textTheme.labelLarge,
            enabledBorder: OutlineInputBorder(
                borderRadius: AppConstants.regularBorderRadius,
                borderSide:
                    const BorderSide(color: AppColors.whiteShade, width: 2)),
            border: OutlineInputBorder(
                borderRadius: AppConstants.regularBorderRadius,
                borderSide:
                    const BorderSide(color: AppColors.whiteShade, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: AppConstants.regularBorderRadius,
                borderSide:
                    const BorderSide(color: AppColors.whiteShade, width: 2)),
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
      ),
    );
  }
}
