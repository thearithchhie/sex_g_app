import 'package:flutter/material.dart';

class AppGestureDetector extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? paddingAll;

  const AppGestureDetector({
    Key? key,
    required this.child,
    this.padding,
    this.paddingAll,
    this.onTap,
    this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Padding(
        padding: paddingAll != null ? EdgeInsets.all(paddingAll!) : (padding ?? EdgeInsets.zero),
        child: child,
      ),
    );
  }
}
