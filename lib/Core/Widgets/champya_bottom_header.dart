import 'package:flutter/material.dart';

class ChampyaBottomHeader extends StatelessWidget {
  const ChampyaBottomHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/Images/icon.png', width: 30, height: 30),
          // FlutterLogo(
          //   size: 30,
          //   textColor: Colors.white,
          // ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Right’s Reserved for',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'CHAMPYA.COM',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(letterSpacing: 2, fontFamily: 'montserratlight'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
