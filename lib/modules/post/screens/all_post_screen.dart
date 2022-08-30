import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';
import 'package:the_fair_players_administration/modules/post/repositories/post_repository.dart';
import 'package:the_fair_players_administration/modules/post/widgets/post_card_widget.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/theme/app_constants.dart';
import '../../core/wrapper/dashboard_wrapper.dart';
import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../blocs/get_user_post/get_user_post_bloc.dart';

class AllPostScreen extends StatefulWidget {
  final String title;
  const AllPostScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {
  final GetUserPostBloc getUserPostBloc =
      GetUserPostBloc(postRepostitory: PostRepostitory());
  bool isFirstloaded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isFirstloaded) {
      getUserPostBloc.add(GetAllUserPostFirstAttempt(
          uid: context.vRouter.queryParameters["user"]!));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return RepositoryProvider(
      create: (context) => PostRepostitory(),
      child: BlocProvider(
        create: (context) => getUserPostBloc,
        child: DashboardWrapper(
          appBar: const DashboardAppBar(),
          key: key,
          title: widget.title,
          subtitle: context.vRouter.queryParameters["username"] ?? "",
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.padL, vertical: AppConstants.padr),
              child: BlocBuilder<GetUserPostBloc, GetUserPostState>(
                builder: (context, state) {
                  if (state is GotAllUsersPostsState) {
                    return Wrap(
                      runSpacing: AppConstants.pads,
                      spacing: AppConstants.pads,
                      children: state.listOfPosts
                          .map((post) => PostCardWidget(
                                postModel: post,
                              ))
                          .toList(),
                    );
                  } else {
                    return LoaderWidget(
                      color: Theme.of(context).primaryColor,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
