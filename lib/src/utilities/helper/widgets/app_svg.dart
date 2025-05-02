import 'package:sex_g_app/export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final String? errorImageAsset;
  final double? width;
  final double? height;
  final Color? color;
  final bool isDefaultColor;
  final double? scale;

  const AppSvg(
    this.path, {
    this.fit = BoxFit.cover,
    this.errorImageAsset,
    this.width,
    this.height,
    this.color,
    this.isDefaultColor = true,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return app.extension(path) == 'svg'
        ? SvgPicture.asset(
            path,
            fit: fit,
            width: width,
            height: height,
            colorFilter: isDefaultColor
                ? null
                : ColorFilter.mode(
                    color ?? app.iconColor(context), BlendMode.srcIn),
          )
        : Image.asset(
            path,
            fit: fit,
            width: width,
            height: height,
            scale: scale,
            color: isDefaultColor ? null : (color ?? app.iconColor(context)),
          );
  }
}
