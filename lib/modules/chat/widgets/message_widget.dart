import 'dart:developer';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/delete_message/delete_message_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/theme/app_assets.dart';
import '../../core/ui/fair_players_icon_icons.dart';
import '../blocs/get_chat_rooms/get_chat_rooms_bloc.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel messageModel;
  final bool isMine;
  const MessageWidget(
      {Key? key, required this.messageModel, required this.isMine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine)
            Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(right: AppConstants.padr),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (messageModel.userImage != null)
                      ? NetworkImage(messageModel.userImage!)
                      : const AssetImage(AppAssets.noProfileImage)
                          as ImageProvider,
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  (messageModel.dateTime != null)
                      ? DateTimeFormat.relative(messageModel.dateTime!,
                          appendIfAfter: 'ago')
                      : "",
                  style: Theme.of(context).textTheme.labelSmall!.primary,
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<GetChatRoomsBloc, GetChatRoomsState>(
                  builder: (context, getChatRoomsState) {
                    return BlocBuilder<DeleteMessageBloc, DeleteMessageState>(
                      builder: (context, state) {
                        return PopupMenuButton<int>(
                          enabled: true,
                          elevation: 2,
                          padding: EdgeInsets.zero,
                          offset: const Offset(0, 42),
                          shape: RoundedRectangleBorder(
                              borderRadius: AppConstants.mediumBorderRadius),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  onTap: () {
                                    if (getChatRoomsState
                                        is GotChatRoomsSuccessState) {
                                      log("here");
                                      context.read<DeleteMessageBloc>().add(
                                          DeleteMessageAttempt(
                                              roomUid: getChatRoomsState
                                                  .selectedChatRoom!.uid!,
                                              messageId: messageModel.uid!));
                                    }
                                  },
                                  height: 32,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FairPlayersIcon.trash,
                                        color: AppColors.redAccent,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Delete",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .danger,
                                      )
                                    ],
                                  ))
                            ];
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.padr,
                                vertical: AppConstants.pads),
                            decoration: BoxDecoration(
                                borderRadius: isMine
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.zero,
                                        topRight: Radius.circular(8))
                                    : const BorderRadius.only(
                                        topLeft: Radius.zero,
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                color: isMine
                                    ? AppColors.yellowPrimary
                                    : AppColors.whitePrimary,
                                boxShadow: const [
                                  BoxShadow(
                                      color: AppColors.whiteShade,
                                      blurRadius: 15,
                                      spreadRadius: 5)
                                ]),
                            child: (messageModel.messageType == "image")
                                ? Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 300, maxHeight: 300),
                                    child: Image.network(
                                      messageModel.message.toString(),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, widget,
                                          ImageChunkEvent? chunckEvent) {
                                        if (chunckEvent == null) {
                                          return widget;
                                        } else {
                                          return ClipRRect(
                                            child: Image.asset(
                                              AppAssets.placeholderImage,
                                              width: 300,
                                              height: 300,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder:
                                          (context, object, stackTrace) {
                                        return ClipRRect(
                                          child: Image.asset(
                                            AppAssets.placeholderImage,
                                            width: 300,
                                            height: 300,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Text(
                                    messageModel.message.toString(),
                                    style: isMine
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .button
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .primary,
                                  ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
