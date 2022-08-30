import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_assets.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/repository/country_repository.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/widgets/country_selector.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/widgets/search_bar_widget.dart';

import '../../dashboard_side_bar/blocs/bloc/toggle_side_bar_bloc.dart';
import '../blocs/get_countries/get_countries_bloc.dart';

class DashboardAppBar extends StatelessWidget {
  final bool? isCountryFilterEnable;
  final bool isSearchEnable;
  final String? title;
  const DashboardAppBar(
      {Key? key,
      this.isCountryFilterEnable = false,
      this.title,
      this.isSearchEnable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetCountriesBloc(countryRepository: CountryRepository())
            ..add(GetCountriesAttempt()),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.padL),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  if (ScreenUtil().screenWidth <= 1000)
                    BlocBuilder<ToggleSideBarBloc, ToggleSideBarState>(
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              context
                                  .read<ToggleSideBarBloc>()
                                  .add(ToggleSideBarAttempt());
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Theme.of(context).iconTheme.color,
                            ));
                      },
                    ),
                  Visibility(
                    visible: isSearchEnable,
                    child: Container(
                        constraints:
                            const BoxConstraints(maxWidth: 340, minWidth: 100),
                        child: SearchBarWidget()),
                  ),
                  if (!isSearchEnable && title != null)
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  const SizedBox(
                    width: 18,
                  ),
                  if (isCountryFilterEnable!)
                    BlocBuilder<GetCountriesBloc, GetCountriesState>(
                      builder: (context, state) {
                        return const CountrySelectorWidget();
                      },
                    )
                ],
              )),
              Row(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.notifications_none_outlined,
                  //     color: Theme.of(context).iconTheme.color,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.noProfileImage)),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(42)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
