import 'package:sex_g_app/export.dart';

class GroupDocumentPhoto extends StatelessWidget {
  const GroupDocumentPhoto(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 12.p(),
      decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer, borderRadius: 12.r()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: context.typography.body14B
                  .copyWith(color: app.isDark ? AppColor.primary : null)),
          ...children
        ],
      ),
    );
  }
}
