import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Core/Config/app_session.dart';
import 'Core/Config/routes.dart';
import 'Core/main_screen.dart';

void main() {
  if (Platform.isAndroid || Platform.isIOS) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          Platform.isIOS ? Brightness.dark : Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(new MyApp());
    });
  } else {
    runApp(new MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppSession()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Champya',
        theme: ThemeData(
          primaryColor: mainFontColor,
          fontFamily: 'montserrat',
          colorScheme: ColorScheme.light(secondary: Color(0XFFFFD600)),
          canvasColor: Colors.black,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            // selectionColor: Colors.white,
            selectionHandleColor: Colors.white,
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontFamily: 'teamamerica',
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              fontSize: 25,
              color: Color(0XFFFFD600),
              fontFamily: 'teamamerica',
            ),
            headline3: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'montserratmedium',
            ),
            // subtitle1: TextStyle(
            //   fontSize: 15,
            //   color: Colors.white,
            //   fontFamily: 'montserratlight',
            // ),
            subtitle2: TextStyle(
              fontSize: 12,
              color: Color(0XFFBEBEBE),
              fontFamily: 'montserratlight',
            ),
            caption: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'montserrat',
              fontWeight: FontWeight.bold,
            ),
            overline: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(.5),
              fontFamily: 'montserratmedium',
              letterSpacing: 4.75,
            ),
            button: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'montserrat',
            ),
            bodyText1: TextStyle(
              fontSize: 10,
              color: Color(0XFFE3E3E3),
              fontFamily: 'montserratlight',
            ),
            headline5: TextStyle(
              fontSize: 8,
              color: Colors.white,
              fontFamily: 'montserratlight',
            ),
            headline6: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontFamily: 'montserratlight',
            ),
          ),
        ),
        routes: Routes().appRoutes,
        home: MainScreen(),
      ),
    );
  }
}
