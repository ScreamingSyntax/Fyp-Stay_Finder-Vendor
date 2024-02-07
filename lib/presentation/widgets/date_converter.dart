import 'package:intl/intl.dart';

String convertToYYYYMMDD(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);

  DateFormat formatter = DateFormat('yyyy-MM-dd');

  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}
