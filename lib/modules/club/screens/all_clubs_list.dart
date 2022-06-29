import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_constants.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_header_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_table.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../../core/wrapper/dashboard_wrapper.dart';
import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../blocs/get_all_clubs/get_all_clubs_bloc.dart';
import '../models/club_model.dart';
import '../repositories/club_repository.dart';
import '../widgets/club_card_widget.dart';

class AllClubsList extends StatefulWidget {
  final String title;
  final String segment;
  final String subtitle;
  const AllClubsList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.segment})
      : super(key: key);

  @override
  State<AllClubsList> createState() => _AllClubsListState();
}

class _AllClubsListState extends State<AllClubsList> {
  List<ClubModel> listOfClubs = [];
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ClubRepository(),
      child: BlocProvider(
        create: (context) =>
            GetAllClubsBloc(clubRepository: context.read<ClubRepository>())
              ..add(GetAllClubsFirstAttempt()),
        child: BlocListener<GetAllClubsBloc, GetAllClubsState>(
          listener: (context, state) {
            if (state is GotAllClubsState) {
              setState(() {
                listOfClubs = state.listOfClubs;
              });
            }
          },
          child: BlocBuilder<GetAllClubsBloc, GetAllClubsState>(
            builder: (context, state) {
              return DashboardWrapper(
                  appBar: const DashboardAppBar(
                    isCountryFilterEnable: true,
                  ),
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
                            style:
                                Theme.of(context).textTheme.bodyMedium!.accent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.padL,
                          vertical: AppConstants.padxs),
                      child: DashboardDataTable(
                          isLoading: state is GetAllClubsLoading,
                          isLoaded: state is GotAllClubsState,
                          headers: const [
                            DashboardDataHeaderWidget(
                              title: "Club Name",
                              flex: 2,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Admin",
                              flex: 2,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Total Members",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Actions",
                              flex: 1,
                            )
                          ],
                          itemCount: listOfClubs.length,
                          onDataTableScrollEnd: () {
                            if (state is GotAllClubsState && state.hasMore) {
                              context
                                  .read<GetAllClubsBloc>()
                                  .add(GetAllClubsAttempt());
                            }
                          },
                          itemBuilder: (context, index) {
                            return ClubCardWidget(
                                listOfClubs: listOfClubs,
                                index: index,
                                segment: widget.segment,
                                context: context);
                          })));
            },
          ),
        ),
      ),
    );
  }
}
