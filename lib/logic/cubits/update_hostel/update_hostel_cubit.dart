import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../data/api/api_exports.dart';
import '../../../data/model/model_exports.dart';
import '../../../data/repository/hostel_repository.dart';

part 'update_hostel_state.dart';

class UpdateHostelCubit extends Cubit<UpdateHostelState> {
  UpdateHostelCubit() : super(UpdateHostelInitial());
  HostelRepository _hostelRepository = HostelRepository();

  void updateAccommodationDetail(
      {required String token,
      required Map<String, dynamic> accommodation}) async {
    emit(UpdateHostelLoading());
    Success success = await _hostelRepository.updateAccommodation(
        token: token, accommodation: accommodation);
    if (success.success == 0) {
      return emit(UpdateHostelErrorState(message: success.message!));
    }
    return emit(UpdateHostelSuccessState(message: success.message!));
  }

  void updateRoomImage(
      {required String token,
      required File FileImage,
      required int roomId,
      required int roomImageId}) async {
    emit(UpdateHostelLoading());
    Success success = await _hostelRepository.updateRoomImage(
        token: token,
        room_id: roomId,
        room_image_id: roomImageId,
        image: FileImage);
    if (success.success == 0) {
      return emit(UpdateHostelErrorState(message: success.message!));
    }
    return emit(UpdateHostelSuccessState(message: success.message!));
  }

  void updateAccommodationImage(
      {required String token,
      required File image,
      required int accommodationId}) async {
    emit(UpdateHostelLoading());
    Success success = await _hostelRepository.updateAccommodationImage(
        image: image, token: token, accommodationId: accommodationId);
    if (success.success == 0) {
      return emit(UpdateHostelErrorState(message: success.message!));
    }
    return emit(UpdateHostelSuccessState(message: success.message!));
  }

  void updateAccommodationRoomDetails(
      {required String token, required Map<String, dynamic> data}) async {
    print("This is the data from the ${data}");
    emit(UpdateHostelLoading());
    Success success =
        await _hostelRepository.updateHostelRooms(data: data, token: token);
    if (success.success == 0) {
      return emit(UpdateHostelErrorState(message: success.message!));
    }
    return emit(UpdateHostelSuccessState(message: success.message!));
  }

  void deleteRoom({required String token, required int room}) async {
    emit(UpdateHostelLoading());
    Success success =
        await _hostelRepository.deleteRoom(room: room, token: token);
    if (success.success == 0) {
      return emit(UpdateHostelErrorState(message: success.message!));
    }
    return emit(UpdateHostelSuccessState(message: success.message!));
  }

  void addHostelRoom({
    required String token,
    required accommodationId,
    required File image1,
    required File image2,
    required int seaterBeds,
    required String washroom_status,
    required bool fan_availability,
    required int monthly_rate,
  }) async {
    emit(UpdateHostelLoading());
    Success success = await _hostelRepository.addHostelRoom(
        token: token,
        accommodationId: accommodationId,
        image1: image1,
        image2: image2,
        seaterBeds: seaterBeds,
        washroom_status: washroom_status,
        fan_availability: fan_availability,
        monthly_rate: monthly_rate);
    if (success.success == 0) {
      return emit(UpdateHostelErrorState(message: success.message!));
    }
    return emit(UpdateHostelSuccessState(message: success.message!));
  }

  @override
  void onChange(Change<UpdateHostelState> change) {
    print(
        "The current state is ${change.currentState} and next sate is ${change.nextState}");
    super.onChange(change);
  }
}
