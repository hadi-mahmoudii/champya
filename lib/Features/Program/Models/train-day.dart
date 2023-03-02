import 'package:champya/Core/Models/global.dart';

import '../../../Core/Models/date-convertor.dart';

class TrainDayModel {
  final String date, status;
  final List<TraindaySerieModel> series;

  TrainDayModel({
    required this.date,
    required this.status,
    required this.series,
  });

  factory TrainDayModel.fromJson(Map datas) {
    String date = '';
    List<TraindaySerieModel> series = [];
    try {
      datas['series'].forEach((element) {
        series.add(TraindaySerieModel.fromJson(element));
      });
    } catch (e) {}
    try {
      final datee = DateTime.parse(datas['date']);
      // log(datee.weekday.toString());
      date =
          '${DateConvertor().convertWeekdayNameS(datee.weekday)}, ${datee.day}/${datee.month}';
    } catch (e) {}
    // print(idies);
    return TrainDayModel(
      date: date,
      status: GlobalEntity.dataFilter(datas['day_status']),
      series: series,
    );
  }
  // final SerieRowModel series;
}

class TraindaySerieModel {
  final String id, day, time;

  TraindaySerieModel({
    required this.id,
    required this.day,
    required this.time,
  });

  factory TraindaySerieModel.fromJson(Map datas) {
    return TraindaySerieModel(
      id: GlobalEntity.dataFilter(datas['series_id']),
      day: GlobalEntity.dataFilter(datas['day_of_week']),
      time: GlobalEntity.dataFilter(datas['time']),
    );
  }
}
