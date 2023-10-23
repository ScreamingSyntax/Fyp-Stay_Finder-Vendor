import '../cubit_exports.dart';

class RememberMeCubit extends Cubit<RememberMeState> with HydratedMixin {
  RememberMeCubit() : super(RememberMeState(rememberMe: false));
  void rememberMeTicked(bool value) => emit(RememberMeState(rememberMe: value));

  @override
  RememberMeState? fromJson(Map<String, dynamic> json) {
    return RememberMeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(RememberMeState state) {
    return state.toMap();
  }
}
