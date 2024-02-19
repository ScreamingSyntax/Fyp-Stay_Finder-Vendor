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
