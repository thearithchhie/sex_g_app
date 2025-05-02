import 'package:sex_g_app/export.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? label;
  final TextInputType? textInputType;
  final bool obscureText;
  final bool isOutLineBorder;
  final bool readOnly;
  final TextEditingController? controller;
  final FormStyle style;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final bool? isValidatePassword;
  final GestureTapCallback? onTap;
  final TextEditingController? confirmPassword;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    this.hintText = "Enter your text",
    this.textInputType,
    this.obscureText = false,
    this.isOutLineBorder = false,
    this.readOnly = false,
    this.controller,
    this.style = FormStyle.style1,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.label,
    this.onChanged,
    this.isValidatePassword,
    this.confirmPassword,
    this.onTap,
    this.validator,
  });

  static const String route = "/CustomTextField";

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    switch (widget.style) {
      case FormStyle.style2:
        return Container();
      default:
        return style1(context);
    }
  }

  Widget style1(BuildContext context) {
    final InputBorder bordered = OutlineInputBorder(
      borderSide: widget.isOutLineBorder
          ? BorderSide(
              color: app.isDark ? AppColor.pr900 : const Color(0xffA4A4A4),
              width: 1)
          : BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Container(
            margin: 5.pb(),
            child: Text(
              widget.label!,
              style: context.typography.body14B
                  .copyWith(color: app.isDark ? AppColor.primary : null),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          textAlign: TextAlign.start,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.readOnly,
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return null;
                  //return widget.hintText.localize();
                }
                if (widget.isValidatePassword == true) {
                  return validatePassword(value);
                }
                return null;
              },
          decoration: InputDecoration(
            hintText: widget.hintText.tr(),
            contentPadding: const EdgeInsets.all(15),
            hintStyle: context.typography.body12R.copyWith(
              color: app.isDark || !widget.isOutLineBorder
                  ? AppColor.primary
                  : const Color(0xffA4A4A4),
            ),
            filled: !widget.isOutLineBorder,
            errorStyle:
                context.typography.body12R.copyWith(color: AppColor.danger),
            fillColor: app.isDark || !widget.isOutLineBorder
                ? const Color(0xff353979)
                : const Color(0xffA4A4A4),
            errorBorder: bordered,
            focusedBorder: bordered,
            focusedErrorBorder: bordered,
            disabledBorder: bordered,
            enabledBorder: bordered,
            border: bordered,
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            suffix: widget.suffix,
            suffixIcon: widget.suffixIcon ?? visiblePassword(),
          ),
          keyboardType: widget.textInputType ?? TextInputType.text,
          obscureText: _obscureText,
        ),
      ],
    );
  }

  Widget visiblePassword() {
    if (widget.isValidatePassword == true) {
      return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (context.mounted) {
            setState(() {
              _obscureText = !_obscureText;
            });
          }
        },
        child: Image.asset(
          _obscureText
              ? Assets.icons.wallet.visible.path
              : Assets.icons.wallet.invisible.path,
          scale: 4,
        ),
      );
    }
    return const Offstage();
  }

  String? validatePassword(String value) {
    final passwordPattern1 = RegExp(r'(?=.*[a-z])');
    final passwordPattern2 = RegExp(r'(?=.*[A-Z])');
    final passwordPattern3 = RegExp(r'(?=.*\d)');
    final passwordPattern4 = RegExp(r'.{7,}'); // 7 or more characters

    if (!passwordPattern4.hasMatch(value)) {
      return "at_least_7_characters_(so_more_than_6)".localize();
    } else if (!passwordPattern1.hasMatch(value)) {
      return "at_least_one_lowercase_letter".localize();
    } else if (!passwordPattern2.hasMatch(value)) {
      return "at_least_one_uppercase_letter".localize();
    } else if (!passwordPattern3.hasMatch(value)) {
      return "at_least_one_digit_(number)".localize();
    }

    if (widget.confirmPassword?.text != value &&
        widget.confirmPassword?.text != null) {
      return "password_and_confirm_password_do_not_match".localize();
    }
    return null;
  }
}
