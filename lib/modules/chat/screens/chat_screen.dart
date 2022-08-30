import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/delete_message/delete_message_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/room_message_list/room_message_list_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/send_message/send_message_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/theme/app_constants.dart';
import '../../core/wrapper/dashboard_wrapper.dart';
import '../../dashboard_app_bar/widgets/dashboard_app_bar.dart';
import '../blocs/chat_navigation/chat_navigation_bloc.dart';
import '../blocs/search_chat_room/search_chat_room_bloc.dart';
import '../widgets/chat_list_area.dart';
import '../widgets/chat_room_area.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final ChatRepository chatRepository;
  const ChatScreen(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.chatRepository})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isFirstLoaded = false;
  late GetChatRoomsBloc getChatRoomsBloc;

  @override
  void initState() {
    super.initState();
    getChatRoomsBloc = GetChatRoomsBloc(chatRepository: widget.chatRepository);
  }

  @override
  void didChangeDependencies() {
    if (!isFirstLoaded) {
      if (context.vRouter.queryParameters.containsKey("room")) {
        getChatRoomsBloc.add(GetChatRoomsFirstAttempt(
            uid: context.vRouter.queryParameters["room"]!));
      } else {
        getChatRoomsBloc.add(const GetChatRoomsFirstAttempt());
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getChatRoomsBloc,
        ),
        BlocProvider(
            create: (context) =>
                RoomMessageListBloc(chatRepository: widget.chatRepository)),
        BlocProvider(
            create: (context) =>
                SendMessageBloc(chatRepository: widget.chatRepository)),
        BlocProvider(
            create: (context) =>
                DeleteMessageBloc(chatRepository: widget.chatRepository)),
        BlocProvider(create: ((context) => SearchChatRoomBloc())),
      ],
      child: BlocListener<GetChatRoomsBloc, GetChatRoomsState>(
        listener: (context, state) {
          if (state is GotChatRoomsSuccessState) {
            if (state.selectedChatRoom != null) {
              context.read<RoomMessageListBloc>().add(
                  GetRoomMessageList(roomUid: state.selectedChatRoom!.uid!));
            }
          }
        },
        child: BlocBuilder<GetChatRoomsBloc, GetChatRoomsState>(
          builder: (context, state) {
            return DashboardWrapper(
              appBar: const DashboardAppBar(),
              key: key,
              title: widget.title,
              subtitle: widget.subtitle,
              headerLeftWidget:
                  BlocBuilder<ChatNavigationBloc, ChatNavigationState>(
                builder: (context, state) {
                  if ((ScreenUtil().screenWidth < 900) && state.isChatRoom) {
                    return IconButton(
                        onPressed: () {
                          context.read<ChatNavigationBloc>().add(
                              ChatNavigationToggle(value: !state.isChatRoom));
                          log("here");
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).iconTheme.color,
                        ));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.padL,
                ),
                child: (ScreenUtil().screenWidth < 900)
                    ? BlocBuilder<ChatNavigationBloc, ChatNavigationState>(
                        builder: (context, state) {
                          return IndexedStack(
                            index: state.isChatRoom ? 1 : 0,
                            children: const [ChatListArea(), ChatRoomArea()],
                          );
                        },
                      )
                    : Row(
                        children: const [
                          SizedBox(width: 400, child: ChatListArea()),
                          SizedBox(
                            width: 32,
                          ),
                          Expanded(child: ChatRoomArea())
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
