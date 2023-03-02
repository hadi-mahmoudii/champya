import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/loading.dart';
import '../Models/custom-program.dart';

class SerieRowSelector extends StatelessWidget {
  const SerieRowSelector({
    Key? key,
    required this.themeData,
    required this.serie,
    required this.submitFunc,
    this.isLoading = false,
  }) : super(key: key);

  final TextTheme themeData;
  final SerieRowModel serie;
  final Function submitFunc;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () {
          if (!isLoading) {
            submitFunc();
          }
        },
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
            children: isLoading
                ? [LoadingWidget()]
                : [
                    Text(
                      serie.name,
                      style: themeData.headline3,
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
