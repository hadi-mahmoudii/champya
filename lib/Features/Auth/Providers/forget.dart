import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgetPassProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  // TextEditingController passwordCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  forgetPassRequest(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.forgetPass,
      datas: {
        'email': emailCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) {
        print(result);
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
          if (result['message']['title'] == 'Success') {
            Fluttertoast.showToast(msg: 'New password to your email.');
            Navigator.of(context).pop();
            return;
          }
        } catch (e) {}
        try {
          if (result['errors']['email'][0] ==
              'The email must be a valid email address.') {
            isLoading = false;
            notifyListeners();
            Fluttertoast.showToast(
                msg: 'The email must be a valid email address.');
            return;
          }
        } catch (e) {}
      },
    );
  }

  @override
  void reassemble() {}
}
