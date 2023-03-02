import '../../../Core/Models/global.dart';

class MyCustomProgramOverviewModel {
  final String id, title, decription, seriesCount, workoutCount;
  MyCustomProgramOverviewModel({
    required this.id,
    required this.title,
    required this.decription,
    required this.seriesCount,
    required this.workoutCount,
  });

  factory MyCustomProgramOverviewModel.fromJson(Map datas) {
    // for (var item in datas.keys) {
    //   print(item);
    //   print(datas[item]);
    // }
    return MyCustomProgramOverviewModel(
      id: GlobalEntity.dataFilter(datas['id']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      seriesCount: GlobalEntity.dataFilter(datas['series_count']),
      workoutCount: GlobalEntity.dataFilter(datas['workouts_count']),
    );
  }
}
