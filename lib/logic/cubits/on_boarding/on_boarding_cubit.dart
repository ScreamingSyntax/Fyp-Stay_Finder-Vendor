import '../cubit_exports.dart';

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
