import 'package:champya/Core/Config/routes.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/comment.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/product.dart';

class ProductDetailsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  final ProductModel product;

  ProductDetailsProvider({required this.product});

  List<CommentModel> comments = [];

  getDatas(BuildContext context, {bool resetPage = false}) async {
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getComments('course', product.id),
    );
    result.fold(
      (error) async {
        // isLoading = false;
        // notifyListeners();
      },
      (result) {
        // print(result);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  addComment(BuildContext context, TextEditingController comment) async {
    Navigator.of(context).pop();
    isLoading = true;
    notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.sendComment,
      datas: {
        'commentable_type': 'product',
        'commentable_id': product.id,
        'comment': comment.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // print(result);
        Fluttertoast.showToast(msg: 'Done');
        Navigator.of(context)
            .popAndPushNamed(Routes.productDetails, arguments: product);
      },
    );
  }

  @override
  void reassemble() {}
}
