import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/authentication/bloc/user_authentication/user_authentication_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/room_message_list/room_message_list_bloc.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';

import '../../core/theme/app_constants.dart';
import 'message_widget.dart';

class MessageListWidget extends StatelessWidget {
  const MessageListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomMessageListBloc, RoomMessageListState>(
      builder: (context, state) {
        if (state is MessageListState) {
          return ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(vertical: AppConstants.padm),
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemCount: state.listOfMessages.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                  messageModel: state.listOfMessages[index],
                  isMine: (state.listOfMessages[index].userID ==
                      context.read<UserAuthenticationBloc>().state.user!.uid),
                );
              });
        }
        if (state is RoomMessageListInitial) {
          return Center(
            child: Text("Please select chat to continue.",
                style: Theme.of(context).textTheme.bodyLarge),
          );
        } else {
          return Center(
            child: LoaderWidget(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
