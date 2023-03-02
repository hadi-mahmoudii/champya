import 'package:champya/Features/Profile/Models/custom-program-overview.dart';

import '../../../Core/Config/routes.dart';
import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class MyCustomProgramNavigatorRow extends StatelessWidget {
  const MyCustomProgramNavigatorRow({
    Key? key,
    required this.themeData,
    required this.program,
    required this.onBackFunction,
  }) : super(key: key);

  final TextTheme themeData;
  final MyCustomProgramOverviewModel program;

  final Function onBackFunction;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(
            Routes.customProgramDetails,
            arguments: program.id,
          )
          .then((value) => onBackFunction()),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(program.title, style: themeData.headline3),
                  SizedBox(height: 3),
                  Text(program.decription, style: themeData.subtitle2),
                  SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 5,
                    child: Row(
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
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            // Spacer(),
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
