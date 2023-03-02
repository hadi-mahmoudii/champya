import 'package:flutter/material.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../Program/Models/program-overview.dart';

class ProgramHomeNavigator extends StatelessWidget {
  final BoxConstraints cons;
  final int index;
  final ProgramOverviewModel program;
  const ProgramHomeNavigator({
    Key? key,
    required this.cons,
    required this.index,
    required this.program,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: cons.maxWidth * 63 / 100),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.ourProgramDetails,
          arguments: program,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    program.image,
                    height: 200,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (ctx, obj, _) => Image.asset(
                      'assets/Images/program_placeholder.png',
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FlutterIcons.align_right,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          program.seriesCount,
                          style: Theme.of(context).textTheme.button,
                        ),
                        SizedBox(width: 15),
                        Icon(
                          FlutterIcons.clock_1,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          program.time,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              program.title,
              style: Theme.of(context).textTheme.headline3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              program.decription,
              style: Theme.of(context).textTheme.subtitle2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
