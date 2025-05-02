import 'package:sex_g_app/export.dart';

class AppSateBuilder<T> extends StatelessWidget {
  final BaseBlocState<T> state;
  final Widget Function(T data) builder;

  const AppSateBuilder({super.key, required this.state, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (state.stateStatus == AppStateStatus.loading) {
      return const AppLoadingContainer();
    } else if (state.stateStatus == AppStateStatus.success) {
      return builder.call(state.data!);
    }
    return AppErrorWidget(message: state.message);
  }
}
