import 'package:champya/Core/Config/urls.dart';
import 'package:champya/Core/Models/server_request.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/error_result.dart';
import '../../Program/Models/workout-overview.dart';

class MyFavoritesProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  List bookmarks = [];
  List<WorkoutOverviewModel> workouts = [];

  getDatas(BuildContext context, {bool resetPage = false}) async {
    if (currentPage == 1) {
      bookmarks = [];
      isLoading = true;
      // scrollController.jumpTo(0);
      notifyListeners();
    } else {
      isLoadingMore = true;
      notifyListeners();
    }
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(Urls.getBookmarks);
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // log(result.toString());
        result['data'].forEach((element) {
          workouts.add(WorkoutOverviewModel.fromJson(element['workouts']));
        });
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void reassemble() {}
}
