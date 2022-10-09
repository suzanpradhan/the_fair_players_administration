import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/club/blocs/get_all_clubs/get_all_clubs_bloc.dart';
import 'package:the_fair_players_administration/modules/club/repositories/club_repository.dart';
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
import '../models/club_model.dart';

class ClubCardWidget extends DashboardDataGroupWidget {
  final List<ClubModel> listOfClubs;
  final int index;
  final BuildContext context;
  final String segment;
  ClubCardWidget(
      {Key? key,
      required this.listOfClubs,
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
                    (listOfClubs[index].clubImage != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: FadeInImage.assetNetwork(
                              width: 42,
                              height: 42,
                              placeholder: AppAssets.noProfileImage,
                              image: listOfClubs[index].clubImage!,
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
                      listOfClubs[index].clubName ?? "N/A",
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
                    (listOfClubs[index].adminImage != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: FadeInImage.assetNetwork(
                              width: 42,
                              height: 42,
                              placeholder: AppAssets.noProfileImage,
                              image: listOfClubs[index].adminImage!,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, object, stackTrace) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(42),
                                    child: Image.asset(
                                      width: 42,
                                      height: 42,
                                      AppAssets.noProfileImage,
                                      fit: BoxFit.cover,
                                    ));
                              },
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
                      listOfClubs[index].adminName ?? "N/A",
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ],
                ),
              )),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                (listOfClubs[index].totalMembers ?? "N/A").toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
            flex: 1,
            child: FutureBuilder<bool>(
                future: context
                    .read<ClubRepository>()
                    .ifClubChatExist(clubId: listOfClubs[index].uid!),
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
                                    "room": listOfClubs[index].uid.toString()
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
                                context.vRouter.toSegments([
                                  segment,
                                  POST_SEGMENT,
                                  ALL_SEGMENT
                                ], queryParameters: {
                                  "user": listOfClubs[index].uid!,
                                  "username": listOfClubs[index].clubName ?? "",
                                  "type": PostType.club.name,
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
                                    "View Posts",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              )),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                              onTap: () {
                                ConfirmationDialog.showDeleteDialog(context,
                                    action: () {
                                  context.read<GetAllClubsBloc>().add(
                                      DeleteClubAttempt(
                                          clubModel: listOfClubs[index]));
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
