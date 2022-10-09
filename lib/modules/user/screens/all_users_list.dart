import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/user/widgets/user_card_widget.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_constants.dart';
import '../../core/extensions/widget_extensions.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_header_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_table.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../../core/wrapper/dashboard_wrapper.dart';
import '../../dashboard_app_bar/blocs/search_input/search_input_bloc.dart';
import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../blocs/get_all_users/get_all_users_bloc.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AllUsersList extends StatefulWidget {
  final String title;
  final String segment;
  final String subtitle;
  const AllUsersList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.segment})
      : super(key: key);

  @override
  State<AllUsersList> createState() => _AllUsersListState();
}

class _AllUsersListState extends State<AllUsersList> {
  List<UserModel> listOfUsers = [];
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) =>
          GetAllUsersBloc(userRepository: context.read<UserRepository>())
            ..add(const GetAllUsersFirstAttempt()),
      child: BlocListener<GetAllUsersBloc, GetAllUsersState>(
        listener: (context, state) {
          if (state is GotAllUsersState) {
            setState(() {
              listOfUsers = state.listOfUsers;
              listOfUsers.sort((a, b) => a.firstName?.compareTo(b.firstName!) ?? 0);
            });
          }
        },
        child: BlocBuilder<GetAllUsersBloc, GetAllUsersState>(
          builder: (context, state) {
            return DashboardWrapper(
                appBar: const DashboardAppBar(
                  isSearchEnable: true,
                ),
                key: key,
                title: widget.title,
                subtitle: widget.subtitle,
                rightWidget: InkWell(
                  onTap: () {
                    context.vRouter.toSegments(
                        [widget.segment, CHAT_SEGMENT, ALL_SEGMENT]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.padr,
                        vertical: AppConstants.pads),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            width: 1, color: Theme.of(context).primaryColor),
                        borderRadius: AppConstants.regularBorderRadius),
                    child: Row(
                      children: [
                        Icon(
                          FairPlayersIcon.message,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "All chat list",
                          style: Theme.of(context).textTheme.bodyMedium!.accent,
                        ),
                      ],
                    ),
                  ),
                ),
                child: BlocListener<SearchInputBloc, SearchInputState>(
                  listener: (context, state) {
                    if (state is SearchInputValueState) {
                      context.read<GetAllUsersBloc>().add(
                          GetAllUsersFirstAttempt(searchValue: state.value));
                    }
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.padL,
                          vertical: AppConstants.padxs),
                      child: DashboardDataTable(
                          isLoading: state is GetAllUsersLoading,
                          isLoaded: state is GotAllUsersState,
                          headers: const [
                            DashboardDataHeaderWidget(
                              title: "Name",
                              flex: 2,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Email",
                              flex: 2,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Location",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Actions",
                              flex: 1,
                            )
                          ],
                          itemCount: listOfUsers.length,
                          onDataTableScrollEnd: () {
                            if (state is GotAllUsersState && state.hasMore) {
                              context
                                  .read<GetAllUsersBloc>()
                                  .add(const GetAllUsersAttempt());
                            }
                          },
                          itemBuilder: (context, index) {
                            return UserCardWidget(
                                listOfUsers: listOfUsers,
                                index: index,
                                segment: widget.segment,
                                context: context);
                          })),
                ));
          },
        ),
      ),
    );
  }
}
