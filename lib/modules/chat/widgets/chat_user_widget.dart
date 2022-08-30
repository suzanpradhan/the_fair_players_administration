import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_fair_players_administration/modules/chat/blocs/chat_navigation/chat_navigation_bloc.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import '../models/chat_room_model.dart';

class ChatUserWidget extends StatelessWidget {
  final ChatRoomModel chatRoomModel;
  final bool isSelected;
  const ChatUserWidget(
      {Key? key, required this.chatRoomModel, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppConstants.pads),
      child: InkWell(
        onTap: () {
          context
              .read<GetChatRoomsBloc>()
              .add(SelectChatRoomAttempt(uid: chatRoomModel.uid!));
          context
              .read<ChatNavigationBloc>()
              .add(const ChatNavigationToggle(value: true));
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.padm, vertical: AppConstants.padm),
          decoration: BoxDecoration(
              color: isSelected ? AppColors.greenLight : AppColors.whitePrimary,
              borderRadius: AppConstants.regularBorderRadius,
              border: Border.all(
                  width: 1,
                  color: isSelected
                      ? AppColors.greenPrimary
                      : AppColors.greyLight)),
          child: Row(
            children: [
              (chatRoomModel.chatRoomImage != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(42),
                      child: FadeInImage.assetNetwork(
                        width: 42,
                        height: 42,
                        placeholder: AppAssets.noProfileImage,
                        image: chatRoomModel.chatRoomImage!,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, object, stackTrace) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(42),
                              child: Image.asset(
                                width: 42,
                                height: 42,
                                AppAssets.noProfileImage,
                                fit: BoxFit.cover,
                              ));
                        },
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(42),
                      child: Image.asset(
                        width: 42,
                        height: 42,
                        AppAssets.noProfileImage,
                        fit: BoxFit.cover,
                      )),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoomModel.name ?? "N/A",
                      style: isSelected
                          ? Theme.of(context).textTheme.bodyLarge!.accent
                          : Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      chatRoomModel.recentMessage ?? "",
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    (chatRoomModel.dateTime != null)
                        ? DateTimeFormat.relative(chatRoomModel.dateTime!,
                            appendIfAfter: 'ago')
                        : "",
                    style: Theme.of(context).textTheme.labelSmall!.primary,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // (chatRoomModel.notifyCount != null)
                  //     ? Container(
                  //         width: 34,
                  //         height: 34,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(34),
                  //             color: AppColors.greenLight),
                  //         child: Center(
                  //           child: Text(
                  //             chatRoomModel.notifyCount.toString(),
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelSmall!
                  //                 .accent,
                  //           ),
                  //         ),
                  //       )
                  //     : const SizedBox(
                  //         width: 34,
                  //         height: 34,
                  //       )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
