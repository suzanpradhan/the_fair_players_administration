import 'package:flutter/material.dart';

class DashboardDataWidget extends StatelessWidget {
  final int flex;
  final Widget child;
  const DashboardDataWidget({Key? key, this.flex = 1, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: Center(child: child));
  }
}
