import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../Profile/Models/custom-program-overview.dart';
import '../Models/custom-program.dart';
import '../Models/workout-overview.dart';
import '../Widgets/serie-row.dart';

class AddWorkoutToProgramProvider extends ChangeNotifier
    with ReassembleHandler {
  bool isLoading = true;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  List<OptionModel> categories = [];

  final WorkoutOverviewModel workout;

  AddWorkoutToProgramProvider(this.workout);
  List<MyCustomProgramOverviewModel> myCustomPrograms = [];

  getPrograms(BuildContext context, {bool resetPage = false}) async {
    isLoading = true;
    notifyListeners();
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

  addProgram(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.createProgram,
      datas: {
        'sport_category_id': categories
            .firstWhere((element) => element.title == categoryCtrl.text)
            .id,
        'title': titleCtrl.text,
        'description': descriptionCtrl.text,
        // 'thumbnail': birthdayCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // print(result);
        try {
          if (result['data']['id'] != '') {
            Fluttertoast.showToast(msg: 'Program added');
            Navigator.of(context).pop();
            return;
          }
        } catch (e) {}
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Error!');
      },
    );
  }

  selectWorkDay(BuildContext context, String programId) async {
    final themeData = Theme.of(context).textTheme;
    isLoading = true;
    notifyListeners();
    // print(Urls.getMyCustomProgram(programId));
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getMyCustomProgram(programId),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // print(result);
        List<SerieRowModel> series = [];
        try {
          result['data']['series'].forEach((element) {
            series.add(SerieRowModel.fromJson(element));
          });
        } catch (_) {}
        if (series.length == 0) {
          Fluttertoast.showToast(msg: 'Add series first!');
          Navigator.of(context).pop();
        } else
        // program = CustomProgramModel.fromJson(result['data']);
        {
          print(workout.time);
          showModalBottomSheet(
            context: context,
            builder: (ctx) => FilterWidget(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    SizedBox(height: 15),
                    SimpleHeader(
                      mainHeader: 'WHICH Serie',
                      subHeader: 'SELECT ONE OF SERIES',
                    ),
                    SizedBox(height: 15),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, ind) => SerieRowSelector(
                              themeData: themeData,
                              serie: series[ind],
                              submitFunc: () async {
                                ServerRequest().sendData(
                                  Urls.addWorkoutToSerie(
                                      series[ind].id, workout.id),
                                  datas: {
                                    'set': workout.set,
                                    'per_set': workout.perSet,
                                    "description": workout.decription,
                                    "estimate_time": workout.time,
                                  },
                                );
                                Fluttertoast.showToast(msg: 'Added');
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                // result2.fold(
                                //   (error) async {
                                //     // await ErrorResult.showDlg(error.type, context);
                                //     isLoading = false;
                                //     notifyListeners();
                                //   },
                                //   (res) {
                                //     try {
                                //       if (res['errors'].keys.length != 0) {
                                //         isLoading = false;
                                //         notifyListeners();
                                //         Fluttertoast.showToast(
                                //             msg: res['errors'][res['errors']
                                //                 .keys
                                //                 .toList()[0]][0]);
                                //         return;
                                //       }
                                //     } catch (e) {}
                                //     try {
                                //       if (res['message']['title'] ==
                                //           'Success') {
                                //         Fluttertoast.showToast(msg: 'Added');
                                //       }
                                //     } catch (e) {
                                //       Fluttertoast.showToast(
                                //           msg: 'Some Error happen');
                                //     }
                                //   },
                                // );
                                // Navigator.of(context).pop();
                                // Navigator.of(context).pop();
                              },
                            ),
                        separatorBuilder: (ctx, ind) => SizedBox(height: 2),
                        itemCount: series.length),
                    SizedBox(height: 25),
                    // SubmitButton(
                    //   func: () async {
                    //     Navigator.of(context).pop();
                    //     Navigator.of(context).pop();
                    //   },
                    //   icon: null,
                    //   title: 'BEGIN',
                    // ),
                    // SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          );
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  @override
  void reassemble() {}
}
