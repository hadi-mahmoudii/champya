import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Program/Models/program.dart';

class MentorInfoProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  // final String trainerId;

  // MentorInfoProvider({required this.trainerId});

  final TrainerModel trainer;

  MentorInfoProvider(this.trainer);

  // getDatas(BuildContext context, {bool resetPage = false}) async {
  //   isLoading = true;
  //   notifyListeners();

  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     Urls.getMentorInfo(trainerId),
  //   );
  //   result.fold(
  //     (error) async {
  //       // await ErrorResult.showDlg(error.type, context);
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //     (result) {
  //       // print(result);
  //       trainer = TrainerModel.fromJson(result['data']);
  //       // for (var item in result['data'].keys) {
  //       //   print(item);
  //       //   print(result['data'][item]);
  //       // }
  //       // program = OurProgramModel.fromJson(result['data']);
  //       // result['data'].forEach((element) {
  //       //   // print(element);
  //       //   programs.add(ProgramOverviewModel.fromJson(element));
  //       //   // print(result['children']);
  //       // });
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //   );
  // }

  @override
  void reassemble() {}
}
