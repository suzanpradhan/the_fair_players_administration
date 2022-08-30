import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../blocs/get_chat_rooms/get_chat_rooms_bloc.dart';
import '../blocs/search_chat_room/search_chat_room_bloc.dart';

class ChatSearchWidget extends StatelessWidget {
  const ChatSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatRoomsBloc, GetChatRoomsState>(
      builder: (context, state) {
        return BlocBuilder<SearchChatRoomBloc, SearchChatRoomState>(
          builder: (context, searchState) {
            return TextField(
              cursorColor: const Color(0xffFFB618),
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (keyword) {
                if (state is GotChatRoomsSuccessState) {
                  context.read<SearchChatRoomBloc>().add(SearchChatRoomAttempt(
                      chatRooms: state.listOfChatRooms,
                      searchKeyword: keyword,
                      selectedRoom: state.selectedChatRoom));
                }
              },
              decoration: InputDecoration(
                  hintText: "Search for teams chat",
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: AppConstants.regularBorderRadius,
                      borderSide: const BorderSide(
                          color: AppColors.greyLight, width: 2)),
                  border: OutlineInputBorder(
                      borderRadius: AppConstants.regularBorderRadius,
                      borderSide: const BorderSide(
                          color: AppColors.greyLight, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: AppConstants.regularBorderRadius,
                      borderSide: const BorderSide(
                          color: AppColors.greyLight, width: 2)),
                  fillColor: AppColors.whitePrimary,
                  hoverColor: AppColors.whitePrimary,
                  focusColor: AppColors.whitePrimary,
                  filled: true,
                  prefixIcon: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppConstants.pads),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )),
            );
          },
        );
      },
    );
  }
}
