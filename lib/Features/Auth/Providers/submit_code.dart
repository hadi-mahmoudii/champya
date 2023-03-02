import 'dart:async';
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

class SubmitCodeProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController codeCtrl = TextEditingController();
  // TextEditingController passwordCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String email;

  SubmitCodeProvider(this.email);

  int timerValue = 60;
  late Timer globalTimer;

  void startTimer() {
    timerValue = 60;
    notifyListeners();
    const oneSec = const Duration(seconds: 1);
    globalTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerValue == 0) {
          globalTimer.cancel();
          return;
        }
        timerValue -= 1;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    try {
      globalTimer.cancel();
    } catch (e) {}
    super.dispose();
  }

  resendCode(BuildContext context) async {
    startTimer();
    Fluttertoast.showToast(msg: 'Request sended');
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.resendCode,
      datas: {
        'email': email,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        // Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) async {
        // log(result.toString());
        // try {
        //   if (result['errors'].isNotEmpty) {
        //     Fluttertoast.showToast(msg: result['errors'][0]);
        //     Navigator.of(context).pop();
        //     isLoading = false;
        //     notifyListeners();
        //     return;
        //   }
        // } catch (e) {}
        // try {
        //   if (result['token'] != '') {
        //     Navigator.of(context)
        //         .pushNamed(Routes.submitCode, arguments: email);
        //     AppSession.token = 'Bearer ' + result['token'];
        //     String username = '';
        //     try {
        //       username = result['data']['user']['first_name'];
        //       AppSession.userName = username;
        //     } catch (e) {}
        //     final prefs = await SharedPreferences.getInstance();
        //     final userData = json.encode({
        //       'token': AppSession.token,
        //       'username': username,
        //     });
        //     prefs.setString('userData', userData);
        //     Navigator.of(context).pop();
        //     Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
        //     return;
        //   }
        // } catch (e) {}
        // try {
        //   if (result['message'] == 'verification code invalid') {
        //     isLoading = false;
        //     notifyListeners();
        //     Fluttertoast.showToast(msg: 'Code is wrong!');
        //     return;
        //   }
        // } catch (e) {}
      },
    );
  }

  submitCode(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.submitCode,
      datas: {
        'code': codeCtrl.text,
        'email': email,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) async {
        try {
          if (result['errors'].isNotEmpty) {
            Fluttertoast.showToast(msg: result['errors'][0]);
            Navigator.of(context).pop();
            isLoading = false;
            notifyListeners();
            return;
          }
        } catch (e) {}
        try {
          if (result['token'] != '') {
            Navigator.of(context)
                .pushNamed(Routes.submitCode, arguments: email);
            AppSession.token = 'Bearer ' + result['token'];
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
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
            return;
          }
        } catch (e) {}
        try {
          if (result['message'] == 'verification code invalid') {
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(msg: 'Code is wrong!');
            return;
          }
        } catch (e) {}
      },
    );
  }

  @override
  void reassemble() {}
}
