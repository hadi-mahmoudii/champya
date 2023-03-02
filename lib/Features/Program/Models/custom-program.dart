import 'dart:developer';

import '../../../Core/Models/global.dart';

class CustomProgramModel {
  final String id, title, decription, image, workoutCount, period, categoryName;
  List<SerieRowModel> series;

  CustomProgramModel(
      {required this.id,
      required this.image,
      required this.title,
      required this.decription,
      required this.series,
      required this.workoutCount,
      required this.period,
      required this.categoryName});

  factory CustomProgramModel.fromJson(Map datas) {
    log(datas.toString());
    List<SerieRowModel> series = [];
    try {
      datas['series'].forEach((element) {
        series.add(SerieRowModel.fromJson(element));
      });
    } catch (_) {}
    return CustomProgramModel(
      id: GlobalEntity.dataFilter(datas['id']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      workoutCount: GlobalEntity.dataFilter(datas['workouts_count']),
      period: GlobalEntity.dataFilter(datas['period']),
      categoryName: GlobalEntity.dataFilter(datas['sport_category']['name']),
      series: series,
    );
  }
}

class SerieRowModel {
  final String id, time, name;
  final int repeat;
  final List<WorkoutRowModel> workouts;
  SerieRowModel({
    required this.id,
    required this.time,
    required this.workouts,
    required this.repeat,
    required this.name,
  });
  factory SerieRowModel.fromJson(Map datas) {
    List<WorkoutRowModel> workouts = [];
    try {
      datas['workouts'].forEach((element) {
        workouts.add(WorkoutRowModel.fromJson(element));
      });
    } catch (_) {}

    int repeat = 0;
    try {
      repeat = datas['repeat'];
      if (repeat > 7) {
        repeat = 7;
      }
    } catch (e) {}
    return SerieRowModel(
      id: GlobalEntity.dataFilter(datas['id']),
      time: GlobalEntity.dataFilter(datas['estimate_time']),
      name: GlobalEntity.dataFilter(datas['name']),
      repeat: repeat,
      // time: '0',
      workouts: workouts,
    );
  }
}

class WorkoutRowModel {
  final String id, name, decription, set, perSet, image, time, video;

  WorkoutRowModel({
    required this.id,
    required this.name,
    required this.decription,
    required this.set,
    required this.perSet,
    required this.image,
    required this.time,
    required this.video,
  });

  factory WorkoutRowModel.fromJson(Map datas) {
    // for (var item in datas.keys) {
    //   print(item);
    //   print(datas[item]);
    // }
    return WorkoutRowModel(
      id: GlobalEntity.dataFilter(datas['id']),
      name: GlobalEntity.dataFilter(datas['name']),
      decription: GlobalEntity.dataFilter(datas['description']),
      set: GlobalEntity.dataFilter(datas['set']),
      perSet: GlobalEntity.dataFilter(datas['per_set']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      time: GlobalEntity.dataFilter(datas['suggested_time']),
      video: GlobalEntity.dataFilter(datas['video']),
    );
  }
}
