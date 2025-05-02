import 'package:sex_g_app/export.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomInputWithLabel extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final bool obscureText;
  final String? upperText;
  final TextEditingController? controller;
  final bool isReadOnly;
  final bool isWithBorder;
  final String? iconPath;
  final Widget? iconWidget;
  final String? labelText;
  final FormStyle style;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;

  const CustomInputWithLabel({
    super.key,
    this.hintText = "",
    this.textInputType,
    this.obscureText = false,
    this.controller,
    this.upperText,
    this.isReadOnly = false,
    this.iconPath,
    this.labelText,
    this.style = FormStyle.style1,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.isWithBorder = true,
    this.onTap,
    this.iconWidget,
  });

  static const String route = "/CustomTextField";

  @override
  Widget build(BuildContext context) {
    final InputBorder bordered = OutlineInputBorder(
      borderSide: BorderSide(
        color: isWithBorder
            ? (app.isDark ? AppColor.pr900 : const Color(0xffA4A4A4))
            : Colors.transparent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextField(
          onTap: onTap,
          readOnly: isReadOnly,
          controller: controller,
          textAlign: TextAlign.end,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            hintText: hintText.tr(),
            contentPadding: const EdgeInsets.all(15),
            hintStyle: style == FormStyle.style1
                ? context.typography.body14B.copyWith(
                    color:
                        app.isDark ? AppColor.primary : const Color(0xffA4A4A4),
                  )
                : context.typography.body12M.copyWith(
                    color:
                        app.isDark ? AppColor.primary : const Color(0xffA4A4A4),
                  ),
            filled: false,
            errorBorder: bordered,
            focusedBorder: bordered,
            focusedErrorBorder: bordered,
            disabledBorder: bordered,
            enabledBorder: bordered,
            border: bordered,
            prefix: prefix,
            suffixIcon: suffixIcon,
            suffix: suffix,
            prefixIcon: prefixIcon ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    12.widthBox,
                    if (iconPath != null || iconWidget != null) ...[
                      iconWidget ?? Image.asset(iconPath!, scale: 3),
                      10.widthBox
                    ],
                    Text(
                      labelText ?? '',
                      style: style == FormStyle.style1
                          ? (iconPath == null && iconWidget == null
                              ? context.typography.body14B
                              : context.typography.body14R)
                          : context.typography.body14Sb.copyWith(
                              color: app.isDark
                                  ? AppColor.primary
                                  : const Color(0xffA4A4A4),
                            ),
                    ),
                  ],
                ),
          ),
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: obscureText,
        ),
        if (upperText != null) ...[
          Positioned(
            top: -8,
            left: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              color: app.isDark ? const Color(0xff05031C) : AppColor.bgLight,
              child: Text(upperText ?? '', style: context.typography.body12Sb),
            ),
          ),
        ],
      ],
    );
  }
}
