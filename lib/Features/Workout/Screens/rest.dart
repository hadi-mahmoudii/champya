import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../Providers/rest.dart';

class WorkoutRestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutRestProvider>(
      create: (ctx) => WorkoutRestProvider(),
      child: WorkoutRestScreenTile(),
    );
  }
}

class WorkoutRestScreenTile extends StatefulWidget {
  const WorkoutRestScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _WorkoutRestScreenTileState createState() => _WorkoutRestScreenTileState();
}

class _WorkoutRestScreenTileState extends State<WorkoutRestScreenTile> {
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
    return Consumer<WorkoutRestProvider>(
      builder: (ctx, provider, _) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: provider.isLoading
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
                        SizedBox(height: 90),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              '''have
some
rest'''
                                  .toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 60,
                                  height: .85),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CountDownProgressIndicator(
                              controller: CountDownController(),
                              valueColor: Colors.white,
                              backgroundColor: Colors.black,
                              initialPosition: 0,
                              duration: 30,
                              timeTextStyle: themeData.headline3!
                                  .copyWith(fontSize: 70, color: Colors.black),
                              onComplete: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SubmitButton2(
                          themeData: themeData,
                          title: '''it’s
enough''',
                          func: () => Navigator.of(context).pop(),
                          icon: Icons.watch_later,
                        ),
                        //TODO : next workout must add here

                        // SizedBox(height: 20),
                        // Text(
                        //   'NEXT:',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     letterSpacing: 4,
                        //     fontSize: 20,
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // RestNextWork(themeData: themeData),
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
