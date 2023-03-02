import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class RegisterProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();

  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController rePasswordCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.register,
      datas: {
        'first_name': fNameCtrl.text,
        'last_name': lNameCtrl.text,
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
        'password_confirmation': rePasswordCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // log(result.toString());
        try {
          if (result['token'] != '') {
            Navigator.of(context).pushReplacementNamed(Routes.submitCode,
                arguments: emailCtrl.text);
            return;
            // AppSession.token = 'Bearer ' + result['token'];
            // final prefs = await SharedPreferences.getInstance();
            // final userData = json.encode({
            //   'token': AppSession.token,
            // });
            // prefs.setString('userData', userData);
            // Navigator.of(context).pop();
            // Navigator.of(context).pushReplacementNamed(Routes.MainScreen);
            // return;
          }
        } catch (e) {}
        try {
          if (result['errors']['email'][0] ==
              'The email has already been taken.') {
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(msg: 'The email has already been taken.');
            return;
          }
        } catch (e) {}
      },
    );
  }

  @override
  void reassemble() {}
}
