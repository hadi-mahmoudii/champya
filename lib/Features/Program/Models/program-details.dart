import 'dart:developer';

import 'package:champya/Core/Models/date-convertor.dart';

import '../../../Core/Models/global.dart';
import 'train-day.dart';

class ProgramDetailsModel {
  final String id,
      title,
      decription,
      startDate,
      endDate,
      nextDate,
      donePercent,
      sessionLength,
      sessionPerWeek;

  final List<TrainDayModel> days;

  ProgramDetailsModel({
    required this.id,
    required this.title,
    required this.decription,
    required this.startDate,
    required this.endDate,
    required this.nextDate,
    required this.donePercent,
    required this.sessionLength,
    required this.sessionPerWeek,
    required this.days,
  });

  factory ProgramDetailsModel.fromJson(Map datas) {
    // log(AppSession.token);
    for (var data in datas.keys) {
      log(data.toString());
      log(datas[data].toString());
    }
    // log(datas['total_sessions_count'].toString());
    List<TrainDayModel> days = [];
    for (var rawItam in datas['calender']) {
      for (var data in rawItam) {
        days.add(TrainDayModel.fromJson(data));
        // log(data.toString());
      }
      // log('-------------------');
      // print(result['data']['calender'][item]);
    }
    String donePercent = '0';
    String sessionPerWeek = '1';
    String sessionLength = '1';
    String startDate = '2021-12-1';
    String endDate = '2021-12-1';
    String nextTime = '';

    try {
      donePercent = GlobalEntity.dataFilter(datas['schedule']['done_percent']);
      startDate = GlobalEntity.dataFilter(datas['schedule']['start_at']);
      endDate = GlobalEntity.dataFilter(datas['schedule']['end_at']);
      sessionLength = GlobalEntity.dataFilter(datas['total_sessions_count']);

      sessionPerWeek =
          GlobalEntity.dataFilter(datas['schedule']['workdays_per_week']);
      // String day = GlobalEntity.dataFilter(
      //     datas['schedule']['schedule'][0]['day_of_week']);
      // String hour =
      //     GlobalEntity.dataFilter(datas['schedule']['schedule'][0]['time']);
      // nextTime = 'NEXT: ' + day + ' , ' + hour;
      final datee = DateTime.parse(datas['next_work_date']);
      // log(datee.weekday.toString());
      nextTime =
          'next: ${DateConvertor().convertWeekdayName(datee.weekday)}, ${datee.day}.${datee.month}.${datee.year}';
    } catch (e) {}
    return ProgramDetailsModel(
      id: GlobalEntity.dataFilter(datas['id']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      startDate: startDate,
      endDate: endDate,
      donePercent: donePercent,
      sessionPerWeek: sessionPerWeek,
      sessionLength: sessionLength,
      days: days,
      nextDate: nextTime,
    );
  }
}
