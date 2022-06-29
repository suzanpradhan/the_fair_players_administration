import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../../core/extensions/widget_extensions.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_group_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_widget.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../models/user_model.dart';

class UserCardWidget extends DashboardDataGroupWidget {
  final List<UserModel> listOfUsers;
  final int index;
  final BuildContext context;
  final String segment;
  UserCardWidget(
      {Key? key,
      required this.listOfUsers,
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
                    Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (listOfUsers[index].image != null)
                                    ? NetworkImage(listOfUsers[index].image!)
                                    : const AssetImage(AppAssets.noProfileImage)
                                        as ImageProvider))),
                    SizedBox(
                      width: AppConstants.pads,
                    ),
                    Text(
                      (listOfUsers[index].firstName == null &&
                              listOfUsers[index].lastName == null)
                          ? "N/A"
                          : listOfUsers[index].firstName ??
                              " ${listOfUsers[index].lastName ?? ""}",
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ],
                ),
              )),
          DashboardDataWidget(
              flex: 2,
              child: Center(
                  child: Text(
                listOfUsers[index].email ?? "N/A",
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
              flex: 1,
              child: Center(
                  child: Text(
                "${listOfUsers[index].town ?? ""} ${listOfUsers[index].country ?? ""}",
                style: Theme.of(context).textTheme.labelLarge!,
              ))),
          DashboardDataWidget(
            flex: 1,
            child: PopupMenuButton<int>(
                enabled: true,
                elevation: 2,
                padding: EdgeInsets.zero,
                offset: const Offset(0, 42),
                shape: RoundedRectangleBorder(
                    borderRadius: AppConstants.mediumBorderRadius),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        onTap: () {
                          context.vRouter.toSegments([
                            segment,
                            POST_SEGMENT,
                            ALL_SEGMENT
                          ], queryParameters: {
                            "user": listOfUsers[index].uid!,
                            "username":
                                "${listOfUsers[index].firstName ?? ""} ${listOfUsers[index].lastName ?? ""}",
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
                )),
          )
        ]);
}
