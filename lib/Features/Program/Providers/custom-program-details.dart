import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/datas.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/date_picker.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/static_bottom_selector.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Models/custom-program.dart';

class CustomProgramDetailsProvider extends ChangeNotifier
    with ReassembleHandler {
  bool isLoading = true;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  final String programId;

  late CustomProgramModel program;

  CustomProgramDetailsProvider(this.programId);
  getDatas(BuildContext context, {bool resetPage = false}) async {
    // print(programId);
    isLoading = true;
    notifyListeners();
    // print(Urls.cetprograms(selectedBrand.id));
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
        program = CustomProgramModel.fromJson(result['data']);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  createSerie(BuildContext context, TextEditingController nameCtrl,
      TextEditingController repeatCtrl) async {
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.createSerie(programId),
      datas: {
        'name': nameCtrl.text,
        'repeat': repeatCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // print(result);
        try {
          if (result['message']['title'] == 'Success') {
            Fluttertoast.showToast(msg: 'Your request was successful');
            Navigator.of(context).popAndPushNamed(
              Routes.customProgramDetails,
              arguments: program.id,
            );
            return;
          }
        } catch (e) {}
        try {
          if (result['errors'].keys.length != 0) {
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(
                msg: result['errors'][result['errors'].keys.toList()[0]][0]);
            return;
          }
        } catch (e) {}
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Some error happen!');
      },
    );
  }

  showAddSerieModal(BuildContext context) async {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController repeatCtrl = TextEditingController();
    // TextEditingController dayCtrl = TextEditingController();
    // TextEditingController timeCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        height: 400,
        margin: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: FilterWidget(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                SizedBox(height: 15),
                SimpleHeader(
                  mainHeader: 'ADD A SERIE',
                  subHeader: 'enter the serie details',
                ),
                SizedBox(height: 30),
                InputBox(
                  label: 'SERIE NAME',
                  controller: nameCtrl,
                ),
                SizedBox(height: 20),
                InputBox(
                  label: 'SERIE REPEAT',
                  controller: repeatCtrl,
                ),
                // SizedBox(height: 30),
                // StaticBottomSelector(
                //   label: 'CHOOSE A DAY',
                //   controller: dayCtrl,
                //   datas: daysList,
                // ),
                // SizedBox(height: 30),
                // StaticBottomSelector(
                //   label: 'CHOOSE A TIME',
                //   controller: timeCtrl,
                //   datas: timesList,
                // ),
                SizedBox(height: 25),
                SubmitButton(
                  func: () {
                    Navigator.of(context).pop();
                    createSerie(context, nameCtrl, repeatCtrl);
                  },
                  icon: null,
                  title: 'ADD THE SERIE',
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  startProgram(
    BuildContext context,
    List<List<TextEditingController>> daysCtrls,
    List<List<TextEditingController>> timeCtrls,
    TextEditingController currentTime,
    List<String> serieIdies,
  ) async {
    if (program.workoutCount == '0') {
      Fluttertoast.showToast(
          msg: 'You must choose a serie that have atleast 1 workout to do!');
      return;
    }
    Map<dynamic, dynamic> datas = {'start_at': currentTime.text};
    List rawDatas = [];
    isLoading = true;
    for (var i = 0; i < daysCtrls.length; i++) {
      for (var j = 0; j < daysCtrls[i].length; j++) {
        if (daysCtrls[i][j].text.isEmpty || timeCtrls[i][j].text.isEmpty) {
          Fluttertoast.showToast(msg: 'Fill all datas!');
          return;
        }
        rawDatas.add({
          'series_id': serieIdies[i],
          'day_of_week': daysCtrls[i][j].text,
          'time': timeCtrls[i][j].text,
        });
      }
    }
    // for (var i = 0; i < daysCtrls.length; i++) {
    //   rawDatas.add({
    //     'series_id': serieIdies[i],
    //     'day_of_week': daysCtrls[i].text,
    //     'time': timeCtrls[i].text,
    //   });
    //   // datas['series[$i][series_id]'] = serieIdies[i];
    //   // datas['series[$i][day_of_week]'] = daysCtrls[i].text;
    //   // datas['series[$i][time]'] = timeCtrls[i].text;
    // }
    Navigator.of(context).pop();
    isLoading = true;
    notifyListeners();
    datas['series'] = rawDatas;
    // print(datas);
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest()
        .sendData(Urls.startProgram(program.id), datas: datas);
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
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
            Fluttertoast.showToast(msg: 'Your request was successful');
            Navigator.of(context).pop();

            // Navigator.of(context).popUntil((route) => route.isFirst);
            // Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
            return;
          }
        } catch (e) {}
        try {
          if (result['errors'].keys.length != 0) {
            Navigator.of(context).pop();
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(
                msg: result['errors'][result['errors'].keys.toList()[0]][0]);
            return;
          }
        } catch (e) {}
        Navigator.of(context).pop();
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Some error happen!');
      },
    );
  }

  showStartProgramModal(BuildContext context) async {
    final themeData = Theme.of(context).textTheme;
    TextEditingController dateCtrl = TextEditingController();
    TextEditingController dateLabelCtrl = TextEditingController();

    // List<TextEditingController> dayCtrls = [];
    // List<TextEditingController> timeCtrls = [];
    List<List<TextEditingController>> dayCtrls = [];
    List<List<TextEditingController>> timeCtrls = [];
    List<String> serieIdies = [];

    // program.series.forEach((element) {
    //   dayCtrls.add(TextEditingController());
    //   timeCtrls.add(TextEditingController());
    //   serieIdies.add(element.id);
    // });
    bool letStart = true; //this use for check all series have workouts or not
    program.series.forEach((element) {
      if (element.workouts.length == 0) {
        letStart = false;
        return;
      }
      int serieRepeatCount = element.repeat;
      if (serieRepeatCount > 7) {
        serieRepeatCount = 7;
      }
      List<TextEditingController> dCtrls = [];
      List<TextEditingController> tCtrls = [];

      for (var i = 0; i < serieRepeatCount; i++) {
        dCtrls.add(TextEditingController());
        tCtrls.add(TextEditingController());
      }
      dayCtrls.add(dCtrls);
      timeCtrls.add(tCtrls);
      serieIdies.add(element.id);
    });
    if (!letStart) {
      Fluttertoast.showToast(msg: 'Please add workout to all series first!');
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (ctx) => FilterWidget(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(height: 15),
              SimpleHeader(
                mainHeader: 'BEGIN THE PROGRAM',
                subHeader: 'enter the series details',
              ),
              SizedBox(height: 15),
              DatePicker(
                color: mainFontColor,
                icon: Icons.calendar_today,
                label: 'BEGIN DATE',
                controller: dateCtrl,
                dateLabelCtrl: dateLabelCtrl,
                firstDate: DateTime.now(),
                lastDate: DateTime(2050),
              ),
              SizedBox(height: 30),
              LayoutBuilder(
                builder: (ctx, cons) => ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, ind) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: cons.maxWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${program.series[ind].name}',
                                style: themeData.headline3),
                            SizedBox(width: 6),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                color: Color(0XFFDDDDDD),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${program.series[ind].workouts.length} WORKOUT',
                                textAlign: TextAlign.center,
                                style: themeData.bodyText1!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 3),
                            program.series[ind].time.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0XFFDDDDDD),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '${program.series[ind].time} EST. TIME',
                                      style: themeData.bodyText1!.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      // ListView.separated(itemBuilder: (ctx,index)=>, separatorBuilder: (ctx,index)=>SizedBox(height: 10), itemCount: program.series[ind].repeat)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, i) => SizedBox(
                          width: cons.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: StaticBottomSelector(
                                  label: 'CHOOSE A DAY',
                                  controller: dayCtrls[ind][i],
                                  datas: daysList,
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: StaticBottomSelector(
                                  label: 'CHOOSE A TIME',
                                  controller: timeCtrls[ind][i],
                                  datas: timesList,
                                ),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (ctx, i) => SizedBox(height: 15),
                        itemCount: program.series[ind].repeat,
                      ),
                    ],
                  ),
                  separatorBuilder: (program, ind) => SizedBox(height: 30),
                  itemCount: program.series.length,
                ),
              ),
              SizedBox(height: 25),
              SubmitButton(
                  func: () => startProgram(
                      context, dayCtrls, timeCtrls, dateCtrl, serieIdies),
                  icon: null,
                  title: 'BEGIN'),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  deleteProgram(BuildContext context) async {
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
                Urls.updateProgram(program.id),
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
                      Fluttertoast.showToast(msg: 'Program deleted');
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
