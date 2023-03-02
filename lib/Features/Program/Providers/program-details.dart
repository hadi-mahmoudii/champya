import 'dart:developer';

import 'package:champya/Core/Config/app_session.dart';
import 'package:champya/Core/Config/routes.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/program-details.dart';

class ProgramDetailsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = true;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  final String programId;

  ProgramDetailsProvider(this.programId);
  late ProgramDetailsModel? program;
  getDatas(BuildContext context, {bool resetPage = false}) async {
    isLoading = true;
    // scrollController.jumpTo(0);
    notifyListeners();

    // print(programId);
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getMyProgram(programId),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // log(result['data'].toString());
        // log(result['data']['calender'].toString());
        // for (var item in result['data']['calender']) {
        //   for (var r in item) {
        //     log(r.toString());
        //   }
        //   log('-------------------');
        //   // print(result['data']['calender'][item]);
        // }
        try {
          program = ProgramDetailsModel.fromJson(result['data']);
        } catch (e) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: 'Error see program details');
          return;
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

  stopProgram(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        content: const Text(
          'Are you sure?',
          // textDirection: TextDirection.rtl,
          style: TextStyle(color: mainFontColor),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              isLoading = true;
              notifyListeners();
              final Either<ErrorResult, dynamic> result =
                  await ServerRequest().deleteData(
                Urls.stopProgram(program!.id),
              );
              result.fold(
                (error) async {
                  await ErrorResult.showDlg(error.type!, context);
                },
                (result) async {
                  log(result.toString());
                  // print(result);
                  try {
                    if (result['message']['title'] == 'Success') {
                      Fluttertoast.showToast(
                          msg: 'Program stoped and removed.');
                      Navigator.of(context).pop();
                      Navigator.of(context).popAndPushNamed(Routes.myPrograms);
                      return;
                    }
                  } catch (e) {}
                  isLoading = false;
                  notifyListeners();
                  Fluttertoast.showToast(msg: 'Error!');
                },
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: mainFontColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: mainFontColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void reassemble() {}
}
