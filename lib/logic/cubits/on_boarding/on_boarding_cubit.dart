import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/on_boarding/on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> with HydratedMixin {
  OnBoardingCubit() : super(OnBoardingState(visitedOnBoarding: false));
  void visitedOnBoarding() => emit(OnBoardingState(visitedOnBoarding: true));
  OnBoardingState? fromJson(Map<String, dynamic> json) {
    return OnBoardingState.fromMap(json);
  }

  Map<String, dynamic> toJson(OnBoardingState state) {
    return state.toMap();
  }
}
