import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../../Program/Models/train-day.dart';
import '../Providers/working-day-program.dart';
import '../Widgets/working-day-program-navigator.dart';

class WorkingDayProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List datas = ModalRoute.of(context)!.settings.arguments as List;
    return ChangeNotifierProvider<WorkingDayProgramProvider>(
      create: (ctx) => WorkingDayProgramProvider(
        datas[0] as TrainDayModel,
        datas[1],
      ),
      child: WorkingDayProgramScreenTile(),
    );
  }
}

class WorkingDayProgramScreenTile extends StatefulWidget {
  const WorkingDayProgramScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _WorkingDayProgramScreenTileState createState() =>
      _WorkingDayProgramScreenTileState();
}

class _WorkingDayProgramScreenTileState
    extends State<WorkingDayProgramScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<WorkingDayProgramProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<WorkingDayProgramProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : RefreshIndicator(
                  onRefresh: () async => print('object'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        ChampyaHeader(),
                        SizedBox(height: 15),
                        GlobalBackButton(
                          title: 'PROGRAMS',
                        ),
                        SimpleHeader(
                          mainHeader: 'TRAINING DAY',
                          subHeader: 'PROGRAMS YOU CREATED',
                        ),
                        SizedBox(height: 20),
                        SubmitButton2(
                          themeData: themeData,
                          title: '''begin the
session''',
                          func: () => provider.series.isNotEmpty
                              ? Navigator.of(context).pushNamed(
                                  Routes.workPrepration,
                                  arguments: [
                                    provider.series,
                                    provider.programId,
                                    provider.dayDatas,
                                  ],
                                )
                              : Fluttertoast.showToast(
                                  msg: 'This day is empty!'),
                          icon: Icons.play_arrow,
                        ),
                        SizedBox(height: 40),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) => provider
                                  .series[index].workouts.isNotEmpty
                              //empty serie wont show
                              ? LayoutBuilder(
                                  builder: (ctx, cons) => ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      Center(
                                        child: Text(
                                          'Series ${index + 1}',
                                          style: themeData.headline3!
                                              .copyWith(letterSpacing: 4),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, ind) =>
                                            WorkingDayProgramNavigatorBox(
                                          themeData: themeData,
                                          cons: cons,
                                          workout: provider
                                              .series[index].workouts[ind],
                                        ),
                                        separatorBuilder: (ctx, ind) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: Divider(
                                            height: 22,
                                            color: Colors.white.withOpacity(.3),
                                          ),
                                        ),
                                        itemCount: provider
                                            .series[index].workouts.length,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          separatorBuilder: (ctx, ind) => Divider(
                            height: 40,
                          ),
                          itemCount: provider.series.length,
                        ),
                        SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
