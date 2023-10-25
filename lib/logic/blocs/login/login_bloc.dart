import '../bloc_exports.dart';
import '../../../data/model/model_exports.dart';
import '../../../data/repository/repository_exports.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository apiRepository, required bool rememberMe})
      : super(LoginInitial()) {
    on<LoginClearEvent>((event, emit) => LoginInitial());
    on<LoginClickedEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final login = await apiRepository.loginVendor(
            email: event.email, password: event.password);

        print('This is the error ${login.error}');
        if (login.success == 0) {
          print(login.message);
          emit(LoginError(message: login.message));
          return;
        }
        if (login.error != null) {
          emit(LoginError(message: login.error));
          return;
        }
        emit(LoginLoaded(successModel: login, rememberMe: event.rememberMe));
      } catch (Exception) {
        emit(LoginError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<LoginState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  LoginState fromJson(Map<String, dynamic> json) {
    try {
      return LoginLoaded.fromMap(json);
    } catch (e) {
      return LoginInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    if (state is LoginLoaded) {
      return state.toMap();
    }
    return {};
  }
}
