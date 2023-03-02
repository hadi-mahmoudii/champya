import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/category-overview.dart';

class AddCustomProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController periodCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  List<OptionModel> categories = [];

  getCategories(BuildContext context, {bool resetPage = false}) async {
    isLoading = true;
    notifyListeners();

    // print(Urls.cetprograms(selectedBrand.id));
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getCategories,
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // print(result);
        List<CategoryOverviewModel> allCategories = [];
        result['data'].forEach((element) {
          // print(element);
          allCategories.add(CategoryOverviewModel.fromJson(element));
          // print(result['children']);
        });
        allCategories.forEach((element) {
          categories.add(OptionModel(id: element.id, title: element.title));
        });
        isLoading = false;
        notifyListeners();
      },
    );
  }

  addProgram(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.createProgram,
      datas: {
        'sport_category_id': categories
            .firstWhere((element) => element.title == categoryCtrl.text)
            .id,
        'title': titleCtrl.text,
        'description': descriptionCtrl.text,
        'period': periodCtrl.text,
        // 'thumbnail': birthdayCtrl.text,
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
            Fluttertoast.showToast(msg: 'Program added');
            Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed(Routes.myPrograms);

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
