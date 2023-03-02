import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class LoginProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.login,
      datas: {
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // log(result.toString());
        try {
          if (result['data']['token'] != '') {
            AppSession.token = 'Bearer ' + result['data']['token'];
            String username = '';
            try {
              username = result['data']['user']['first_name'];
              AppSession.userName = username;
            } catch (e) {}
            final prefs = await SharedPreferences.getInstance();
            final userData = json.encode({
              'token': AppSession.token,
              'username': username,
            });
            prefs.setString('userData', userData);
            Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
            return;
          }
        } catch (e) {}
        try {
          if (result['errors']['error'] ==
              'These credentials do not match our records.') {
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(msg: 'Username or password are wrong!');
            return;
          }
        } catch (e) {}
      },
    );
  }

  @override
  void reassemble() {}
}
