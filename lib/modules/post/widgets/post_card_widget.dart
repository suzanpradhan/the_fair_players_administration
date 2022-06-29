import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/ui/fair_players_icon_icons.dart';
import 'package:the_fair_players_administration/modules/post/models/post_model.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_constants.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/extensions/widget_extensions.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel postModel;
  const PostCardWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(AppConstants.padm),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppConstants.largeBorderRadius,
          border: Border.all(width: 1, color: Theme.of(context).dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                postModel.title ?? "N/A",
                style: AppTextStyles.textSemiBold.grey.m,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.redAccent,
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 280,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: postModel.postImage != null
                        ? NetworkImage(postModel.postImage!)
                        : const AssetImage(AppAssets.noProfileImage)
                            as ImageProvider),
                borderRadius: AppConstants.mediumBorderRadius),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            postModel.description ?? "N/A",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FairPlayersIcon.trophy,
                        color: Theme.of(context).iconTheme.color,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FairPlayersIcon.message,
                        color: Theme.of(context).iconTheme.color,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FairPlayersIcon.share,
                        color: Theme.of(context).iconTheme.color,
                      ))
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("0 likes",
                        style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(
                      width: 8,
                    ),
                    Text("0 comments",
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
