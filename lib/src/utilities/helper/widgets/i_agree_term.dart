import 'package:sex_g_app/export.dart';
import 'package:flutter/gestures.dart';

class IAgreeTerm extends StatelessWidget {
  const IAgreeTerm({super.key, this.isAgree, this.onChanged});

  final bool? isAgree;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        RadioField(isChecked: isAgree ?? false, onChanged: onChanged),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: ('i_have_read_and_agreed_to_the'.localize()) + ' ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      onChanged?.call(!(isAgree ?? false));
                    },
                ),
                TextSpan(
                  text: 'terms_&_condition'.localize(),
                  style: context.typography.body12M.copyWith(
                    color: AppColor.pr500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.pr500,
                    decorationThickness: 2,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      app.showTerm(context);
                    },
                ),
              ],
            ),
            style: context.typography.body12R.copyWith(
                color: app.isDark ? AppColor.pr400 : AppColor.neutral900),
          ),
        ),
      ],
    );
  }
}
