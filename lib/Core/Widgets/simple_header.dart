import 'package:flutter/material.dart';

class SimpleHeader extends StatelessWidget {
  final String? mainHeader;
  final String? subHeader;

  const SimpleHeader({
    Key? key,
    @required this.mainHeader,
    @required this.subHeader,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, cons) => Container(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: cons.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainHeader!.toUpperCase(),
                textAlign: TextAlign.left,
                style: themeData.textTheme.headline2!.copyWith(fontSize: 21),
              ),
              // SizedBox(height: 2),
              Text(
                subHeader!.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'montserratlight',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
