import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/datas.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/comment.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/date_picker.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/static_bottom_selector.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Models/program-overview.dart';
import '../Models/program.dart';

class OurProgramDetailsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = true;
  bool isLoadingComments = false;
  ScrollController scrollController = ScrollController();

  final ProgramOverviewModel programOverview;
  late OurProgramModel program;
  List<CommentModel> commnets = [];

  OurProgramDetailsProvider({required this.programOverview});

  getComments() async {
    commnets.clear();
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getComments('course', programOverview.id),
    );
    result.fold(
      (error) async {
        // isLoading = false;
        // notifyListeners();
      },
      (result) {
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          commnets.add(CommentModel.fromJson(element));
          // print(result['children']);
        });
      },
    );
  }

  getDatas(BuildContext context, {bool resetPage = false}) async {
    isLoading = true;
    // scrollController.jumpTo(0);
    notifyListeners();
    // print(Urls.getComments('course', programOverview.id));
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(
      Urls.getProgramDatas(programOverview.id),
    );
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) async {
        // print(result);
        try {
          program = OurProgramModel.fromJson(result['data']);
        } catch (e) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "There is a problem to fetch program's data!!");
          return;
        }
        // result['data'].forEach((element) {
        //   // print(element);
        //   programs.add(ProgramOverviewModel.fromJson(element));
        //   // print(result['children']);
        // });
        await getComments();
        isLoading = false;
        notifyListeners();
      },
    );
  }

  startProgram(
    BuildContext context,
    List<List<TextEditingController>> daysCtrls,
    List<List<TextEditingController>> timeCtrls,
    TextEditingController currentTime,
    List<String> serieIdies,
  ) async {
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

      // datas['series[$i][series_id]'] = serieIdies[i];
      // datas['series[$i][day_of_week]'] = daysCtrls[i].text;
      // datas['series[$i][time]'] = timeCtrls[i].text;
    }
    datas['series'] = rawDatas;
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
          if (result['data'][0] == 'please first verify email') {
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(msg: 'Verify your email!');
            return;
          }
        } catch (e) {}
        try {
          if (result['message']['title'] == 'Success') {
            Fluttertoast.showToast(msg: 'Your request was successful');
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
            return;
          }
        } catch (e) {}
        try {
          if (result['data'] ==
              'currently you are joined to this course currently') {
            Fluttertoast.showToast(msg: 'You are currently in this course!');
            isLoading = false;
            notifyListeners();
            // Navigator.of(context).popUntil((route) => route.isFirst);
            // Navigator.of(context).pushNamed(Routes.MainScreen);
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

  showStartProgramModal(BuildContext context) async {
    final themeData = Theme.of(context).textTheme;
    TextEditingController dateCtrl = TextEditingController();
    TextEditingController dateLabelCtrl = TextEditingController();

    List<List<TextEditingController>> dayCtrls = [];
    List<List<TextEditingController>> timeCtrls = [];
    List<String> serieIdies = [];

    program.series.forEach((element) {
      int serieRepeatCount = int.parse(element.repeat);
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
                            Text('SERIE ${ind + 1}',
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
                            Container(
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
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
                        itemCount: dayCtrls[ind].length,
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

  addComment(BuildContext context, TextEditingController comment) async {
    Navigator.of(context).pop();
    isLoadingComments = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.sendComment,
      datas: {
        'commentable_type': 'course',
        'commentable_id': program.id,
        'comment': comment.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // print(result);
        Fluttertoast.showToast(msg: 'Your comment added.');
        await getComments();
        isLoadingComments = false;
        notifyListeners();
        // Navigator.of(context).popAndPushNamed(
        //   Routes.ourProgramDetails,
        //   arguments: programOverview,
        // );
      },
    );
  }

  @override
  void reassemble() {}
}
