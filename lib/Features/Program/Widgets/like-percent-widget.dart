import 'package:flutter/material.dart';

class DonePercentWidget extends StatelessWidget {
  const DonePercentWidget({
    Key? key,
    required this.themeData,
    required this.value,
  }) : super(key: key);
  final TextTheme themeData;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF32CAD5).withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF32CAD5),
                  fontSize: 30,
                ),
              ),
              SizedBox(width: 2),
              Text(
                '%',
                style: themeData.headline6!.copyWith(
                  color: Color(0xFF32CAD5),
                ),
              ),
            ],
          ),
          Text(
            'Done',
            style: themeData.headline6!.copyWith(
              color: Color(0xFF32CAD5),
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}
