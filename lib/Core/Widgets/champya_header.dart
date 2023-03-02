import 'package:flutter/material.dart';

class ChampyaHeader extends StatelessWidget {
  const ChampyaHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/Images/icon.png', width: 30, height: 30),
          // FlutterLogo(
          //   size: 30,
          //   textColor: Colors.white,
          // ),
          Text(
            'CHAMPYA',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
