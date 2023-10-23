import '../bloc_exports.dart';

part 'verify_profile_event.dart';
part 'verify_profile_state.dart';

class VerifyProfileBloc extends Bloc<VerifyProfileEvent, VerifyProfileState> {
  VerifyProfileBloc() : super(VerifyProfileInitial()) {
    on<VerifyProfileEvent>((event, emit) {});
  }
}
