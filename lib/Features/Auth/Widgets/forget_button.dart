import 'package:flutter/material.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';

class ForgetNavigatorButton extends StatelessWidget {
  const ForgetNavigatorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(Routes.forgetPass),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: mainFontColor),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FlutterIcons.snowflake_o,
              color: mainFontColor,
              size: 12,
            ),
            SizedBox(width: 5),
            Text(
              'FORGET PASSWORD',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
