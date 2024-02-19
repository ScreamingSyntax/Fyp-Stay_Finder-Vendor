import 'package:dio/dio.dart';
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
      print("This is the response data ${responseData}");
      if (responseData['success'] == 1) {
        List<Accommodation> accommodations = List.from(responseData['data'])
            .map((e) => Accommodation.fromMap(e))
            .toList();
        return accommodations;
      }
      return [Accommodation.withError(error: "Something wen't wrong")];
    } catch (e) {
      print(e);
      return [Accommodation.withError(error: "Connection Error")];
    }
  }

  Future<Success> reSubmitForVerification(
      {required int accommodationId, required String token}) async {
    try {
      final url = "${getIp()}accommodation/reVerify/";
      final request = await http.post(Uri.parse(url),
          body: jsonEncode({'accommodation': accommodationId}),
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json; charset=UTF-8'
          });
      final response = json.decode(request.body);
      return Success.fromMap(response);
    } catch (e) {
      return Success(
          success: 0, message: "Please check your internet connection");
    }
  }

  Future<Success> hotelWithTierAdditionApi(
      {required Accommodation accommodation,
      required Map<int, Tier>? tier,
      required Map<int, List<Room>>? rooms,
      required File? accommodationImage,
      required Map<int, File> tierImages,
      required String token}) async {
    try {
      final accommodationUrl = Uri.parse("${getIp()}accommodation/hotel/");
      print(accommodationUrl);
      final accommodationRequest =
          http.MultipartRequest('POST', accommodationUrl);
      accommodationRequest.headers['Authorization'] = 'Token ${token}';
      accommodationRequest.fields['name'] = accommodation.name!;
      accommodationRequest.fields['has_tier'] = 'true';
      accommodationRequest.fields['parking_availability'] =
          accommodation.parking_availability.toString();
      accommodationRequest.fields['swimming_pool_availability'] =
          accommodation.swimming_pool_availability.toString();
      accommodationRequest.fields['latitude'] = "ad";
      accommodationRequest.fields['longitude'] = "ad";
      accommodationRequest.fields['type'] = "hotel";
      accommodationRequest.fields['address'] = accommodation.address!;
      accommodationRequest.fields['gym_availability'] =
          accommodation.gym_availability!.toString();
      accommodationRequest.fields['city'] = accommodation.city!.toString();
      accommodationRequest.files.add(http.MultipartFile(
        'image',
        accommodationImage!.readAsBytes().asStream(),
        accommodationImage.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', '*'),
      ));
      final streamedReponse = await accommodationRequest.send();
      final response = await http.Response.fromStream(streamedReponse);
      final body = jsonDecode(response.body);
      int id = body['message']['id'];
      List<int> tiersList = tier!.keys.toList();
      final tierUrl = Uri.parse("${getIp()}accommodation/hotel/tier/");
      tiersList.forEach((element) async {
        final hotelTierRequest = http.MultipartRequest('POST', tierUrl);
        hotelTierRequest.fields['tier_name'] = tier[element]!.name!;
        hotelTierRequest.fields['accommodation_id'] = id.toString();
        hotelTierRequest.fields['description'] = tier[element]!.description!;
        hotelTierRequest.headers['Authorization'] = 'Token ${token}';
        hotelTierRequest.fields['has_tier'] = 'true';

        hotelTierRequest.files.add(http.MultipartFile(
          'image',
          tierImages[element]!.readAsBytes().asStream(),
          tierImages[element]!.lengthSync(),
          filename: 'accommodation_image.jpg',
          contentType: MediaType('image', '*'),
        ));
        for (int i = 0; i < rooms![element]!.length; i++) {
          hotelTierRequest.fields['room[${i}][ac_availability]'] =
              rooms[element]![i].ac_availability!.toString();
          hotelTierRequest.fields['room[${i}][water_bottle_availability]'] =
              rooms[element]![i].water_bottle_availability!.toString();
          hotelTierRequest.fields['room[${i}][steam_iron_availability]'] =
              rooms[element]![i].steam_iron_availability!.toString();
          hotelTierRequest.fields['room[${i}][per_day_rent]'] =
              rooms[element]![i].monthly_rate!.toString();
          hotelTierRequest.fields['room[${i}][seater_beds]'] =
              rooms[element]![i].seater_beds!.toString();
          hotelTierRequest.fields['room[${i}][fan_availability]'] =
              rooms[element]![i].fan_availability!.toString();
          hotelTierRequest.fields['room[${i}][coffee_powder_availability]'] =
              rooms[element]![i].coffee_powder_availability!.toString();
          hotelTierRequest.fields['room[${i}][milk_powder_availability]'] =
              rooms[element]![i].milk_powder_availability!.toString();
          hotelTierRequest.fields['room[${i}][kettle_availability]'] =
              rooms[element]![i].kettle_availability!.toString();
          hotelTierRequest.fields['room[${i}][tv_availability]'] =
              rooms[element]![i].tv_availability!.toString();
          hotelTierRequest.fields['room[${i}][tea_powder_availability]'] =
              rooms[element]![i].tea_powder_availability!.toString();
          hotelTierRequest.fields['room[${i}][hair_dryer_availability]'] =
              rooms[element]![i].hair_dryer_availability!.toString();
        }
        final streamedReponse2 = await hotelTierRequest.send();
        final response2 = await http.Response.fromStream(streamedReponse2);
        final body2 = jsonDecode(response2.body);
        print(body2);
      });
      return Success(success: 1, message: "Successfully Added");
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> hostelWithoutTierAdditionApi(
      {required Accommodation accommodation,
      required List<Room?>? rooms,
      required File accommodationImage,
      required Map<int, List> roomImages,
      required String token}) async {
    print(token);
    try {
      final accommodationUrl = Uri.parse("${getIp()}accommodation/hotel/");
      print(accommodationUrl);
      final accommodationRequest =
          http.MultipartRequest('POST', accommodationUrl);
      accommodationRequest.headers['Authorization'] = 'Token ${token}';
      accommodationRequest.fields['name'] = accommodation.name!;
      accommodationRequest.fields['has_tier'] = 'false';
      accommodationRequest.fields['parking_availability'] =
          accommodation.parking_availability.toString();
      accommodationRequest.fields['swimming_pool_availability'] =
          accommodation.swimming_pool_availability.toString();
      accommodationRequest.fields['latitude'] = "ad";
      accommodationRequest.fields['longitude'] = "ad";
      accommodationRequest.fields['type'] = "hotel";
      accommodationRequest.fields['address'] = accommodation.address!;
      accommodationRequest.fields['gym_availability'] =
          accommodation.gym_availability!.toString();
      accommodationRequest.fields['city'] = accommodation.city!.toString();
      accommodationRequest.files.add(http.MultipartFile(
        'image',
        accommodationImage.readAsBytes().asStream(),
        accommodationImage.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', '*'),
      ));
      final streamedReponse = await accommodationRequest.send();
      final response = await http.Response.fromStream(streamedReponse);
      // print(jsonDecode(response.body));
      final body = jsonDecode(response.body);
      // print(body);
      int id = body['message']['id'];
      // print(id);
      final hotelUrl = Uri.parse("${getIp()}accommodation/hotel/nonTier/");
      final hostelRequest = http.MultipartRequest('POST', hotelUrl);
      hostelRequest.headers['Authorization'] = 'Token ${token}';
      hostelRequest.fields['accommodation_id'] = id.toString();
      for (int i = 0; i <= rooms!.length - 1; i++) {
        hostelRequest.fields['room[${i}][ac_availability]'] =
            rooms[i]!.ac_availability!.toString();
        hostelRequest.fields['room[${i}][water_bottle_availability]'] =
            rooms[i]!.water_bottle_availability!.toString();
        hostelRequest.fields['room[${i}][steam_iron_availability]'] =
            rooms[i]!.steam_iron_availability!.toString();
        hostelRequest.fields['room[${i}][per_day_rent]'] =
            rooms[i]!.monthly_rate!.toString();
        hostelRequest.fields['room[${i}][seater_beds]'] =
            rooms[i]!.seater_beds!.toString();
        hostelRequest.fields['room[${i}][fan_availability]'] =
            rooms[i]!.fan_availability!.toString();
        hostelRequest.fields['room[${i}][coffee_powder_availability]'] =
            rooms[i]!.hair_dryer_availability!.toString();
        hostelRequest.fields['room[${i}][milk_powder_availability]'] =
            rooms[i]!.milk_powder_availability!.toString();
        hostelRequest.fields['room[${i}][kettle_availability]'] =
            rooms[i]!.kettle_availability!.toString();
        hostelRequest.fields['room[${i}][tv_availability]'] =
            rooms[i]!.tv_availability!.toString();
        hostelRequest.fields['room[${i}][tea_powder_availability]'] =
            rooms[i]!.tea_powder_availability!.toString();
        hostelRequest.fields['room[${i}][hair_dryer_availability]'] =
            rooms[i]!.hair_dryer_availability!.toString();
        hostelRequest.files.add(http.MultipartFile(
          'room[${i}][image]',
          roomImages[i]![0].readAsBytes().asStream(),
          roomImages[i]![0].lengthSync(),
          filename: 'room_image_${i}.jpg',
          contentType: MediaType('image', '*'),
        ));
      }
      final streamedReponseTwo = await hostelRequest.send();
      final finalResponse = await http.Response.fromStream(streamedReponseTwo);
      print(finalResponse);
      final finalBody = jsonDecode(finalResponse.body);
      // print(finalBody);
      // return Success(success: 0, message: "Connection Error");
      if (finalBody['success'] == 1) {
        print("Yello");
        return Success(success: 1, message: finalBody['message']);
      }
      if (finalBody['success'] == 0) {
        return Success(success: 0, message: finalBody['message']);
      }
      return Success(success: 0, message: "Something went wrong");
    } catch (Exception) {
      print("a");
      return Success(success: 0, message: "Connection Error");
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
        roomImage3.readAsBytes().asStream(),
        roomImage3.lengthSync(),
        filename: 'room_image_2.jpg',
        contentType: MediaType('image', '*'),
      ));
      final streamedReponse = await request.send();
      final response = await http.Response.fromStream(streamedReponse);
      print(jsonDecode(response.body));
      final body = jsonDecode(response.body);
      print('This is body ${body}');
      if (body['success'] == 1) {
        return Success(success: 1, message: "Successfully Added");
      }

      return Success(success: 0, message: body['message']);
    } catch (Exception) {
      print(Exception);
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
