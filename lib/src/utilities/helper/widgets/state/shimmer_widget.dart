import 'package:sex_g_app/export.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isCircle;
  final double? radius;

  const ShimmerWidget(
      {super.key, this.width, this.height, this.isCircle = false, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.width,
      height: height ?? 10,
      decoration: BoxDecoration(
        color:
            context.isDark ? const Color(0xFF767676) : const Color(0xFFDCDCDC),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : (radius ?? 4).r(),
      ),
    );
  }
}
