import 'package:intl/intl.dart';

class MyDateUtils {

    static String formatStringDate( String date, {String format = 'MMMM d'}) {
     return  DateFormat(format).format(DateTime.parse(date)).toString();
    }
  
}