import 'package:cached_network_image/cached_network_image.dart';
import 'package:dv_pay_mobile/src/utilities/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAvatarWidget extends StatelessWidget {
  final String? avatar;
  final double radius;

  const CustomAvatarWidget({super.key, this.avatar, this.radius = 20});

  static const String route = "/CustomAvatarWidget";

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColor.grey.withAlpha(70),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(radius * 2),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: avatar ?? '',
            progressIndicatorBuilder: (context, url, downloadProgress) => CupertinoActivityIndicator(),
            errorWidget: (_, __, ___) {
              return Image.asset('assets/icons/no-avatar.jpg');
            },
          ),
        ),
      ),
    );
  }
}

class CustomAvatarUploadWidget extends StatelessWidget {
  final String? avatar;
  final double radius;

  const CustomAvatarUploadWidget({super.key, this.avatar, this.radius = 20});

  static const String route = "/CustomAvatarWidget";

  @override
  Widget build(BuildContext context) {
    return avatar != null && avatar!.isNotEmpty
        ? CircleAvatar(
          radius: radius,
          backgroundColor: AppColor.grey.withAlpha(70),
          // backgroundImage: AssetImage('assets/icons/upload.png'),
          foregroundImage: NetworkImage(avatar!),
        )
        : Container(
          width: radius * 2.2,
          height: radius * 2.2,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffDBDBDB)),
          padding: EdgeInsets.all(radius * .45),
          child: SizedBox(child: Image.asset('assets/icons/upload.png', fit: BoxFit.fitHeight)),
        );
  }
}

class CustomAvatarSquare extends StatelessWidget {
  final String? avatar;
  final double radius;
  final double size;

  const CustomAvatarSquare({super.key, required this.avatar, this.radius = 0, this.size = 40});

  static const String route = "/CustomAvatarSquare";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: '$avatar',
          errorWidget: (context, _, __) {
            return Image.asset("assets/icons/no-avatar.jpg", fit: BoxFit.cover, height: size, width: size);
          },
        ),
      ),
    );
  }
}
