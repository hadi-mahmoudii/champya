// import 'dart:developer';

import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Program/Models/program.dart';
import '../../Program/Models/train-day.dart';

class WorkingDayProgramProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  final TrainDayModel dayDatas;
  final String programId;

  WorkingDayProgramProvider(this.dayDatas, this.programId);

  List<SerieRowModel> series = [];

  getDatas(BuildContext context, {bool resetPage = false}) async {
    isLoading = true;
    notifyListeners();
    Either<ErrorResult, dynamic> result;
    for (var serie in dayDatas.series) {
      result = await ServerRequest().fetchData(
        Urls.getSerieDetails(serie.id),
      );
      result.fold(
        (error) async {
          // await ErrorResult.showDlg(error.type, context);
          isLoading = false;
          notifyListeners();
        },
        (result) {
          log(result['data'].toString());
          // log(result['data']['calender'].toString());
          // for (var item in result['data']['calender']) {
          //   for (var r in item) {
          //     log(r.toString());
          //   }
          //   log('-------------------');
          //   // print(result['data']['calender'][item]);
          // }
          final SerieRowModel serie = SerieRowModel.fromJson(result['data']);
          if (serie.workouts.isNotEmpty) {
            series.add(SerieRowModel.fromJson(result['data']));
          }
          // result['data'].forEach((element) {
          //   // print(element);
          //   programs.add(ProgramOverviewModel.fromJson(element));
          //   // print(result['children']);
          // });
          isLoading = false;
          notifyListeners();
        },
      );
    }
  }

  @override
  void reassemble() {}
}
