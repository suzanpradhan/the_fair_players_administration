import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_fair_players_administration/modules/authentication/bloc/user_authentication/user_authentication_bloc.dart';
import 'package:the_fair_players_administration/modules/authentication/services/firebase_authentication_service.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_assets.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';
import 'package:the_fair_players_administration/modules/core/ui/fair_players_icon_icons.dart';
import 'package:the_fair_players_administration/modules/dashboard_side_bar/widgets/side_bar_group.dart';
import 'package:the_fair_players_administration/modules/dashboard_side_bar/widgets/side_bar_item.dart';

class DashboardSideBar extends StatelessWidget {
  const DashboardSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.padL),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppAssets.logoSVG,
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SideBarItem(
                  isSegment: false,
                  route: ANALYTICS_ROUTE,
                  title: "Dashboard",
                  icon: FairPlayersIcon.home,
                ),
                const SideBarItem(
                    isSegment: true,
                    route: "/$USER_SEGMENT",
                    title: "Users",
                    icon: FairPlayersIcon.person),
                const SideBarItem(
                  isSegment: true,
                  route: "/$TEAM_SEGMENT/$USER_SEGMENT",
                  title: "Teams",
                  icon: FairPlayersIcon.team,
                ),
                const SideBarItem(
                  isSegment: true,
                  route: "/$CLUB_SEGMENT/$USER_SEGMENT",
                  title: "Club",
                  icon: FairPlayersIcon.club,
                ),
                const SideBarItem(
                  isSegment: true,
                  route: "/$COMPETITION_SEGMENT/$USER_SEGMENT",
                  title: "Competition",
                  icon: FairPlayersIcon.competition,
                ),
                const SideBarItem(
                  isSegment: true,
                  route: "/$LETS_PLAY_SEGMENT/$USER_SEGMENT",
                  title: "Let's Play",
                  icon: FairPlayersIcon.letsPlay,
                ),
                const SideBarGroup(
                  isSegment: true,
                  route: "/$CHAT_SEGMENT",
                  title: "Chats",
                  icon: FairPlayersIcon.chats,
                  items: [
                    SideBarItem(
                      isSegment: true,
                      route: "/$CHAT_SEGMENT/$USER_SEGMENT",
                      title: "All Users",
                      icon: FairPlayersIcon.person,
                    ),
                    SideBarItem(
                      isSegment: true,
                      route: "/$CHAT_SEGMENT/$TEAM_SEGMENT",
                      title: "Teams",
                      icon: FairPlayersIcon.team,
                    ),
                    SideBarItem(
                      isSegment: true,
                      route: "/$CHAT_SEGMENT/$CLUB_SEGMENT",
                      title: "Club",
                      icon: FairPlayersIcon.club,
                    ),
                    SideBarItem(
                      isSegment: true,
                      route: "/$CHAT_SEGMENT/$COMPETITION_SEGMENT",
                      title: "Competition",
                      icon: FairPlayersIcon.competition,
                    ),
                    SideBarItem(
                      isSegment: true,
                      route: "/$CHAT_SEGMENT/$LETS_PLAY_SEGMENT",
                      title: "Let's Play",
                      icon: FairPlayersIcon.letsPlay,
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              BlocBuilder<UserAuthenticationBloc, UserAuthenticationState>(
                builder: (context, state) {
                  return SideBarItem(
                    isSegment: true,
                    route: "/logout",
                    title: "Log Out",
                    icon: FairPlayersIcon.logout,
                    color: AppColors.redAccent,
                    onTap: () {
                      context.read<FirebaseAuthenticationService>().signOut;
                      context
                          .read<UserAuthenticationBloc>()
                          .add(const UserAuthenticationEvent());
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
