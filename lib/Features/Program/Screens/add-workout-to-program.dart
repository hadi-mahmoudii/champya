import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Models/workout-overview.dart';
import '../Providers/add-workout-to-program.dart';
import '../Widgets/custom-program-row.dart';

class AddWorkoutToProgramWidget extends StatelessWidget {
  final WorkoutOverviewModel workout;

  const AddWorkoutToProgramWidget({Key? key, required this.workout})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddWorkoutToProgramProvider>(
      create: (ctx) => AddWorkoutToProgramProvider(workout),
      child: AddWorkoutToProgramWidgetTile(),
    );
  }
}

class AddWorkoutToProgramWidgetTile extends StatefulWidget {
  const AddWorkoutToProgramWidgetTile({
    Key? key,
  }) : super(key: key);

  @override
  _AddWorkoutToProgramWidgetTileState createState() =>
      _AddWorkoutToProgramWidgetTileState();
}

class _AddWorkoutToProgramWidgetTileState
    extends State<AddWorkoutToProgramWidgetTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AddWorkoutToProgramProvider>(context, listen: false)
          .getPrograms(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<AddWorkoutToProgramProvider>(
      builder: (ctx, provider, _) => FilterWidget(
        child: provider.isLoading
            ? Center(
                child: LoadingWidget(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(height: 15),
                    SimpleHeader(
                      mainHeader: 'BEGIN THE PROGRAM',
                      subHeader: 'enter the series details',
                    ),
                    SizedBox(height: 15),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, ind) => CustomProgramSelector(
                        themeData: themeData,
                        program: provider.myCustomPrograms[ind],
                        provider: provider,
                        ctx: context,
                      ),
                      separatorBuilder: (ctx, ind) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(height: 1),
                      ),
                      itemCount: provider.myCustomPrograms.length,
                    ),
                    SizedBox(height: 25),
                    SubmitButton(
                      func: () =>
                          Navigator.of(context).pushNamed(Routes.myPrograms),
                      icon: null,
                      title: 'MANAGE MY PROGRAMS',
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
      ),
    );
  }
}
