import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../Program/Models/program.dart';
import '../Providers/work-prepration.dart';

class WorkPreprationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List datas = ModalRoute.of(context)!.settings.arguments as List;
    return ChangeNotifierProvider<WorkPreprationProvider>(
      create: (ctx) => WorkPreprationProvider(
        datas[0] as List<SerieRowModel>,
        datas[1],
        datas[2],
      ),
      child: WorkPreprationScreenTile(),
    );
  }
}

class WorkPreprationScreenTile extends StatefulWidget {
  const WorkPreprationScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _WorkPreprationScreenTileState createState() =>
      _WorkPreprationScreenTileState();
}

class _WorkPreprationScreenTileState extends State<WorkPreprationScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<WorkPreprationProvider>(
      builder: (ctx, provider, _) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: FilterWidget(
              child: provider.isLoading
                  ? Center(
                      child: LoadingWidget(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ChampyaHeader(),
                            // SizedBox(height: 15),
                            // GlobalBackButton(
                            //   title: 'PROGRAM',
                            // ),
                            SizedBox(height: 15),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  provider
                                      .series[provider.currentSerieIndex]
                                      .workouts[provider.currentWorkOutIndex]
                                      .image,
                                  height: 200,
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (ctx, obj, _) => Image.asset(
                                    'assets/Images/program_placeholder.png',
                                    height: 200,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(children: [
                              Text(
                                provider
                                    .series[provider.currentSerieIndex]
                                    .workouts[provider.currentWorkOutIndex]
                                    .name,
                                style: themeData.headline3,
                              ),
                              Spacer(),
                              Icon(
                                Icons.format_align_right_sharp,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${provider.series[provider.currentSerieIndex].workouts[provider.currentWorkOutIndex].set}X${provider.series[provider.currentSerieIndex].workouts[provider.currentWorkOutIndex].perSet}',
                                style: themeData.headline3,
                              ),
                            ]),
                            SizedBox(height: 10),
                            Text(
                              provider
                                  .series[provider.currentSerieIndex]
                                  .workouts[provider.currentWorkOutIndex]
                                  .trainerDescription,
                              textAlign: TextAlign.left,
                              style: themeData.button,
                            ),
                            SizedBox(height: 30),
                            Center(
                              child: Text(
                                'Round 1'.toUpperCase(),
                                style:
                                    themeData.headline3!.copyWith(fontSize: 50),
                              ),
                            ),
                            SizedBox(height: 25),
                            Center(
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: CountDownProgressIndicator(
                                  controller: provider.timercontroller,
                                  valueColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  initialPosition: 0,
                                  duration: 5,
                                  timeTextStyle: themeData.headline3!
                                      .copyWith(fontSize: 70),
                                  onComplete: () => Navigator.of(context)
                                      .pushNamed(
                                    Routes.workout,
                                    arguments: provider
                                        .series[provider.currentSerieIndex]
                                        .workouts[provider.currentWorkOutIndex],
                                  )
                                      .then(
                                    (value) {
                                      provider.changeIndexes(context);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () => Navigator.of(context)
                            //       .pushNamed(
                            //         Routes.workout,
                            //         arguments: provider
                            //             .series[provider.currentSerieIndex]
                            //             .workouts[provider.currentWorkOutIndex],
                            //       )
                            //       .then((value) => provider.changeIndexes(context)),
                            //   child: Container(
                            //     padding: EdgeInsets.all(5),
                            //     decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       border:
                            //           Border.all(color: Colors.white, width: 10),
                            //     ),
                            //     child: Center(
                            //       child: Text(
                            //         '5',
                            //         style:
                            //             themeData.headline3!.copyWith(fontSize: 70),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
