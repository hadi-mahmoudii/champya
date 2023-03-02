import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoContactNavigators extends StatelessWidget {
  const InfoContactNavigators({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final TextTheme themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(.7),
          ),
          bottom: BorderSide(
            color: Colors.white.withOpacity(.7),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => launch('https://champya.com/about-us/'),
            child: Text(
              'ABOUT US',
              style: themeData.caption!.copyWith(
                fontFamily: 'montserratlight',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          InkWell(
            onTap: () => launch('https://champya.com/contact-us/'),
            child: Text(
              'CONTACT US',
              style: themeData.caption!.copyWith(
                fontFamily: 'montserratlight',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
