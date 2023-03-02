import 'dart:async';

import 'package:champya/Core/Config/app_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Program/Models/program.dart';

class WorkoutProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  final WorkoutRowModel workout;

  int currentRoundIndex = 0;
  int timerValue = 0;
  late Timer globalTimer;
  void startTimer() async {
    try {
      globalTimer.cancel();
    } catch (e) {}
    timerValue = 0;
    const oneSec = Duration(seconds: 1);
    await AppSession.audioPlayer.setAsset('assets/Media/train.mp3');
    AppSession.audioPlayer.play();
    globalTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        timerValue += 1;
        notifyListeners();
      },
    );
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  changeTimerStatus(bool isPause) {
    if (isPause) {}
  }

  changeCurrentRoundIndex(BuildContext context) {
    currentRoundIndex += 1;
    if (currentRoundIndex >= int.parse(workout.set)) {
      Navigator.of(context).pop();
    } else {
      startTimer();
      notifyListeners();
    }
  }

  WorkoutProvider(this.workout);
  getDatas(BuildContext context, {bool resetPage = false}) async {}
  @override
  void reassemble() {}
  @override
  void dispose() {
    try {
      globalTimer.cancel();
    } catch (e) {}
    try {
      AppSession.audioPlayer.stop();
    } catch (e) {}
    super.dispose();
  }
}
