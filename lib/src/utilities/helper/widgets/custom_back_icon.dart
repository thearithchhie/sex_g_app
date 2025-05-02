import 'package:flutter/material.dart';

class CustomBackIcon extends StatelessWidget {
  final double padding;
  final Color? color;

  const CustomBackIcon({super.key, this.padding = 12, this.color});

  static const String route = "/CustomBackIcon";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        padding: EdgeInsets.all(padding),
        icon: Icon(Icons.arrow_back_ios, color: color ?? Colors.white, size: 19),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
