import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';

import '../../core/extensions/widget_extensions.dart';
import '../../core/routes/app_routes.dart';

class SideBarItem extends StatefulWidget {
  final String route;
  final bool isSegment;
  final IconData icon;
  final String title;
  final Function()? onTap;
  final Color? color;
  const SideBarItem(
      {Key? key,
      required this.title,
      required this.isSegment,
      required this.icon,
      required this.route,
      this.onTap,
      this.color})
      : super(key: key);

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ??
          () {
            if (context.vRouter.path != "${widget.route}/$ALL_SEGMENT") {
              if (widget.isSegment) {
                context.vRouter.to("${widget.route}/$ALL_SEGMENT");
              } else {
                context.vRouter.to(widget.route);
              }
            }
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
                    padding: const EdgeInsets.only(left: 34),
                    child: Icon(
                      widget.icon,
                      color: (context.vRouter.path.startsWith(widget.route))
                          ? Theme.of(context).primaryColor
                          : widget.color ?? Theme.of(context).iconTheme.color,
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
                          : (widget.color != null)
                              ? Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: widget.color)
                              : Theme.of(context).textTheme.labelMedium!.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
