import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/lestplay/blocs/get_all_lets_play/get_all_lets_play_bloc.dart';
import 'package:the_fair_players_administration/modules/lestplay/repositories/lets_play_repository.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../../core/extensions/widget_extensions.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_group_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_widget.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../models/letsplay_model.dart';

class LetsPlayCardWidget extends DashboardDataGroupWidget {
  final List<LetsPlayModel> listOfLetsPlay;
  final int index;
  final BuildContext context;
  final String segment;
  LetsPlayCardWidget(
      {Key? key,
      required this.listOfLetsPlay,
      required this.index,
      required this.segment,
      required this.context})
      : super(key: key, datas: [
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfLetsPlay[index].uid ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfLetsPlay[index].sportName ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfLetsPlay[index].type ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfLetsPlay[index].description ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfLetsPlay[index].address ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
            flex: 1,
            child: FutureBuilder<bool>(
                future: context.read<LetsPlayRepository>().ifLetsPlayChatExist(
                    competitionId: listOfLetsPlay[index].uid!),
                builder: (context, snapshot) {
                  return PopupMenuButton<int>(
                      enabled: true,
                      elevation: 2,
                      padding: EdgeInsets.zero,
                      offset: const Offset(0, 42),
                      shape: RoundedRectangleBorder(
                          borderRadius: AppConstants.mediumBorderRadius),
                      itemBuilder: (context) {
                        return [
                          if (snapshot.hasData && snapshot.data!)
                            PopupMenuItem(
                                onTap: () {
                                  context.vRouter.toSegments([
                                    segment,
                                    CHAT_SEGMENT,
                                    ALL_SEGMENT
                                  ], queryParameters: {
                                    "room": listOfLetsPlay[index].uid.toString()
                                  });
                                },
                                height: 32,
                                child: Row(
                                  children: [
                                    Icon(
                                      FairPlayersIcon.plus,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "View Chats",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                )),
                          if (snapshot.hasData && snapshot.data!)
                            const PopupMenuDivider(),
                          PopupMenuItem(
                              onTap: () {
                                context.read<GetAllLetsPlayBloc>().add(
                                    DeleteLetsPlayAttempt(
                                        letsPlayModel: listOfLetsPlay[index]));
                              },
                              height: 32,
                              child: Row(
                                children: [
                                  const Icon(
                                    FairPlayersIcon.trash,
                                    color: AppColors.redAccent,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Delete",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .danger,
                                  )
                                ],
                              ))
                        ];
                      },
                      child: Center(
                        child: Icon(Icons.more_vert,
                            color: Theme.of(context).iconTheme.color),
                      ));
                }),
          )
        ]);
}
