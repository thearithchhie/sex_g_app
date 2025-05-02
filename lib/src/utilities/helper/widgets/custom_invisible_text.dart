import 'package:dv_pay_mobile/src/utilities/general.dart';
import 'package:flutter/material.dart';

class CustomInvisibleText extends StatelessWidget {
  final bool isHide;
  final String? text;
  final String? obCurveText;
  final TextStyle? style;

  const CustomInvisibleText({super.key, this.isHide = false, this.text, this.obCurveText, this.style});

  static const String route = "/CustomInvisibleText";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48),
      child: IntrinsicWidth(
        child: TextField(
          enabled: false,
          scrollPadding: const EdgeInsets.all(0),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration.collapsed(
            border: InputBorder.none,
            hintText: app.isHideMyAsset ? (obCurveText ?? "****") : text,
            hintStyle: style ?? const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
