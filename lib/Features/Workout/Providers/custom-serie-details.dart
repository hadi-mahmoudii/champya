import 'dart:developer';

import 'package:champya/Core/Config/app_session.dart';
import 'package:champya/Core/Config/urls.dart';
import 'package:champya/Core/Widgets/error_result.dart';
import 'package:champya/Features/Program/Models/custom-program.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Models/server_request.dart';

class CustomSerieDetailsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  final SerieRowModel serie;
  final String programId;

  CustomSerieDetailsProvider(this.serie, this.programId);

  getDatas(BuildContext context, {bool resetPage = false}) async {}
  @override
  void reassemble() {}

  deleteSerie(BuildContext context) async {
    // print(Urls.removeSerieFromCustomProgram(serie.id));
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
                Urls.removeSerieFromCustomProgram(serie.id),
              );
              result.fold(
                (error) async {
                  await ErrorResult.showDlg(error.type!, context);
                },
                (result) async {
                  log(result.toString());
                  try {
                    if (result['errors'].isNotEmpty) {
                      Fluttertoast.showToast(msg: result['errors'][0]);
                      Navigator.of(context).pop();
                      isLoading = false;
                      notifyListeners();
                      return;
                    }
                  } catch (e) {}
                  try {
                    if (result['message']['title'] == 'Success') {
                      Fluttertoast.showToast(msg: 'Serie deleted');
                      Navigator.of(context).pop();
                      Navigator.of(context).popAndPushNamed(
                        Routes.customProgramDetails,
                        arguments: programId,
                      );
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
}
