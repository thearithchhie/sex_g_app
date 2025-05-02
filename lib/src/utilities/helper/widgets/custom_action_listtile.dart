import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dv_pay_mobile/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AccountListTileAction extends StatelessWidget {
  const AccountListTileAction({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.showPrefixIcon = true,
    this.trailing,
    this.subTitle,
  });
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool showPrefixIcon;
  final Widget? trailing;
  final Widget? subTitle;

  Widget trailingWidget() {
    if (trailing != null) {
      return trailing!;
    }
    return Assets.icons.arrowForward.image(width: 24, height: 30);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            if (showPrefixIcon) Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: context.textTheme.titleMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                if (subTitle != null) Padding(padding: const EdgeInsets.only(top: 4), child: subTitle!),
              ],
            ),
            const Spacer(),
            trailingWidget(),
          ],
        ),
      ),
    );
  }
}
