import 'package:flutter/material.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../Program/Widgets/like-percent-widget.dart';
import '../Models/program-overview.dart';

class MyProgramNavigatorRow extends StatelessWidget {
  const MyProgramNavigatorRow({
    Key? key,
    required this.themeData,
    required this.program,
    required this.onBackFunction,
  }) : super(key: key);

  final TextTheme themeData;
  final Function onBackFunction;
  final MyProgramOverviewModel program;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.programDetails,
        arguments: program.id,
      ).then((value) => onBackFunction()),
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
                  Text(
                    program.title,
                    style: themeData.headline3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    program.decription,
                    style: themeData.subtitle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
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
                  SizedBox(height: 5),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.watch_later_rounded,
                  //       color: Colors.white,
                  //       size: 9,
                  //     ),
                  // SizedBox(width: 3),
                  // Text(
                  //   'NEXT: ${program.next}',
                  //   style: themeData.headline5,
                  // )
                  // ],
                  // ),
                ],
              ),
            ),
            SizedBox(width: 5),
            DonePercentWidget(
              themeData: themeData,
              value: program.donePercent,
            ),
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
