import 'package:sex_g_app/export.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(color: AppColor.primary));
  }
}
