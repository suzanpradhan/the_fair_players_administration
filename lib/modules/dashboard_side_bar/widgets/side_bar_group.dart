import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_constants.dart';
import 'package:the_fair_players_administration/modules/dashboard_side_bar/widgets/side_bar_item.dart';
import 'package:vrouter/vrouter.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/routes/app_routes.dart';

class SideBarGroup extends StatefulWidget {
  final String route;
  final bool isSegment;
  final IconData icon;
  final String title;
  final List<SideBarItem> items;
  const SideBarGroup(
      {Key? key,
      required this.title,
      required this.isSegment,
      required this.items,
      required this.icon,
      required this.route})
      : super(key: key);

  @override
  State<SideBarGroup> createState() => _SideBarGroupState();
}

class _SideBarGroupState extends State<SideBarGroup> {
  late bool isVisible;
  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
            // if (context.vRouter.path != "${widget.route}/$ALL_SEGMENT") {
            //   if (widget.isSegment) {
            //     context.vRouter.to("${widget.route}/$ALL_SEGMENT");
            //   } else {
            //     context.vRouter.to(widget.route);
            //   }
            // }
          },
          child: Container(
            height: 50,
            color: (context.vRouter.path.startsWith(widget.route))
                ? AppColors.greenLight
                : AppColors.whitePrimary,
            child: Row(
              children: [
                Container(
                  width: 8,
                  color: (context.vRouter.path.startsWith(widget.route))
                      ? Theme.of(context).primaryColor
                      : null,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Icon(
                          widget.icon,
                          color: (context.vRouter.path.startsWith(widget.route))
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: (context.vRouter.path.startsWith(widget.route))
                              ? Theme.of(context).textTheme.labelMedium!.accent
                              : Theme.of(context).textTheme.labelMedium!.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: (context.vRouter.path.startsWith(widget.route))
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Padding(
            padding: EdgeInsets.only(left: AppConstants.padm),
            child: Column(
              children: widget.items,
            ),
          ),
        )
      ],
    );
  }
}
