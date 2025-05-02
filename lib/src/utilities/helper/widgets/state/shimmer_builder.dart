import 'package:sex_g_app/export.dart';

class ShimmerBuilder extends StatefulWidget {
  final List<Widget>? children;

  const ShimmerBuilder({super.key, this.children});

  @override
  State<ShimmerBuilder> createState() => _ShimmerBuilderState();
}

class _ShimmerBuilderState extends State<ShimmerBuilder> {
  Color get baseColor => context.isDark
      ? AppColor.colorHex('97A8FF')
      : AppColor.colorHex('E6E6E6');

  Color get highlightColor => context.isDark
      ? AppColor.colorHex('0E1539')
      : AppColor.colorHex('B4B4B4');

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 3500),
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(children: widget.children ?? [Container(color: baseColor)]),
    );
  }
}
