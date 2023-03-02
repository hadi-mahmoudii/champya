import '../../../Core/Models/global.dart';

class WorkoutOverviewModel {
  final String id, name, decription, image, video;
  final String time, perSet, set;
  final bool hasBookmark;
  WorkoutOverviewModel(
      {required this.id,
      required this.name,
      required this.decription,
      required this.image,
      required this.time,
      required this.set,
      required this.perSet,
      required this.video,
      required this.hasBookmark});

  factory WorkoutOverviewModel.fromJson(Map datas) {
    bool hasBookmark = false;
    try {
      hasBookmark = datas['has_bookmark'];
    } catch (e) {}

    return WorkoutOverviewModel(
      id: GlobalEntity.dataFilter(datas['id']),
      name: GlobalEntity.dataFilter(datas['name']),
      decription: GlobalEntity.dataFilter(datas['description']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      video: GlobalEntity.dataFilter(datas['video']),
      time: GlobalEntity.dataFilter(datas['suggested_time']),
      set: GlobalEntity.dataFilter(datas['suggested_set']),
      perSet: GlobalEntity.dataFilter(datas['suggested_per_set']),
      hasBookmark: hasBookmark,
    );
  }
}
