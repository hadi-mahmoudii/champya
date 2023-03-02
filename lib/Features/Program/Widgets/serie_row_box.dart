import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Models/program.dart';

class SerieRowBox extends StatelessWidget {
  const SerieRowBox({
    Key? key,
    required this.themeData,
    required this.cons,
    required this.workout,
  }) : super(key: key);

  final TextTheme themeData;
  final BoxConstraints cons;
  final WorkoutRowModel workout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (workout.video.isNotEmpty) {
          Navigator.of(context)
              .pushNamed(Routes.showVideo, arguments: workout.video);
        } else {
          Fluttertoast.showToast(msg: 'This workout have no video');
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: cons.maxWidth / 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    workout.image,
                    width: cons.maxWidth / 3,
                    height: 75,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (ctx, obj, _) => Image.asset(
                      'assets/Images/program_placeholder.png',
                      width: cons.maxWidth / 3,
                      height: 75,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: 27,
                  left: cons.maxWidth / 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        workout.name,
                        style: themeData.button,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // BookmarkBox(
                    //   currentState: workout.hasBookmark,
                    //   type: 'workout',
                    //   id: workout.id,
                    // )
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  workout.trainerDescription,
                  style: themeData.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      FlutterIcons.clock_1,
                      size: 12,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      workout.time,
                      style: Theme.of(context).textTheme.button,
                    ),
                    SizedBox(width: 15),
                    Icon(
                      FlutterIcons.align_right,
                      size: 12,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${workout.set}x${workout.perSet}',
                      style: Theme.of(context).textTheme.button,
                    ),
                    Spacer(),
                    // SubmitButton(func: () {}, icon: Icons.add, title: '')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
