import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/analytics/screens/analytics_screen.dart';
import 'package:the_fair_players_administration/modules/authentication/screens/login_screen.dart';
import 'package:the_fair_players_administration/modules/authentication/screens/splash_screen.dart';
import 'package:the_fair_players_administration/modules/chat/screens/chat_screen.dart';
import 'package:the_fair_players_administration/modules/club/repositories/club_repository.dart';
import 'package:the_fair_players_administration/modules/club/screens/all_clubs_list.dart';
import 'package:the_fair_players_administration/modules/competition/repositories/competitions_repository.dart';
import 'package:the_fair_players_administration/modules/competition/screens/all_competitions_list.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';
import 'package:the_fair_players_administration/modules/lestplay/repositories/lets_play_repository.dart';
import 'package:the_fair_players_administration/modules/lestplay/screens/all_competitions_list.dart';
import 'package:the_fair_players_administration/modules/post/screens/all_post_screen.dart';
import 'package:the_fair_players_administration/modules/team/repositories/team_repository.dart';
import 'package:the_fair_players_administration/modules/team/screens/all_teams_list.dart';
import 'package:the_fair_players_administration/modules/user/repositories/user_repository.dart';
import 'package:the_fair_players_administration/modules/user/screens/all_users_list.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/user_authentication/user_authentication_bloc.dart';

List<VRouteElement> buildRoutes(BuildContext context) {
  return [
    VWidget(
        path: SPLASH_SCREEN,
        name: SPLASH_SCREEN,
        buildTransition: (animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
        widget: const SplashScreen()),
    VWidget(
        path: LOGIN_SCREEN_ROUTE,
        name: LOGIN_SCREEN_ROUTE,
        buildTransition: (animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
        widget: const LoginScreen()),
    VGuard(
        beforeEnter: (vRedirector) async {
          log("guard");
          if (context.read<UserAuthenticationBloc>().state.user == null) {
            vRedirector.to(SPLASH_SCREEN, queryParameters: {
              "redirect": vRedirector.newVRouterData!.url!
            });
          }
        },
        stackedRoutes: [
          VWidget(
              path: ANALYTICS_ROUTE,
              name: ANALYTICS_ROUTE,
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              widget: const AnalyticsScreen(
                title: "Analysis",
                subtitle: "Dashboard",
              )),
          VNester(
              path: "/$USER_SEGMENT",
              name: USER_SEGMENT,
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              widgetBuilder: (widget) {
                return widget;
              },
              nestedRoutes: [
                VWidget(
                    path: ALL_SEGMENT,
                    name: ALL_SEGMENT,
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllUsersList(
                      segment: USER_SEGMENT,
                      title: "All Users",
                      subtitle: "",
                    )),
                VGuard(
                    beforeEnter: (vRedirector) async {
                      if (!vRedirector.newVRouterData!.queryParameters
                          .containsKey("user")) {
                        vRedirector.pop();
                      }
                    },
                    stackedRoutes: [
                      VWidget(
                          path: "$POST_SEGMENT/$ALL_SEGMENT",
                          buildTransition:
                              (animation, secondaryAnimation, child) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                          widget: const AllPostScreen(title: "All Post")),
                    ]),
                VWidget.builder(
                    path: "$CHAT_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                          title: "All Chat List",
                          subtitle: "Users",
                          chatRepository: context.read<UserRepository>());
                    })
              ]),
          VNester(
              path: "/$TEAM_SEGMENT",
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              widgetBuilder: (widget) {
                return widget;
              },
              nestedRoutes: [
                VWidget(
                    path: "$USER_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllTeamsList(
                      segment: TEAM_SEGMENT,
                      title: "All Teams",
                      subtitle: "Team",
                    )),
                VWidget(
                    path: "$POST_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllPostScreen(
                      title: "All Post",
                    )),
                VWidget.builder(
                    path: "$CHAT_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                          title: "All Chat List",
                          subtitle: "Team",
                          chatRepository: context.read<TeamRepository>());
                    }),
              ]),
          VNester(
              path: "/$CLUB_SEGMENT",
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              widgetBuilder: (widget) {
                return widget;
              },
              nestedRoutes: [
                VWidget(
                    path: "$USER_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllClubsList(
                      segment: CLUB_SEGMENT,
                      title: "All Clubs",
                      subtitle: "Club",
                    )),
                VWidget(
                    path: "$POST_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllPostScreen(
                      title: "All Post",
                    )),
                VWidget.builder(
                    path: "$CHAT_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                        title: "All Chat List",
                        subtitle: "Club",
                        chatRepository: context.read<ClubRepository>(),
                      );
                    }),
              ]),
          VNester(
              path: "/$COMPETITION_SEGMENT",
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              widgetBuilder: (widget) {
                return widget;
              },
              nestedRoutes: [
                VWidget(
                    path: "$USER_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllCompetitionsList(
                      segment: COMPETITION_SEGMENT,
                      title: "All Users",
                      subtitle: "Competition",
                    )),
                VWidget(
                    path: "$POST_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllPostScreen(
                      title: "All Post",
                    )),
                VWidget.builder(
                    path: "$CHAT_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                        title: "All Chat List",
                        subtitle: "Competitions",
                        chatRepository: context.read<CompetitionsRepository>(),
                      );
                    }),
              ]),
          VNester(
              path: "/$LETS_PLAY_SEGMENT",
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              widgetBuilder: (widget) {
                return widget;
              },
              nestedRoutes: [
                VWidget(
                    path: "$USER_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllLetsPlayList(
                      title: "All Let's Play",
                      segment: LETS_PLAY_SEGMENT,
                      subtitle: "Let's Play",
                    )),
                VWidget(
                    path: "$POST_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    widget: const AllPostScreen(
                      title: "All Post",
                    )),
                VWidget.builder(
                    path: "$CHAT_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                        title: "All Chat List",
                        subtitle: "Lets Play",
                        chatRepository: context.read<LetsPlayRepository>(),
                      );
                    }),
              ]),
          VNester(
              path: "/$CHAT_SEGMENT",
              widgetBuilder: (widget) {
                return widget;
              },
              buildTransition: (animation, secondaryAnimation, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              nestedRoutes: [
                VWidget.builder(
                    path: "$TEAM_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                          title: "All Chat List",
                          subtitle: "Team",
                          chatRepository: context.read<TeamRepository>());
                    }),
                VWidget.builder(
                    path: "$CLUB_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                        title: "All Chat List",
                        subtitle: "Club",
                        chatRepository: context.read<ClubRepository>(),
                      );
                    }),
                VWidget.builder(
                    path: "$COMPETITION_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                        title: "All Chat List",
                        subtitle: "Competitions",
                        chatRepository: context.read<CompetitionsRepository>(),
                      );
                    }),
                VWidget.builder(
                    path: "$LETS_PLAY_SEGMENT/$ALL_SEGMENT",
                    buildTransition: (animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                    builder: (BuildContext context, VRouterData vRouterData) {
                      return ChatScreen(
                        title: "All Chat List",
                        subtitle: "Lets Play",
                        chatRepository: context.read<LetsPlayRepository>(),
                      );
                    }),
              ])
        ]),
  ];
}
