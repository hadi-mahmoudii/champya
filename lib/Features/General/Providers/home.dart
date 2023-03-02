import 'package:champya/Features/General/Models/section.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Program/Models/category-overview.dart';
import '../../Program/Models/program-overview.dart';

class HomeProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = true;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  List<CategoryOverviewModel> categories = [];
  List<ProgramOverviewModel> latestPrograms = [];
  List<ProgramOverviewModel> selectedPrograms = [];
  List<ProgramOverviewModel> topPrograms = [];

  List<HomeSectionModel> sections = [];
  // getDatas(BuildContext context, {bool resetPage = false}) async {
  //   if (resetPage) {
  //     categories = [];
  //     latestPrograms = [];
  //     selectedPrograms = [];
  //     topPrograms = [];
  //   }
  //   isLoading = true;
  //   notifyListeners();
  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     Urls.home,
  //   );
  //   result.fold(
  //     (error) async {
  //       // await ErrorResult.showDlg(error.type, context);
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //     (result) {
  //       // for (var item in result['data'].keys) {
  //       //   print(item);
  //       //   print(result['data'][item]);
  //       // }
  //       try {
  //         result['data']['sport_categories'].forEach((element) {
  //           categories.add(CategoryOverviewModel.fromJson(element));
  //         });
  //       } catch (e) {}
  //       try {
  //         result['data']['latest_release'].forEach((element) {
  //           latestPrograms.add(ProgramOverviewModel.fromJson(element));
  //         });
  //       } catch (e) {}
  //       try {
  //         result['data']['top_course'].forEach((element) {
  //           topPrograms.add(ProgramOverviewModel.fromJson(element));
  //         });
  //       } catch (e) {}
  //       try {
  //         result['data']['selected_course'].forEach((element) {
  //           selectedPrograms.add(ProgramOverviewModel.fromJson(element));
  //         });
  //       } catch (e) {}
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //   );
  // }

  fetchDatas({bool resetPage = false, bool resetFilter = false}) async {
    if (resetPage) {
      sections.clear();
    }
    // final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
    //   Urls.home,
    // );
    // result.fold(
    //   (error) async {
    //     // await ErrorResult.showDlg(error.type, context);
    //     isLoading = false;
    //     notifyListeners();
    //   },
    //   (result) {
    //     try {
    //       result['data']['sport_categories'].forEach((element) {
    //         categories.add(CategoryOverviewModel.fromJson(element));
    //       });
    //     } catch (e) {}
    //     isLoading = false;
    //     notifyListeners();
    //   },
    // );
    isLoading = true;
    notifyListeners();
    Either<ErrorResult, dynamic> res = await ServerRequest().fetchData(
      Urls.getSections,
    );
    res.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        // try {
        result['data'].forEach((element) {
          final HomeSectionModel section = HomeSectionModel.fromJson(element);
          //TODO : product and workout most add
          if (section.sections.isNotEmpty && section.type != 'product')
            sections.add(section);
        });
        // } catch (e) {}
        sections
            .sort(((a, b) => int.parse(a.sort).compareTo(int.parse(b.sort))));
      },
    );
    isLoading = false;
    notifyListeners();
  }

  @override
  void reassemble() {}
}
