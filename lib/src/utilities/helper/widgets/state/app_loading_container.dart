import 'package:sex_g_app/export.dart';

class AppLoadingContainer extends StatelessWidget {
  const AppLoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [AppLoadingWidget()],
      ),
    );
  }
}
