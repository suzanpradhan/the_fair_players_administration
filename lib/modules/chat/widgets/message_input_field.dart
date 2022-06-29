import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/user_authentication/user_authentication_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import '../blocs/send_message/send_message_bloc.dart';
import '../models/message_model.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({Key? key}) : super(key: key);

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  late TextEditingController messageTextController;

  @override
  void initState() {
    messageTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageBloc, SendMessageState>(
      listener: (context, state) {
        if (state is AdminMessageSent) {
          messageTextController.clear();
        }
      },
      builder: (context, state) {
        return TextField(
          cursorColor: const Color(0xffFFB618),
          controller: messageTextController,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              hintText: "Type a message",
              hintStyle: Theme.of(context).textTheme.labelLarge,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              fillColor: AppColors.whiteShade,
              hoverColor: AppColors.whiteShade,
              focusColor: AppColors.whiteShade,
              filled: true,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.pads),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.image_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.pads),
                child: IconButton(
                  onPressed: () {
                    if (messageTextController.text.isNotEmpty) {
                      log("here");
                      context.read<SendMessageBloc>().add(
                          SendAdminMessageAttempt(
                              messageModel: MessageModel(
                                  message: messageTextController.text,
                                  messageType: "text",
                                  userID: context
                                      .read<UserAuthenticationBloc>()
                                      .state
                                      .user!
                                      .uid,
                                  userName: "Admin"),
                              teamId: (context.read<GetChatRoomsBloc>().state
                                      as GotChatRoomsSuccessState)
                                  .selectedChatRoom!
                                  .uid!));
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.yellowPrimary,
                  ),
                ),
              )),
        );
      },
    );
  }
}
