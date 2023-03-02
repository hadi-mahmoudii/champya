import 'package:flutter/material.dart';

import '../../../Core/Config/routes.dart';
import '../Models/train-day.dart';

class ProgramPrograssItem extends StatelessWidget {
  const ProgramPrograssItem({
    Key? key,
    required this.dayDatas,
    required this.programId,
  }) : super(key: key);
  final TrainDayModel dayDatas;
  final String programId;
  @override
  Widget build(BuildContext context) {
    late Color themeColor;
    late IconData icon;
    String route = '';
    Object argoments = dayDatas;
    switch (dayDatas.status) {
      case 'break day':
        themeColor = Colors.white;
        icon = Icons.coffee;
        break;
      case 'completed':
        themeColor = Color(0XFF32CAD5);
        icon = Icons.check;
        break;
      case 'uncompleted':
        themeColor = Color(0XFF3498DB);
        icon = Icons.watch_later_rounded;
        route = Routes.workingDayProgram;
        argoments = [
          dayDatas,
          programId,
        ];
        break;
      case 'up coming days':
        // themeColor = Colors.white;
        // icon = Icons.watch_later_rounded;
        themeColor = Color(0XFF3498DB);
        icon = Icons.watch_later_rounded;
        route = Routes.workingDayProgram;
        argoments = [
          dayDatas,
          programId,
        ];
        break;
      default:
    }
    return InkWell(
      onTap: () {
        if (route.isNotEmpty) {
          Navigator.of(context)
              .pushNamed(Routes.workingDayProgram, arguments: argoments);
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: themeColor,
              ),
            ),
            child: Icon(
              icon,
              color: themeColor,
            ),
          ),
          SizedBox(height: 3),
          Expanded(
            child: Text(
              dayDatas.date,
              style: TextStyle(
                color: themeColor,
                fontSize: 9,
              ),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
