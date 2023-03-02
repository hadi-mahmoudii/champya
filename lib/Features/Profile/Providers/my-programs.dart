import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/custom-program-overview.dart';
import '../Models/program-overview.dart';

class MyProgramsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  int currentPage = 1;

  List<MyProgramOverviewModel> myPrograms = [];
  List<MyCustomProgramOverviewModel> myCustomPrograms = [];

  getPrograms(BuildContext context, {bool resetPage = false}) async {
    if (currentPage == 1) {
      myPrograms = [];
      myCustomPrograms = [];
      isLoading = true;
      // scrollController.jumpTo(0);
      notifyListeners();
    } else {
      isLoadingMore = true;
      notifyListeners();
    }
    // print(Urls.cetprograms(selectedBrand.id));
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getMyPrograms,
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // print(result);
        try {
          result['data'].forEach((element) {
            // print(element);
            myPrograms.add(MyProgramOverviewModel.fromJson(element));
            // print(result['children']);
          });
        } catch (e) {
          Fluttertoast.showToast(msg: 'Error to get datas!');
          Navigator.of(context).pop();
          return;
        }

        // isLoading = false;
        // notifyListeners();
      },
    );
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(Urls.getMyCustomPrograms);
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          myCustomPrograms.add(MyCustomProgramOverviewModel.fromJson(element));
          // print(result['children']);
        });
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void reassemble() {}
}
