import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Program/Models/program.dart';
import '../../Program/Models/train-day.dart';

class WorkPreprationProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  final List<SerieRowModel> series;
  final String programId;
  final TrainDayModel dayDatas;
  int currentSerieIndex = 0;
  int currentWorkOutIndex = 0;
  CountDownController timercontroller = CountDownController();

  changeIndexes(BuildContext context) async {
    int tempWorkoutIndex = currentWorkOutIndex + 1;
    if (tempWorkoutIndex < series[currentSerieIndex].workouts.length) {
      currentWorkOutIndex = tempWorkoutIndex;
      timercontroller.restart(initialPosition: 0);
    } else {
      isLoading = true;
      notifyListeners();
      // print(dayDatas.date);
      final Either<ErrorResult, dynamic> result =
          await ServerRequest().sendData(
        Urls.dayProgramSerieDone(programId, series[currentSerieIndex].id),
        datas: {
          'work_date': dayDatas.date,
          'time': dayDatas.series[currentSerieIndex].time,
        },
      );
      result.fold(
        (error) async {
          await ErrorResult.showDlg(error.type!, context);
          isLoading = false;
          notifyListeners();
        },
        (result) {
          print({
            'work_date': dayDatas.date,
            'time': dayDatas.series[currentSerieIndex].time,
          });
          print(result);
          // try {
          //   if (result['message']['title'] == 'موفق') {
          //     isLoading = false;
          //     codeSended = true;
          //     notifyListeners();
          //     return;
          //   }
          // } catch (e) {}
          try {
            if (result['errors']['email'][0] ==
                'The email must be a valid email address.') {
              isLoading = false;
              notifyListeners();
              Fluttertoast.showToast(
                  msg: 'The email must be a valid email address.');
              return;
            }
          } catch (e) {}
          isLoading = false;
          notifyListeners();
        },
      );
      int tempSerieIndex = currentSerieIndex + 1;
      if (tempSerieIndex < series.length) {
        currentSerieIndex = tempSerieIndex;
        currentWorkOutIndex = 0;
        timercontroller.restart(initialPosition: 5);
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
        Navigator.of(context).pushNamed(Routes.myPrograms);
        Fluttertoast.showToast(msg: 'Program Done');
        return;
      }
    }
    notifyListeners();
  }

  WorkPreprationProvider(
    this.series,
    this.programId,
    this.dayDatas,
  );

  getDatas(BuildContext context, {bool resetPage = false}) async {}
  @override
  void reassemble() {}
}
