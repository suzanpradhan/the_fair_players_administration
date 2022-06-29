import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/core/ui/lazy_scroll_view.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';

import '../../core/theme/app_constants.dart';
import '../blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import 'chat_search_widget.dart';
import 'chat_user_widget.dart';

class ChatListArea extends StatelessWidget {
  const ChatListArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatRoomsBloc, GetChatRoomsState>(
      builder: (context, state) {
        return Column(
          children: [
            const ChatSearchWidget(),
            if (state is GetChatRoomsLoadingState)
              LoaderWidget(
                color: Theme.of(context).primaryColor,
              ),
            if (state is GotChatRoomsSuccessState)
              Expanded(
                child: LazyScrollView(
                  onEndScroll: () {
                    if (state.hasMore == true) {
                      context
                          .read<GetChatRoomsBloc>()
                          .add(GetChatRoomsAttempt());
                    }
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: AppConstants.padr),
                      itemCount: state.listOfChatRooms.length,
                      itemBuilder: (contex, index) {
                        return ChatUserWidget(
                          isSelected: (state.selectedChatRoom != null)
                              ? state.selectedChatRoom!.uid ==
                                  state.listOfChatRooms[index].uid
                              : false,
                          chatRoomModel: state.listOfChatRooms[index],
                        );
                      }),
                ),
              )
          ],
        );
      },
    );
  }
}
