import 'package:champya/Features/Program/Models/custom-program.dart';

import '../../../Core/Config/routes.dart';
import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class SerieRowNavigator extends StatelessWidget {
  const SerieRowNavigator({
    Key? key,
    required this.themeData,
    required this.serie,
    required this.index,
    required this.programId,
    required this.onBackFunction,
  }) : super(key: key);

  final TextTheme themeData;
  final SerieRowModel serie;
  final int index;
  final String programId;
  final Function onBackFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.customSerieDetails,
          arguments: [serie, programId],
        ).then((value) => onBackFunction()),
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
              Text(
                'SERIES $index: ${serie.name}',
                style: themeData.headline3!.copyWith(letterSpacing: 4),
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
