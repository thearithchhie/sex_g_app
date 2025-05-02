import 'package:easy_localization/easy_localization.dart';
import 'package:sex_g_app/export.dart';

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Function()? onTap;
  final Gradient? gradient;
  final bool isEnabled;

  const CustomSubmitButton({
    super.key,
    this.text = "Submit",
    this.onTap,
    this.gradient,
    this.textStyle,
    this.isEnabled = true,
  });

  static const String route = "/CustomSubmitButton";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (isEnabled) {
          onTap?.call();
        }
      },
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient ??
              (isEnabled
                  ? AppColor.primaryBtnGradient
                  : (app.isDark
                      ? AppColor.disabledGradientDark
                      : AppColor.disabledGradient)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text.tr(),
            style: textStyle ??
                context.typography.body12B
                    .copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
