import 'package:sex_g_app/export.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonizer extends StatefulWidget {
  const AppSkeletonizer(
      {super.key, required this.child, this.isEnabled = false});

  final Widget child;
  final bool isEnabled;

  @override
  State<AppSkeletonizer> createState() => _AppSkeletonizerState();
}

class _AppSkeletonizerState extends State<AppSkeletonizer> {
  Color get baseColor => context.isDark
      ? AppColor.colorHex('97A8FF')
      : AppColor.colorHex('E6E6E6');

  Color get highlightColor => context.isDark
      ? AppColor.colorHex('0E1539')
      : AppColor.colorHex('B4B4B4');

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        effect: PulseEffect(from: baseColor, to: highlightColor),
        enabled: widget.isEnabled,
        child: widget.child);
  }
}
