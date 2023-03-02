import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/product.dart';

class ProductListProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  bool lockPage = false;
  int currentPage = 1;

  List<ProductModel> products = [];

  getDatas(BuildContext context, {bool resetPage = false}) async {
    if (lockPage) return;
    if (resetPage) currentPage = 1;
    if (currentPage == 1) {
      products = [];
      isLoading = true;
      // scrollController.jumpTo(0);
      notifyListeners();
    } else {
      isLoadingMore = true;
      notifyListeners();
    }
    // print(Urls.getproducts(selectedBrand.id));
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getProducts(currentPage.toString()),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        if (currentPage == 1) {
          result['data'].forEach((element) {
            products.add(ProductModel.fromJson(element));
          });
          currentPage += 1;
        } else {
          if (result['data'].length > 0)
            currentPage += 1;
          else
            lockPage = true;
          result['data'].forEach((element) {
            products.add(ProductModel.fromJson(element));
          });
          isLoadingMore = false;
          notifyListeners();
        }
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          products.add(ProductModel.fromJson(element));
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
