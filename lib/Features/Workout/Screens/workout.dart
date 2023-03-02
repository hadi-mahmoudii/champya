import 'package:champya/Core/Config/app_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../../Program/Models/program.dart';
import '../Providers/workout.dart';

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutProvider>(
      create: (ctx) => WorkoutProvider(
          ModalRoute.of(context)!.settings.arguments as WorkoutRowModel),
      child: WorkoutScreenTile(),
    );
  }
}

class WorkoutScreenTile extends StatefulWidget {
  const WorkoutScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _WorkoutScreenTileState createState() => _WorkoutScreenTileState();
}

class _WorkoutScreenTileState extends State<WorkoutScreenTile>
    with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    Provider.of<WorkoutProvider>(context, listen: false).startTimer();
    WidgetsBinding.instance!.addObserver(this);

    // Future.microtask(
    //   () => AppSession.audioPlayer.playBytes(
    //     'assets/Media/train.mp3',
    //   ),
    // );
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      try {
        await AppSession.audioPlayer.pause();
      } catch (e) {}
    } else {
      try {
        await AppSession.audioPlayer.play();
      } catch (e) {}
    }
    print(state);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<WorkoutProvider>(
      builder: (ctx, provider, _) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: FilterWidget(
            child: provider.isLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        ChampyaHeader(),
                        // SizedBox(height: 15),
                        // GlobalBackButton(
                        //   title: 'PROGRAM',
                        // ),
                        SizedBox(height: 15),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            provider.workout.image,
                            height: 200,
                            fit: BoxFit.fitHeight,
                            errorBuilder: (ctx, obj, _) => Image.asset(
                              'assets/Images/program_placeholder.png',
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            provider.workout.name,
                            style: themeData.headline3!.copyWith(fontSize: 22),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          height: 30,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, ind) => RoundWidget(
                              themeData: themeData,
                              index: ind + 1,
                              letLight: provider.currentRoundIndex >= ind
                                  ? true
                                  : false,
                            ),
                            separatorBuilder: (ctx, ind) => SizedBox(
                              width: 0,
                            ),
                            itemCount: int.parse(provider.workout.set),
                          ),
                        ),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       for (var i = 0;
                        //           i < int.parse(provider.workout.set);
                        //           i++)
                        //         RoundWidget(
                        //           themeData: themeData,
                        //           index: i + 1,
                        //           letLight: provider.currentRoundIndex >= i
                        //               ? true
                        //               : false,
                        //         )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 55),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.pause, color: Colors.white, size: 40),
                            Text(
                              'x${provider.workout.perSet}',
                              style: themeData.caption!.copyWith(
                                fontSize: 50,
                              ),
                            ),
                            // Icon(Icons.music_note,
                            //     color: Colors.white, size: 40),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Time passed : ',
                              style: themeData.caption!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              provider.getTimeString(provider.timerValue),
                              style:
                                  themeData.bodyText1!.copyWith(fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        SubmitButton2(
                          themeData: themeData,
                          title: '''it’s
done''',
                          func: () async {
                            await AppSession.audioPlayer.stop();
                            Navigator.of(context)
                                .pushNamed(Routes.workoutRestDetails)
                                .then((value) =>
                                    provider.changeCurrentRoundIndex(context));
                          },
                          icon: Icons.check,
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class RoundWidget extends StatelessWidget {
  const RoundWidget({
    Key? key,
    required this.themeData,
    required this.letLight,
    required this.index,
  }) : super(key: key);

  final TextTheme themeData;
  final bool letLight;
  final int index;

  @override
  Widget build(BuildContext context) {
    return letLight
        ? Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
            child: Text(
              ' Round $index ',
              style: themeData.caption!.copyWith(fontSize: 20),
            ),
          )
        : Text(
            ' Round $index ',
            style: themeData.caption!.copyWith(fontSize: 20),
          );
  }
}
