// import 'package:shamsi_date/shamsi_date.dart';

class DateConvertor {
  // static dateToJalali(
  //   String date,
  // ) {
  //   int year = int.parse(date.split('/')[0]);
  //   int month = int.parse(date.split('/')[1]);
  //   int day = int.parse(date.split('/')[2]);
  //   DateTime dat = DateTime(year, month, day);
  //   Jalali g = Jalali.fromDateTime(dat);
  //   print(g.month);

  //   return g.year.toString() +
  //       '/' +
  //       g.month.toString() +
  //       '/' +
  //       g.day.toString();
  // }

  String convertWeekdayName(int day) {
    switch (day) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return '';
    }
  }

  String convertWeekdayNameS(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  static int compareDateFromNow(String date) {
    DateTime dat = DateTime.parse(date);
    DateTime curDat = dat.toLocal();
    return curDat.compareTo(DateTime.now());
  }
}
