import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class DashboardRowNavigator extends StatelessWidget {
  const DashboardRowNavigator({
    Key? key,
    required this.themeData,
    required this.title,
    required this.subtitle,
    required this.route,
  }) : super(key: key);

  final TextTheme themeData;
  final String title, subtitle, route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(route),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: themeData.headline3,
                  ),
                  Text(
                    subtitle,
                    style: themeData.bodyText1!.copyWith(fontSize: 11),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                FlutterIcons.right_chevron,
                size: 24,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
