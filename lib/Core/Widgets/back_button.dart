import 'package:flutter/material.dart';

import 'flutter_icons.dart';

class GlobalBackButton extends StatelessWidget {
  final String? title;
  const GlobalBackButton({
    Key? key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              FlutterIcons.angle_left,
              color: Colors.white.withOpacity(.5),
            ),
            SizedBox(width: 5),
            Text(
              title!.toUpperCase(),
              style: Theme.of(context).textTheme.overline,
            ),
          ],
        ),
      ),
    );
  }
}
