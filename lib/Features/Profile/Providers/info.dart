import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/global.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class InfoProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController cellCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController birthdayCtrl = TextEditingController();
  TextEditingController birthdayLabelCtrl = TextEditingController();

  getDatas(
    BuildContext context,
  ) async {
    isLoading = true;
    // scrollController.jumpTo(0);
    notifyListeners();

    // print(Urls.getproducts(selectedBrand.id));
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.user,
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // print(result);
        // print(GlobalEntity.dataFilter(result['data']['birthday']));
        emailCtrl.text = GlobalEntity.dataFilter(result['data']['email']);
        fNameCtrl.text = GlobalEntity.dataFilter(result['data']['first_name']);
        lNameCtrl.text = GlobalEntity.dataFilter(result['data']['last_name']);
        birthdayCtrl.text = GlobalEntity.dataFilter(result['data']['birthday']);
        birthdayLabelCtrl.text = GlobalEntity.dataFilter(result['data']['birthday']);

        cellCtrl.text = GlobalEntity.dataFilter(result['data']['cell_number']);
        addressCtrl.text = GlobalEntity.dataFilter(result['data']['address']);
        countryCtrl.text = GlobalEntity.dataFilter(result['data']['country']);

        isLoading = false;
        notifyListeners();
      },
    );
  }

  updateDatas(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    // print(countryCtrl.text);
    // print(cellCtrl.text);

    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.user,
      datas: {
        'first_name': fNameCtrl.text,
        'last_name': lNameCtrl.text,
        'address': addressCtrl.text,
        'birthday': birthdayCtrl.text,
        'cell_number': cellCtrl.text,
        // 'country': countryCtrl.text,
        '_method': 'put',
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // print(result);
        try {
          if (result['data']['id'] != '') {
            Fluttertoast.showToast(msg: 'Your data updated');
            Navigator.of(context).pop();
            return;
          }
        } catch (e) {}
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Error!');
      },
    );
  }

  @override
  void reassemble() {}
}
