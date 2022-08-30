import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/room_message_list/room_message_list_bloc.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_constants.dart';
import 'message_input_field.dart';
import 'message_list_widget.dart';

class ChatRoomArea extends StatelessWidget {
  const ChatRoomArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.pads),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: AppConstants.largeBorderRadius),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Theme.of(context).dividerColor))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<RoomMessageListBloc, RoomMessageListState>(
                      builder: (context, state) {
                        return Text(
                          (context.read<GetChatRoomsBloc>().state
                                      is GotChatRoomsSuccessState &&
                                  (context.read<GetChatRoomsBloc>().state
                                              as GotChatRoomsSuccessState)
                                          .selectedChatRoom !=
                                      null)
                              ? (context.read<GetChatRoomsBloc>().state
                                      as GotChatRoomsSuccessState)
                                  .selectedChatRoom!
                                  .name!
                              : "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      },
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Theme.of(context).iconTheme.color,
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.padL),
              child: const MessageListWidget(),
            )),
            Container(
              padding: EdgeInsets.only(
                  left: AppConstants.padL,
                  right: AppConstants.padL,
                  bottom: AppConstants.pads),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        image: const DecorationImage(
                            image: AssetImage(AppAssets.noProfileImage))),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const Expanded(child: MessageInputField())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
