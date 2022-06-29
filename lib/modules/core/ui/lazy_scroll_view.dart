// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';

enum LoadingStatus { LOADING, STABLE }

class LazyScrollView extends StatefulWidget {
  final Widget child;
  final Function() onEndScroll;
  const LazyScrollView(
      {Key? key, required this.child, required this.onEndScroll})
      : super(key: key);

  @override
  State<LazyScrollView> createState() => _LazyScrollViewState();
}

class _LazyScrollViewState extends State<LazyScrollView> {
  LoadingStatus loadMoreStatus = LoadingStatus.STABLE;

  @override
  void didUpdateWidget(LazyScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadMoreStatus = LoadingStatus.STABLE;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // log(notification.metrics.maxScrollExtent.toString(),
          //     name: "maxScrollExtent");
          // log(notification.metrics.pixels.toString(), name: "pixels");
          if (notification is ScrollUpdateNotification) {
            log("ScrollUpdateNotification");
            if (notification.metrics.maxScrollExtent >=
                    notification.metrics.pixels &&
                notification.metrics.maxScrollExtent -
                        notification.metrics.pixels <=
                    100) {
              if (loadMoreStatus == LoadingStatus.STABLE) {
                loadMoreStatus = LoadingStatus.LOADING;
                log(notification.metrics.maxScrollExtent.toString(),
                    name: "maxScrollExtent");
                log(notification.metrics.pixels.toString(), name: "pixels");
                widget.onEndScroll();
              }
            }
            return true;
          }

          if (notification is OverscrollNotification) {
            if (notification.overscroll > 0) {
              if (loadMoreStatus == LoadingStatus.STABLE) {
                loadMoreStatus = LoadingStatus.LOADING;
                log("OverscrollNotification");
                widget.onEndScroll();
              }
            }
            return true;
          }

          // if (notification.metrics.maxScrollExtent >
          //     notification.metrics.pixels) {
          //   if (loadMoreStatus == LoadingStatus.STABLE) {
          //     loadMoreStatus = LoadingStatus.LOADING;
          //     log(notification.metrics.maxScrollExtent.toString(),
          //         name: "down");
          //     log(notification.metrics.pixels.toString(), name: "down");
          //     // widget.onEndScroll();
          //   }
          //   return true;
          // }

          return false;
        },
        child: Column(
          children: [
            Flexible(child: widget.child),
            if (loadMoreStatus == LoadingStatus.LOADING)
              LoaderWidget(
                color: Theme.of(context).primaryColor,
              )
          ],
        ));
  }
}
