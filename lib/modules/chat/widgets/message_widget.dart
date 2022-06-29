import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/theme/app_assets.dart';

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
                  "time",
                  style: Theme.of(context).textTheme.labelSmall!.primary,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
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
                  child: messageModel.messageType == "image"
                      ? Container(
                          constraints: const BoxConstraints(
                              maxWidth: 300, maxHeight: 300),
                          child: Image.network(
                            messageModel.message.toString(),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          messageModel.message.toString(),
                          style: isMine
                              ? Theme.of(context).textTheme.bodyMedium!.button
                              : Theme.of(context).textTheme.bodyMedium!.primary,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
