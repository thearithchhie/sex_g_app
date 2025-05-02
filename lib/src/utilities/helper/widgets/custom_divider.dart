import 'package:sex_g_app/export.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: app.isDark ? const Color(0xffDDE8FC).withAlpha(50) : Colors.grey,
        thickness: 0.2);
  }
}
