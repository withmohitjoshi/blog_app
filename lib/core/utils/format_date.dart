import 'package:intl/intl.dart';

String formateDateBydMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, YYYY").format(dateTime);
}
