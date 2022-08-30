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
import '../blocs/get_all_teams/get_all_teams_bloc.dart';
import '../models/team_model.dart';
import '../repositories/team_repository.dart';
import '../widgets/team_card_widget.dart';

class AllTeamsList extends StatefulWidget {
  final String title;
  final String segment;
  final String subtitle;
  const AllTeamsList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.segment})
      : super(key: key);

  @override
  State<AllTeamsList> createState() => _AllTeamsListState();
}

class _AllTeamsListState extends State<AllTeamsList> {
  List<TeamModel> listOfTeams = [];
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TeamRepository(),
      child: BlocProvider(
        create: (context) =>
            GetAllTeamsBloc(teamRepository: context.read<TeamRepository>())
              ..add(GetAllTeamsFirstAttempt()),
        child: BlocListener<GetAllTeamsBloc, GetAllTeamsState>(
          listener: (context, state) {
            if (state is GotAllTeamsState) {
              setState(() {
                listOfTeams = state.listOfTeams;
              });
            }
          },
          child: BlocBuilder<GetAllTeamsBloc, GetAllTeamsState>(
            builder: (context, state) {
              return DashboardWrapper(
                  appBar: const DashboardAppBar(),
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
                          isLoading: state is GetAllTeamsLoading,
                          isLoaded: state is GotAllTeamsState,
                          headers: const [
                            DashboardDataHeaderWidget(
                              title: "Team Name",
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
                          itemCount: listOfTeams.length,
                          onDataTableScrollEnd: () {
                            if (state is GotAllTeamsState && state.hasMore) {
                              context
                                  .read<GetAllTeamsBloc>()
                                  .add(GetAllTeamsAttempt());
                            }
                          },
                          itemBuilder: (context, index) {
                            return TeamCardWidget(
                                listOfTeams: listOfTeams,
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
