import '../../../Core/Models/global.dart';

class ProgramOverviewModel {
  final String id, title, decription, seriesCount, workoutCount, image, time;
  final bool hasBookmark;
  ProgramOverviewModel({
    required this.id,
    required this.title,
    required this.decription,
    required this.seriesCount,
    required this.image,
    required this.workoutCount,
    required this.time,
    required this.hasBookmark,
  });

  factory ProgramOverviewModel.fromJson(Map datas) {
    // log(datas.toString());
    bool hasBookmark = false;
    try {
      if (datas['has_bookmark'] == 1) {
        hasBookmark = true;
      }
    } catch (e) {}

    return ProgramOverviewModel(
      id: GlobalEntity.dataFilter(datas['id']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      seriesCount: GlobalEntity.dataFilter(datas['series_count']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      workoutCount: GlobalEntity.dataFilter(datas['workouts_count']),
      time: GlobalEntity.dataFilter(datas['period'], replacement: '-'),
      hasBookmark: hasBookmark,
    );
  }

  factory ProgramOverviewModel.fromHome(Map datas) {
    bool isBookmark;
    try {
      isBookmark = datas['has_bookmark'];
    } catch (e) {
      isBookmark = false;
    }
    return ProgramOverviewModel(
      id: GlobalEntity.dataFilter(datas['id']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      seriesCount:
          GlobalEntity.dataFilter(datas['series_count'], replacement: '0'),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      workoutCount:
          GlobalEntity.dataFilter(datas['workouts_count'], replacement: '0'),
      time: GlobalEntity.dataFilter(datas['period'], replacement: '-'),
      hasBookmark: isBookmark,
    );
  }
}
