import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/bookmark_box.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Models/workout-overview.dart';
import '../Screens/add-workout-to-program.dart';

class CategoryWorkoutNavigator extends StatefulWidget {
  const CategoryWorkoutNavigator({
    Key? key,
    required this.themeData,
    required this.cons,
    required this.workout,
    this.letAddWorkout = true,
  }) : super(key: key);

  final TextTheme themeData;
  final BoxConstraints cons;
  final WorkoutOverviewModel workout;
  final bool letAddWorkout;

  @override
  State<CategoryWorkoutNavigator> createState() =>
      _CategoryWorkoutNavigatorState();
}

class _CategoryWorkoutNavigatorState extends State<CategoryWorkoutNavigator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (widget.workout.video.isNotEmpty) {
              Navigator.of(context)
                  .pushNamed(Routes.showVideo, arguments: widget.workout.video);
            } else {
              Fluttertoast.showToast(msg: 'This workout have no video');
            }
          },
          child: Container(
            width: widget.cons.maxWidth / 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.workout.image,
                    width: widget.cons.maxWidth / 3,
                    height: 75,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (ctx, obj, _) => Image.asset(
                      'assets/Images/program_placeholder.png',
                      width: widget.cons.maxWidth / 3,
                      height: 75,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: 27,
                  left: widget.cons.maxWidth / 8,
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
                      widget.workout.name,
                      style: widget.themeData.button,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BookmarkBox(
                    currentState: widget.workout.hasBookmark,
                    id: widget.workout.id,
                    type: 'workout',
                  ),
                ],
              ),
              Text(
                widget.workout.decription,
                style: widget.themeData.bodyText1,
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
                    widget.workout.time,
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
                    '${widget.workout.set}x${widget.workout.perSet}',
                    style: Theme.of(context).textTheme.button,
                  ),
                  Spacer(),
                  widget.letAddWorkout
                      ? SubmitButton(
                          func: () => showModalBottomSheet(
                            context: context,
                            builder: (ctx) => AddWorkoutToProgramWidget(
                                workout: widget.workout),
                          ),
                          icon: FlutterIcons.plus,
                          title: '',
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
