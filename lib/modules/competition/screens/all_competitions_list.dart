import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/competition/blocs/get_all_competitions/get_all_competitions_bloc.dart';
import 'package:the_fair_players_administration/modules/competition/models/competition_model.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_constants.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_header_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_table.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../../core/wrapper/dashboard_wrapper.dart';
import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../repositories/competitions_repository.dart';
import '../widgets/competition_card_widget.dart';

class AllCompetitionsList extends StatefulWidget {
  final String title;
  final String segment;
  final String subtitle;
  const AllCompetitionsList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.segment})
      : super(key: key);

  @override
  State<AllCompetitionsList> createState() => _AllCompetitionsListState();
}

class _AllCompetitionsListState extends State<AllCompetitionsList> {
  List<CompetitionModel> listOfCompetitions = [];
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CompetitionsRepository(),
      child: BlocProvider(
        create: (context) => GetAllCompetitionsBloc(
            competitionsRepository: context.read<CompetitionsRepository>())
          ..add(GetAllCompetitionFirstAttempt()),
        child: BlocListener<GetAllCompetitionsBloc, GetAllCompetitionState>(
          listener: (context, state) {
            if (state is GotAllCompetitionState) {
              setState(() {
                listOfCompetitions = state.listOfCompetitions;
              });
            }
          },
          child: BlocBuilder<GetAllCompetitionsBloc, GetAllCompetitionState>(
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
                          isLoading: state is GetAllCompetitionLoading,
                          isLoaded: state is GotAllCompetitionState,
                          headers: const [
                            DashboardDataHeaderWidget(
                              title: "Competition Name",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Admin",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Total Members",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Sport",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Address",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Actions",
                              flex: 1,
                            )
                          ],
                          itemCount: listOfCompetitions.length,
                          onDataTableScrollEnd: () {
                            if (state is GotAllCompetitionState &&
                                state.hasMore) {
                              context
                                  .read<GetAllCompetitionsBloc>()
                                  .add(GetAllCompetitionAttempt());
                            }
                          },
                          itemBuilder: (context, index) {
                            return CompetitionCardWidget(
                                listOfCompetitions: listOfCompetitions,
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
