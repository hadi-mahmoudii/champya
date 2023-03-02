import 'package:flutter/material.dart';

class ProgramDetailsInfoItem extends StatelessWidget {
  const ProgramDetailsInfoItem({
    Key? key,
    required this.title,
    required this.value,
    required this.themeData,
  }) : super(key: key);
  final String title;
  final String value;
  final TextTheme themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' $title:',
            style: themeData.headline5!.copyWith(color: Colors.grey),
          ),
          Text(value,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontFamily: 'montserratlight',
              )),
        ],
      ),
    );
  }
}
