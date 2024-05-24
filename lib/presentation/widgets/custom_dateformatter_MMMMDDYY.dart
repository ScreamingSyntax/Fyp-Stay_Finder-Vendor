import 'package:intl/intl.dart';

String formatDateTimeinMMMMDDYYY(String? dateTimeString) {
  if (dateTimeString == null) {
    return 'Date not available';
  }
  try {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
    return formattedDate;
  } catch (e) {
    return 'Invalid date format';
  }
}

String extractDateFromString(String dateTimeString) {
  dateTimeString = Uri.decodeFull(dateTimeString);
  String datePart = dateTimeString.split(' ')[0];
  print(datePart);
  return datePart;
}

String formatIntoTimeAmPm(String dateTimeString) {
  DateTime parsedDate = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h:mm a').format(parsedDate);
  return formattedTime;
  // print(formattedTime); // Output example: 4:00 PM
}
