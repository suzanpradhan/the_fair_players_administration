import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/chat_navigation/chat_navigation_bloc.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/widgets/dashboard_app_bar.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/widgets/dashboard_header_widget.dart';
import 'package:the_fair_players_administration/modules/dashboard_side_bar/widgets/dashboard_side_bar.dart';
import 'package:vrouter/vrouter.dart';

import '../../authentication/bloc/user_authentication/user_authentication_bloc.dart';
import '../../dashboard_app_bar/blocs/search_input/search_input_bloc.dart';
import '../../dashboard_side_bar/blocs/bloc/toggle_side_bar_bloc.dart';

class DashboardWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  final DashboardAppBar appBar;
  final String subtitle;
  final Widget? headerLeftWidget;
  final Widget? rightWidget;
  const DashboardWrapper(
      {Key? key,
      required this.child,
      required this.appBar,
      required this.title,
      required this.subtitle,
      this.headerLeftWidget,
      this.rightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToggleSideBarBloc(),
        ),
        BlocProvider(
          create: (context) => SearchInputBloc(),
        ),
        BlocProvider(create: (context) => ChatNavigationBloc())
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
            listener: (context, state) {
              if (state.user != null) {
                context.vRouter.to(LOGIN_SCREEN_ROUTE, isReplacement: true);
              }
            },
          ),
          BlocListener<ToggleSideBarBloc, ToggleSideBarState>(
            listener: (context, state) {
              if (key.currentState!.hasDrawer) {
                if (state is SideBarOnState) {
                  if (!key.currentState!.isDrawerOpen) {
                    key.currentState!.openDrawer();
                  } else {
                    context
                        .read<ToggleSideBarBloc>()
                        .add(ToggleSideBarAttempt());
                  }
                } else if (state is SideBarOffState) {
                  if (key.currentState!.isDrawerOpen) {
                    key.currentState!.closeDrawer();
                  } else {
                    context
                        .read<ToggleSideBarBloc>()
                        .add(ToggleSideBarAttempt());
                  }
                }
              }
            },
          ),
        ],
        child: Scaffold(
          key: key,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: (ScreenUtil().screenWidth <= 768)
              ? Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).drawerTheme.backgroundColor),
                  width: 240,
                  height: MediaQuery.of(context).size.height,
                  child: const DashboardSideBar())
              : null,
          body: LayoutBuilder(builder: (context, constraints) {
            return Row(
              children: [
                (ScreenUtil().screenWidth > 768)
                    ? BlocBuilder<ToggleSideBarBloc, ToggleSideBarState>(
                        builder: (context, state) {
                          if (state is SideBarOnState) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .drawerTheme
                                      .backgroundColor),
                              width: 240,
                              height: MediaQuery.of(context).size.height,
                              child: const DashboardSideBar(),
                            );
                          }
                          return const SizedBox();
                        },
                      )
                    : const SizedBox(),
                Expanded(
                  child: Column(
                    children: [
                      appBar,
                      DashboardHeaderWidget(
                          headerTile: title,
                          leftWidget: headerLeftWidget,
                          headerSubtitle: subtitle,
                          rightWidget: rightWidget),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
