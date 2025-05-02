import 'package:sex_g_app/export.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          Text(text.localize(),
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color:
                    app.isDark ? const Color(0xff05031C) : AppColor.neutral50,
                borderRadius: BorderRadius.circular(8)),
            child: Image.asset(Assets.icons.upload.path, scale: 4),
          ),
        ],
      ),
    );
  }
}
