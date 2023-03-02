import '../Models/category-overview.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class CategoriesProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  bool lockPage = false;
  int currentPage = 1;

  // if we navigate to this page from serie detials,bottom bar most be hidden
  final bool navigateFromProgramDetails;

  List<CategoryOverviewModel> categories = [];

  CategoriesProvider(this.navigateFromProgramDetails);

  getDatas(BuildContext context, {bool resetPage = false}) async {
    if (lockPage) return;
    if (resetPage) currentPage = 1;
    if (currentPage == 1) {
      categories = [];
      isLoading = true;
      // scrollController.jumpTo(0);
      notifyListeners();
    } else {
      isLoadingMore = true;
      notifyListeners();
    }
    // print(Urls.cetCategories(selectedBrand.id));
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
        result['data'].forEach((element) {
          // print(element);
          categories.add(CategoryOverviewModel.fromJson(element));
          // print(result['children']);
        });
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void reassemble() {}
}
