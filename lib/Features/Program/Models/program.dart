import 'dart:developer';

import '../../../Core/Models/global.dart';

class OurProgramModel {
  final String id, title, decription, image;
  final TrainerModel trainer;
  List<SerieRowModel> series;

  OurProgramModel({
    required this.id,
    required this.image,
    required this.title,
    required this.decription,
    required this.trainer,
    required this.series,
  });

  factory OurProgramModel.fromJson(Map datas) {
    log(datas['trainer'].toString());
    List<SerieRowModel> series = [];
    try {
      datas['series'].forEach((element) {
        series.add(SerieRowModel.fromJson(element));
      });
    } catch (_) {}
    return OurProgramModel(
      id: GlobalEntity.dataFilter(datas['id']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      title: GlobalEntity.dataFilter(datas['title']),
      decription: GlobalEntity.dataFilter(datas['description']),
      trainer: TrainerModel.fromJson(datas['trainer']),
      series: series,
    );
  }
}

class TrainerModel {
  final String id,
      name,
      decription,
      weight,
      height,
      image,
      courseCount,
      age,
      nationality;

  TrainerModel({
    required this.id,
    required this.name,
    required this.decription,
    required this.weight,
    required this.height,
    required this.image,
    required this.courseCount,
    required this.age,
    required this.nationality,
  });

  factory TrainerModel.fromJson(Map datas) {
    log(datas.toString());
    String country = '-';
    try {
      country =
          GlobalEntity.dataFilter(datas['country']['name'], replacement: '-');
    } catch (e) {}
    return TrainerModel(
      id: GlobalEntity.dataFilter(datas['id']),
      name: GlobalEntity.dataFilter(datas['first_name']) +
          ' ' +
          GlobalEntity.dataFilter(datas['last_name']),
      decription: GlobalEntity.dataFilter(datas['details']),
      weight: GlobalEntity.dataFilter(datas['weight'], replacement: '-'),
      height: GlobalEntity.dataFilter(datas['height'], replacement: '-'),
      image: GlobalEntity.dataFilter(datas['profile']),
      age: GlobalEntity.dataFilter(datas['age'], replacement: '-'),
      courseCount: GlobalEntity.dataFilter(datas['created_courses_count']),
      nationality: country,
    );
  }
}

class SerieRowModel {
  final String id, time, repeat;
  final List<WorkoutRowModel> workouts;
  SerieRowModel({
    required this.id,
    required this.time,
    required this.repeat,
    required this.workouts,
  });
  factory SerieRowModel.fromJson(Map datas) {
    log(datas.toString());

    List<WorkoutRowModel> workouts = [];
    try {
      datas['workouts'].forEach((element) {
        workouts.add(WorkoutRowModel.fromJson(element));
      });
    } catch (_) {}
    return SerieRowModel(
      id: GlobalEntity.dataFilter(datas['id']),
      time: GlobalEntity.dataFilter(datas['estimate_time']),
      repeat: GlobalEntity.dataFilter(datas['repeat']),
      // time: '0',
      workouts: workouts,
    );
  }
}

class WorkoutRowModel {
  final String id,
      name,
      decription,
      set,
      perSet,
      image,
      time,
      video,
      trainerDescription;
  final bool hasBookmark;

  WorkoutRowModel({
    required this.id,
    required this.name,
    required this.decription,
    required this.set,
    required this.perSet,
    required this.image,
    required this.time,
    required this.video,
    required this.trainerDescription,
    required this.hasBookmark,
  });

  factory WorkoutRowModel.fromJson(Map datas) {
    bool hasBookmark = false;
    try {
      hasBookmark = datas['has_bookmark'];
    } catch (e) {}
    return WorkoutRowModel(
      id: GlobalEntity.dataFilter(datas['id']),
      name: GlobalEntity.dataFilter(datas['name']),
      decription: GlobalEntity.dataFilter(datas['description']),
      trainerDescription: GlobalEntity.dataFilter(datas['trainer_description']),
      set: GlobalEntity.dataFilter(datas['set']),
      perSet: GlobalEntity.dataFilter(datas['per_set']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      time: GlobalEntity.dataFilter(datas['estimate_time']),
      video: GlobalEntity.dataFilter(datas['video']),
      hasBookmark: hasBookmark,
    );
  }
}
