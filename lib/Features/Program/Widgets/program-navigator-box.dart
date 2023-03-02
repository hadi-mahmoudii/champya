import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class ProgramNavigatorBox extends StatelessWidget {
  const ProgramNavigatorBox({
    Key? key,
    required this.themeData,
    required this.cons,
  }) : super(key: key);

  final TextTheme themeData;
  final BoxConstraints cons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: cons.maxWidth / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/Images/2.jpg',
                width: cons.maxWidth / 3,
                height: 75,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Move n : Relaxation',
                        style: themeData.button,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Icon(
                    //   Icons.bookmark,
                    //   color: Colors.white,
                    //   size: 17,
                    // ),
                  ],
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
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
                      '15:30',
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
                      '4x10',
                      style: Theme.of(context).textTheme.button,
                    ),
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
