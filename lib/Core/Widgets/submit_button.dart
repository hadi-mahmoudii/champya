import 'package:champya/Core/Widgets/loading.dart';
import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class SubmitButton extends StatelessWidget {
  final Function func;
  final Color? color;
  final IconData? icon;
  final String title;
  final double? fontSize;
  final double? buttonWidth;
  final bool isLoading;
  const SubmitButton({
    Key? key,
    required this.func,
    required this.icon,
    required this.title,
    this.color = mainFontColor,
    this.fontSize = 14,
    this.buttonWidth,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isLoading) {
          func();
        }
      },
      child: Container(
        width: buttonWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color!, width: 2),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     blurRadius: 30,
          //     color: color!.withOpacity(.3),
          //     offset: Offset(0, 15),
          //     // spreadRadius: 5,
          //   ),
          // ],
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? [LoadingWidget()]
              : [
                  icon != null
                      ? Icon(
                          icon,
                          color: color,
                          size: 13,
                        )
                      : Container(),
                  // SizedBox(width: 5),
                  title != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            title.toUpperCase(),
                            textAlign: TextAlign.end,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: color,
                                      fontSize: fontSize,
                                    ),
                          ),
                        )
                      : Container(),
                ],
        ),
      ),
    );
  }
}
