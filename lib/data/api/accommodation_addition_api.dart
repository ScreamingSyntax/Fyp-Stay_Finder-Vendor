import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:http/http.dart' as http;
import './api_exports.dart';
import '../model/model_exports.dart';

class AccommodationAdditionApi {
  Future<List<Accommodation>> fetchAccommodation(
      {required String token}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/");
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${token}'
      });
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        List<Accommodation> accommodations = List.from(responseData['data'])
            .map((e) => Accommodation.fromMap(e))
            .toList();
        return accommodations;
      }
      return [Accommodation.withError(error: "Something wen't wrong")];
    } catch (Exception) {
      return [Accommodation.withError(error: "Connection Error")];
    }
  }

  Future<Success> rentalHostelAddition(
      {required Accommodation accommodation,
      required String token,
      required Room room,
      required File accommodationImage,
      required File roomImage1,
      required File roomImage2,
      required File roomImage3}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/rental_room/");
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Token ${token}';
      request.fields['accommodation[name]'] = accommodation.name!;
      request.fields['accommodation[city]'] = accommodation.city!;
      request.fields['accommodation[address]'] = accommodation.address!;
      request.fields['accommodation[longitude]'] = "dada";
      request.fields['accommodation[latitude]'] = "dada";
      request.fields['accommodation[number_of_washroom]'] =
          accommodation.number_of_washroom.toString();
      request.fields['accommodation[type]'] = accommodation.type!;
      request.fields['accommodation[trash_dispose_availability]'] =
          accommodation.trash_dispose_availability.toString();
      request.fields['accommodation[parking_availability]'] =
          accommodation.parking_availability.toString();
      request.fields['accommodation[monthly_rate]'] =
          accommodation.monthly_rate.toString();
      request.fields['room[fan_availability]'] =
          room.fan_availability.toString();
      request.fields['room[bed_availability]'] =
          room.bed_availability.toString();
      request.fields['room[sofa_availability]'] =
          room.bed_availability.toString();
      request.fields['room[mat_availability]'] =
          room.mat_availability.toString();
      request.fields['room[carpet_availability]'] =
          room.mat_availability.toString();
      request.fields['room[washroom_status]'] = room.washroom_status.toString();

      request.fields['room[dustbin_availability]'] =
          room.dustbin_availability.toString();
      request.files.add(http.MultipartFile(
        'accommodation[image]',
        accommodationImage.readAsBytes().asStream(),
        accommodationImage.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', '*'),
      ));
      request.files.add(http.MultipartFile(
        'room_image[0]',
        roomImage1.readAsBytes().asStream(),
        roomImage1.lengthSync(),
        filename: 'room_image_1.jpg',
        contentType: MediaType('image', '*'),
      ));
      request.files.add(http.MultipartFile(
        'room_image[1]',
        roomImage2.readAsBytes().asStream(),
        roomImage2.lengthSync(),
        filename: 'room_image_2.jpg',
        contentType: MediaType('image', '*'),
      ));
      request.files.add(http.MultipartFile(
        'room_image[2]',
        roomImage2.readAsBytes().asStream(),
        roomImage2.lengthSync(),
        filename: 'room_image_2.jpg',
        contentType: MediaType('image', '*'),
      ));
      final streamedReponse = await request.send();
      final response = await http.Response.fromStream(streamedReponse);
      print(jsonDecode(response.body));
      final body = jsonDecode(response.body);
      if (body['success'] == 1) {
        return Success(success: 1, message: "Successfully Added");
      }

      return Success(success: 0, message: body['message']);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> addHostelRoomAddition(
      {required Accommodation accommodation,
      required List<Room?> room,
      required Map<int, List> roomImages,
      required File accommodationImage,
      required String token}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/hostel/");
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Token ${token}';
      request.fields['accommodation[name]'] = accommodation.name!;
      request.fields['accommodation[city]'] = accommodation.city!;
      request.fields['accommodation[address]'] = accommodation.address!;
      request.fields['accommodation[longitude]'] = "aadda";
      request.fields['accommodation[latitude]'] = "ada";
      request.fields['accommodation[type]'] = accommodation.type!;
      request.fields['accommodation[number_of_washroom]'] =
          accommodation.number_of_washroom!.toString();
      request.fields['accommodation[parking_availability]'] =
          accommodation.parking_availability!.toString();
      request.fields['accommodation[meals_per_day]'] =
          accommodation.meals_per_day!.toString();
      request.fields['accommodation[weekly_non_veg_meals]'] =
          accommodation.weekly_non_veg_meals!.toString();
      request.fields['accommodation[weekly_laundry_cycles]'] =
          accommodation.weekly_laundry_cycles!.toString();
      request.fields['accommodation[admission_rate]'] =
          accommodation.monthly_rate.toString();
      request.fields['accommodation[weekly_non_veg_meals]'] =
          accommodation.weekly_non_veg_meals.toString();
      request.files.add(http.MultipartFile(
        'accommodation[image]',
        accommodationImage.readAsBytes().asStream(),
        accommodationImage.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', '*'),
      ));
      print('This is the room here nigga $room');
      for (int i = 0; i < room.length; i++) {
        request.fields['room[${i}][washroom_status]'] =
            room[i]!.washroom_status.toString();
        request.fields['room[${i}][fan_availability]'] =
            room[i]!.fan_availability.toString();
        request.fields['room[${i}][seater_beds]'] =
            room[i]!.seater_beds.toString();
        request.fields['room[${i}][monthly_rate]'] =
            room[i]!.monthly_rate.toString();
      }

      // print("This is count ${1}");
      int totalLength = 0;
      List<File> allImages = [];

      roomImages.forEach((key, value) {
        totalLength += value.length;
        value.forEach((element) {
          allImages.add(element);
        });
      });
      print(allImages);

      for (int i = 1; i <= allImages.length; i++) {
        print(i);
        request.files.add(http.MultipartFile(
          'room_image[0][${i}]',
          allImages[i - 1].readAsBytes().asStream(),
          allImages[i - 1].lengthSync(),
          filename: 'room_image_$i.jpg',
          contentType: MediaType('image', '*'),
        ));
      }
      final streamedReponse = await request.send();
      final response = await http.Response.fromStream(streamedReponse);
      final body = jsonDecode(response.body);
      if (body['success'] == 1) {
        return Success(success: 1, message: body['message']);
      }
      return Success(success: 0, message: body['message']);
    } catch (Exception) {
      return Success(success: 0, message: "Check your internet connection");
    }
  }
}
