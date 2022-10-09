import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/core/ui/lazy_scroll_view.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';
import 'package:the_fair_players_administration/modules/user/repositories/user_repository.dart';
import 'package:vrouter/vrouter.dart';

import '../../authentication/bloc/user_authentication/user_authentication_bloc.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import '../blocs/search_chat_room/search_chat_room_bloc.dart';
import '../models/message_model.dart';
import 'chat_search_widget.dart';
import 'chat_user_widget.dart';

class ChatListArea extends StatefulWidget {
  const ChatListArea({Key? key}) : super(key: key);

  @override
  State<ChatListArea> createState() => _ChatListAreaState();
}

class _ChatListAreaState extends State<ChatListArea> {
  late TextEditingController messageTextController;
  late bool isLoading;

  @override
  void initState() {
    messageTextController = TextEditingController();
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetChatRoomsBloc, GetChatRoomsState>(
      listener: (context, state) {
        if (state is GotChatRoomsSuccessState) {
          context.read<SearchChatRoomBloc>().add(SearchChatRoomAttempt(
              chatRooms: state.listOfChatRooms,
              searchKeyword: "",
              selectedRoom: state.selectedChatRoom));
        }
      },
      child: BlocBuilder<GetChatRoomsBloc, GetChatRoomsState>(
        builder: (context, state) {
          return BlocBuilder<SearchChatRoomBloc, SearchChatRoomState>(
            builder: (context, searchState) {
              return Column(
                children: [
                  const ChatSearchWidget(),
                  if (state is GetChatRoomsLoadingState ||
                      searchState is SeachChatRoomLoadingState)
                    LoaderWidget(
                      color: Theme.of(context).primaryColor,
                    ),
                  if (state is GotChatRoomsSuccessState &&
                      searchState is SearchChatRoomSuccessState)
                    Expanded(
                      child: LazyScrollView(
                        onEndScroll: () {
                          // if (state.hasMore == true) {
                          //   context
                          //       .read<GetChatRoomsBloc>()
                          //       .add(GetChatRoomsAttempt());
                          // }
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                vertical: AppConstants.padr),
                            itemCount: (searchState).chatRooms.length,
                            itemBuilder: (contex, index) {
                              return ChatUserWidget(
                                isSelected: (state.selectedChatRoom != null)
                                    ? state.selectedChatRoom!.uid ==
                                        searchState.chatRooms[index].uid
                                    : false,
                                chatRoomModel: searchState.chatRooms[index],
                              );
                            }),
                      ),
                    ),
                  if (context.vRouter.path.startsWith(
                          "/$CHAT_SEGMENT/$USER_SEGMENT/$ALL_SEGMENT") &&
                      state is GotChatRoomsSuccessState &&
                      searchState is SearchChatRoomSuccessState)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                        cursorColor: const Color(0xffFFB618),
                        controller: messageTextController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: "Type a bulk message",
                            hintStyle: Theme.of(context).textTheme.labelLarge,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none),
                            fillColor: AppColors.whitePrimary,
                            hoverColor: AppColors.whitePrimary,
                            focusColor: AppColors.whitePrimary,
                            filled: true,
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppConstants.pads),
                              child: isLoading
                                  ? const LoaderWidget(
                                      color: AppColors.yellowPrimary,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        if (messageTextController
                                            .text.isNotEmpty) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          context
                                              .read<UserRepository>()
                                              .sendAdminBulkMessage(
                                                messageModel: MessageModel(
                                                    message:
                                                        messageTextController
                                                            .text,
                                                    messageType: "text",
                                                    userID: context
                                                        .read<
                                                            UserAuthenticationBloc>()
                                                        .state
                                                        .user!
                                                        .uid,
                                                    userName: "Admin"),
                                              )
                                              .then((value) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          });
                                          messageTextController.clear();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: AppColors.yellowPrimary,
                                      ),
                                    ),
                            )),
                      ),
                    )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
