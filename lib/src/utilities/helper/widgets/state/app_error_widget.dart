import 'package:sex_g_app/export.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(message ?? 'something_unexpected_went_wrong'.localize(),
              style: context.typography.body14Sb),
        ),
      ],
    );
  }
}
