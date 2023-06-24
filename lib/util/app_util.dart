import 'package:intl/intl.dart';

class AppUtil{
  static String getFormattedDate(DateTime date)
  {
    final DateFormat formatter = DateFormat('MMM dd,yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }


}
enum TaskType{personal,business}
