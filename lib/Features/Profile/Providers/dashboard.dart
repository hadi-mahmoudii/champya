import 'package:champya/Core/Config/app_session.dart';
import 'package:champya/Core/Config/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier with ReassembleHandler {
  logout(BuildContext context, {bool sendRequest = false}) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        content: const Text(
          'Are you sure?',
          // textDirection: TextDirection.rtl,
          style: TextStyle(color: mainFontColor),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              AppSession.token = '';
              AppSession.userName = '';
              AppSession.userPhone = '';

              final prefs = await SharedPreferences.getInstance();
              prefs.remove('userData');
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: mainFontColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: mainFontColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void reassemble() {}
}
