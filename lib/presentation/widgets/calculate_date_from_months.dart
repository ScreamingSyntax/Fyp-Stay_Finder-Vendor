import 'package:intl/intl.dart';

String calculateDateFromMonths(String checkIn, int stayMonths) {
  DateFormat format = DateFormat("yyyy-MM-dd");
  DateTime checkInDate = format.parse(checkIn);
  DateTime checkOutDate = DateTime(
      checkInDate.year, checkInDate.month + stayMonths, checkInDate.day);
  String formattedCheckOutDate = DateFormat("yyyy-MM-dd").format(checkOutDate);

  return formattedCheckOutDate;
}
