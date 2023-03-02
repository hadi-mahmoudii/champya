import 'package:champya/Core/Config/urls.dart';
import 'package:champya/Core/Models/comment.dart';
import 'package:champya/Core/Models/server_request.dart';
import 'package:champya/Core/Widgets/error_result.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoDetailsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  List<CommentModel> comments = [];

  getDatas(BuildContext context, {bool resetPage = false}) async {
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getComments('course', 'videoId'),
    );
    result.fold(
      (error) async {
        // isLoading = false;
        // notifyListeners();
      },
      (result) {
        // print(result);
      },
    );
  }

  @override
  void reassemble() {}
}
