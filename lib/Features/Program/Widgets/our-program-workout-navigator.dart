import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Models/program.dart';
import 'package:flutter/material.dart';

class OurProgramWorkoutNavigator extends StatelessWidget {
  const OurProgramWorkoutNavigator({
    Key? key,
    required this.themeData,
    required this.serie,
    required this.index,
  }) : super(key: key);

  final TextTheme themeData;
  final SerieRowModel serie;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.seriesDetails,
        arguments: [serie, index],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white30,
            ),
            // top: BorderSide(
            //   color: Colors.white30,
            // ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 6 / 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Serie $index', style: themeData.headline3),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0XFFDDDDDD),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              '${serie.workouts.length} WORKOUT',
                              textAlign: TextAlign.center,
                              style: themeData.bodyText1!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Color(0XFFDDDDDD),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              '${serie.time} EST. TIME',
                              style: themeData.bodyText1!.copyWith(
                                color: Colors.black,
                              ),
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
