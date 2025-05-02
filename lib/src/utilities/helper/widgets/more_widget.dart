import 'package:sex_g_app/export.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({
    super.key,
    this.onTap,
    this.icon,
    this.isWhiteColor = false,
  });

  final GestureTapCallback? onTap;
  final IconData? icon;
  final bool isWhiteColor;

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      onTap: onTap,
      child: Icon(
        icon ?? Icons.more_horiz_outlined,
        size: 25,
        color: isWhiteColor ? AppColor.white : null,
      ),
    );
  }
}
