import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/remember_me/remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeState> with HydratedMixin {
  RememberMeCubit() : super(RememberMeState(rememberMe: false));
  void rememberMeTicked(bool value) => emit(RememberMeState(rememberMe: value));

  @override
  RememberMeState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return RememberMeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(RememberMeState state) {
    return state.toMap(); // TODO: implement toJson
  }
}
