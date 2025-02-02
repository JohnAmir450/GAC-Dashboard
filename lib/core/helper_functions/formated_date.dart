import 'package:cloud_firestore/cloud_firestore.dart';

String formatOrderDateFromTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  return '$day/$month/$year';
}
String formatCurrentDate() {
  DateTime now = DateTime.now();
  List<String> monthNames = [
    "January", "February", "March", "April", "May", "June", 
    "July", "August", "September", "October", "November", "December"
  ];
  String year = now.year.toString();
  String month = monthNames[now.month - 1]; // Get month name

  return '$year-$month';
}
