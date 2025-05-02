import 'package:sex_g_app/export.dart';

class ActionMenuItem extends StatelessWidget {
  const ActionMenuItem(
      {super.key, required this.path, required this.title, this.onTap});
  final String path;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(path, height: 48, width: 48),
          const SizedBox(height: 6),
          Text(title.localize(),
              textAlign: TextAlign.center,
              style: context.typography.caption10B),
        ],
      ),
    );
  }
}
