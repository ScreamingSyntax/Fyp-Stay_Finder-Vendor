import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:http_parser/src/media_type.dart';

import '../model/model_exports.dart';

class ProfileVerificationApi {
  Future<Success> verifyProfile(
      {required File profilePicture,
      required File citizenshipFront,
      required File citizenshipBack,
      required String address,
      required String token}) async {
    try {
      print(profilePicture);
      print(citizenshipBack);
      print(citizenshipFront);
      print(address);
      print(token);

      final url = Uri.parse("${getIp()}vendor/verifedData/");

      final request = http.MultipartRequest(
        'PATCH',
        url,
      );
      request.headers['Authorization'] = 'Token ${token}';
      request.fields['address'] = address;
      request.fields['is_under_verification_process'] = 'True';

      request.files.add(http.MultipartFile(
        'citizenship_front',
        citizenshipFront.readAsBytes().asStream(),
        citizenshipFront.lengthSync(),
        filename: 'citizenship_front.jpg',
        contentType:
            MediaType('image', '*'), // Adjust the content type if needed
      ));

      request.files.add(http.MultipartFile(
        'citizenship_back',
        citizenshipBack.readAsBytes().asStream(),
        citizenshipBack.lengthSync(),
        filename: 'citizenship_back.jpg',
        contentType:
            MediaType('image', '*'), // Adjust the content type if needed
      ));

      request.files.add(http.MultipartFile(
        'profile_picture',
        profilePicture.readAsBytes().asStream(),
        profilePicture.lengthSync(),
        filename: 'profile_picture.jpg',
        contentType:
            MediaType('image', '*'), // Adjust the content type if needed
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(
        streamedResponse,
      );

      if (response.statusCode == 200) {
        return Success.fromMap(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Success.withError("Connection Issue");
      }
    } catch (err) {
      print(err);
      return Success.withError("Connection Issue");
    }
  }
}
