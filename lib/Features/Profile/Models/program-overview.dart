import '../../../Core/Models/global.dart';

class MyProgramOverviewModel {
  final String id,
      title,
      decription,
      seriesCount,
      workoutCount,
      donePercent,
      next;
  MyProgramOverviewModel({
    required this.id,
    required this.title,
    required this.decription,
    required this.seriesCount,
    required this.donePercent,
    required this.workoutCount,
    required this.next,
  });

  factory MyProgramOverviewModel.fromJson(Map datas) {
    for (var item in datas.keys) {
      print(item);
      print(datas[item]);
    }
    String nextTime = '';
    String donePercent = '';

    try {
      String day = GlobalEntity.dataFilter(
          datas['schedule']['schedule'][0]['day_of_week']);
      String hour =
          GlobalEntity.dataFilter(datas['schedule']['schedule'][0]['time']);
      nextTime = day + ' : ' + hour;
    } catch (e) {}
    try {
      donePercent = GlobalEntity.dataFilter(datas['schedule']['done_percent']);
    } catch (e) {}
    return MyProgramOverviewModel(
      id: GlobalEntity.dataFilter(datas['id']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      seriesCount: GlobalEntity.dataFilter(datas['series_count']),
      donePercent: donePercent,
      workoutCount: GlobalEntity.dataFilter(datas['workouts_count']),
      next: nextTime,
    );
  }
}
