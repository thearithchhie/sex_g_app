import 'package:sex_g_app/export.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends StatelessWidget {
  final Function(String) onCompleted;
  final bool showBgColor;
  final bool hideKeyBoard;
  final TextEditingController? controller;
  final bool obscureText;
  final Color? customBgColor;
  final bool forceErrorState;
  final String? errorText;

  CustomPinPut({
    super.key,
    required this.onCompleted,
    this.showBgColor = false,
    this.hideKeyBoard = false,
    this.controller,
    this.obscureText = false,
    this.customBgColor,
    this.errorText,
    this.forceErrorState = false,
  });

  static const String route = "/CustomPinPut";

  final int _inputLength = 6;
  late final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: AppColor.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: showBgColor
          ? null
          : const Border(bottom: BorderSide(color: AppColor.white, width: 1)),
      borderRadius: showBgColor ? BorderRadius.circular(8) : null,
      color: showBgColor
          ? (customBgColor ?? (app.isDark ? AppColor.pr950 : AppColor.white))
          : Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: showBgColor
          ? null
          : const Border(bottom: BorderSide(color: AppColor.primary, width: 1)),
    );
    final submittedPinTheme =
        defaultPinTheme.copyWith(decoration: defaultPinTheme.decoration);

    final errorTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration
          ?.copyWith(border: Border.all(color: AppColor.danger, width: 1)),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Pinput(
          controller: controller,
          length: _inputLength,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorTheme,
          obscureText: obscureText,
          obscuringWidget: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: app.isDark ? AppColor.white : AppColor.black),
          ),
          validator: (s) {
            return null;
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) {
            onCompleted(pin);
          },
          keyboardType:
              hideKeyBoard ? TextInputType.none : TextInputType.number,
          forceErrorState: forceErrorState,
          //errorText: errorText,
          //errorTextStyle: context.typography.body12M.copyWith(color: AppColor.danger),
        ),
        8.heightBox,
        if (forceErrorState)
          Text(errorText ?? '',
              style:
                  context.typography.body12M.copyWith(color: AppColor.danger)),
      ],
    );
  }
}
