import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';
import '../../Profile/Models/custom-program-overview.dart';
import '../Providers/add-workout-to-program.dart';

class CustomProgramSelector extends StatelessWidget {
  const CustomProgramSelector({
    Key? key,
    required this.themeData,
    required this.program,
    required this.provider,
    required this.ctx,
  }) : super(key: key);

  final TextTheme themeData;
  final MyCustomProgramOverviewModel program;
  final AddWorkoutToProgramProvider provider;
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => provider.selectWorkDay(ctx, program.id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white30,
            ),
            top: BorderSide(
              color: Colors.white30,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 4 / 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(program.title, style: themeData.headline3),
                  SizedBox(height: 3),
                  Text(program.decription, style: themeData.subtitle2),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Color(0XFFDDDDDD),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${program.seriesCount} SETS',
                          style: themeData.bodyText1!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0XFFDDDDDD),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${program.workoutCount} WORKOUT',
                            textAlign: TextAlign.center,
                            style: themeData.bodyText1!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              FlutterIcons.right_chevron,
              color: Colors.white,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
