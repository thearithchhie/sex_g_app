import 'package:sex_g_app/export.dart';

class BaseBlocState<T> {
  final AppStateStatus stateStatus;
  final String? message;
  final T? data;
  final List<T>? list;

  BaseBlocState({
    this.stateStatus = AppStateStatus.none,
    this.message,
    this.data,
    this.list,
  });

  BaseBlocState<T> copyWith({
    AppStateStatus? stateStatus,
    bool? isShowBarUnderMaintenance,
    String? message,
    T? data,
    List<T>? list,
  }) {
    return BaseBlocState<T>(
      stateStatus: stateStatus ?? this.stateStatus,
      message: message ?? this.message,
      data: data ?? this.data,
      list: list ?? this.list,
    );
  }
}
