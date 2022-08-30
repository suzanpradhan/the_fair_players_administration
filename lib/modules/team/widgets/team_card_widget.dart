import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/team/blocs/get_all_teams/get_all_teams_bloc.dart';
import 'package:the_fair_players_administration/modules/team/repositories/team_repository.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../../core/extensions/widget_extensions.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_group_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_widget.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../../core/widgets/confirmation_dialog.dart';
import '../models/team_model.dart';

class TeamCardWidget extends DashboardDataGroupWidget {
  final List<TeamModel> listOfTeams;
  final int index;
  final BuildContext context;
  final String segment;
  TeamCardWidget(
      {Key? key,
      required this.listOfTeams,
      required this.index,
      required this.segment,
      required this.context})
      : super(key: key, datas: [
          DashboardDataWidget(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padxs),
                child: Row(
                  children: [
                    (listOfTeams[index].teamImage != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: FadeInImage.assetNetwork(
                              width: 42,
                              height: 42,
                              placeholder: AppAssets.noProfileImage,
                              image: listOfTeams[index].teamImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: Image.asset(
                              width: 42,
                              height: 42,
                              AppAssets.noProfileImage,
                              fit: BoxFit.cover,
                            )),
                    SizedBox(
                      width: AppConstants.pads,
                    ),
                    Text(
                      listOfTeams[index].teamName ?? "N/A",
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ],
                ),
              )),
          DashboardDataWidget(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padxs),
                child: Row(
                  children: [
                    (listOfTeams[index].adminImage != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: FadeInImage.assetNetwork(
                              width: 42,
                              height: 42,
                              placeholder: AppAssets.noProfileImage,
                              image: listOfTeams[index].adminImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: Image.asset(
                              width: 42,
                              height: 42,
                              AppAssets.noProfileImage,
                              fit: BoxFit.cover,
                            )),
                    SizedBox(
                      width: AppConstants.pads,
                    ),
                    Text(
                      listOfTeams[index].adminName ?? "N/A",
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ],
                ),
              )),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfTeams[index].totalMembers ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
            flex: 1,
            child: FutureBuilder<bool>(
                future: context
                    .read<TeamRepository>()
                    .ifTeamChatExist(uid: listOfTeams[index].uid!),
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
                                    "room": listOfTeams[index].uid.toString()
                                  });
                                },
                                height: 32,
                                child: Row(
                                  children: [
                                    Icon(
                                      FairPlayersIcon.message,
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
                                ConfirmationDialog.showDeleteDialog(context,
                                    action: () {
                                  context.read<GetAllTeamsBloc>().add(
                                      DeleteTeamAttempt(
                                          teamModel: listOfTeams[index]));
                                });
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
