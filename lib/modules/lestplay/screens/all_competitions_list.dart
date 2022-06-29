import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/competition/blocs/get_all_competitions/get_all_competitions_bloc.dart';
import 'package:the_fair_players_administration/modules/competition/models/competition_model.dart';
import 'package:the_fair_players_administration/modules/lestplay/blocs/get_all_lets_play/get_all_lets_play_bloc.dart';
import 'package:the_fair_players_administration/modules/lestplay/models/letsplay_model.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_constants.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_header_widget.dart';
import '../../core/ui/dashboard_data_table/dashboard_data_table.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../../core/wrapper/dashboard_wrapper.dart';
import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../repositories/lets_play_repository.dart';
import '../widgets/lets_play_card_widget.dart';

class AllLetsPlayList extends StatefulWidget {
  final String title;
  final String segment;
  final String subtitle;
  const AllLetsPlayList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.segment})
      : super(key: key);

  @override
  State<AllLetsPlayList> createState() => _AllLetsPlayListState();
}

class _AllLetsPlayListState extends State<AllLetsPlayList> {
  List<LetsPlayModel> listOfLetsPlay = [];
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LetsPlayRepository(),
      child: BlocProvider(
        create: (context) => GetAllLetsPlayBloc(
            letsPlayRepository: context.read<LetsPlayRepository>())
          ..add(GetAllLetsPlayFirstAttempt()),
        child: BlocListener<GetAllLetsPlayBloc, GetAllLetsPlayState>(
          listener: (context, state) {
            if (state is GotAllLetsPlayState) {
              setState(() {
                listOfLetsPlay = state.listOfLetsPlay;
              });
            }
          },
          child: BlocBuilder<GetAllLetsPlayBloc, GetAllLetsPlayState>(
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
                          isLoading: state is GetAllLetsPlayLoading,
                          isLoaded: state is GotAllLetsPlayState,
                          headers: const [
                            DashboardDataHeaderWidget(
                              title: "UID",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Sport",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Type",
                              flex: 1,
                            ),
                            DashboardDataHeaderWidget(
                              title: "Description",
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
                          itemCount: listOfLetsPlay.length,
                          onDataTableScrollEnd: () {
                            if (state is GotAllLetsPlayState && state.hasMore) {
                              context
                                  .read<GetAllCompetitionsBloc>()
                                  .add(GetAllCompetitionAttempt());
                            }
                          },
                          itemBuilder: (context, index) {
                            return LetsPlayCardWidget(
                                listOfLetsPlay: listOfLetsPlay,
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
