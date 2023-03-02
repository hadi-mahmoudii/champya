import 'package:flutter/material.dart';

import 'loading.dart';

class SubmitButton2 extends StatelessWidget {
  const SubmitButton2({
    Key? key,
    required this.themeData,
    required this.title,
    required this.func,
    required this.icon,
    this.isLoading = false,
  }) : super(key: key);

  final TextTheme themeData;
  final String title;
  final Function func;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isLoading) {
          func();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.black,
        child: Row(
          children: isLoading
              ? [LoadingWidget()]
              : [
                  SizedBox(width: MediaQuery.of(context).size.width * 20 / 100),
                  Icon(icon, color: Colors.white, size: 40),
                  SizedBox(width: 5),
                  Text(
                    title.toUpperCase(),
                    style: themeData.headline1!.copyWith(
                      fontFamily: 'montserrat',
                      letterSpacing: 3,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
