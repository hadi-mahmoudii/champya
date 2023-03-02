import 'package:champya/Core/Widgets/bookmark_box.dart';

import '../Models/program-overview.dart';
import 'package:flutter/material.dart';

import '../../../Core/Config/routes.dart';

class CategoryProgramNavigator extends StatelessWidget {
  const CategoryProgramNavigator({
    Key? key,
    required this.themeData,
    required this.program,
  }) : super(key: key);

  final TextTheme themeData;
  final ProgramOverviewModel program;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.ourProgramDetails,
        arguments: program,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      program.image,
                      fit: BoxFit.fill,
                      height: 200,
                      width: double.infinity,
                      errorBuilder: (ctx, obj, _) => Image.asset(
                        'assets/Images/program_placeholder.png',
                        fit: BoxFit.fill,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    program.title,
                    textAlign: TextAlign.start,
                    style: themeData.headline3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                BookmarkBox(
                  currentState: program.hasBookmark,
                  type: 'course',
                  id: program.id,
                ),
              ],
            ),
            Text(
              program.decription,
              style: themeData.subtitle2,
              maxLines: 2,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0XFFDDDDDD),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${program.workoutCount} WORKOUTS',
                    style: themeData.bodyText1!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
