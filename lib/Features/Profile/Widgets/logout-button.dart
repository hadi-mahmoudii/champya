import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    required this.themeData,
    required this.func,
  }) : super(key: key);

  final TextTheme themeData;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => func(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            'LOG OUT',
            style: themeData.caption,
          ),
        ],
      ),
    );
  }
}
