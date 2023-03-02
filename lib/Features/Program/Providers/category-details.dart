import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/category-overview.dart';
import '../Models/program-overview.dart';
import '../Models/workout-overview.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends ChangeNotifier with ReassembleHandler {
  final CategoryOverviewModel category;

  CategoryDetails({required this.category});

  bool isLoading = false;
  bool isLoadingMoreCourse = false;
  bool isLoadingMoreWorkout = false;
  ScrollController scrollController = ScrollController();
  bool lockLoadMoreCourse = false;
  bool lockLoadMoreWorkout = false;
  int courseCurrentPage = 1;
  int workoutCurrentPage = 1;
  // int currentTabIndex = 0;
  List<ProgramOverviewModel> programs = [];
  List<WorkoutOverviewModel> workouts = [];

  getCourses() async {
    if (lockLoadMoreCourse) {
      return;
    }
    if (courseCurrentPage == 1) {
      programs = [];
      // isLoading = true;
      // notifyListeners();
    } else {
      isLoadingMoreCourse = true;
      notifyListeners();
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getCategoryProgramData(category.id, courseCurrentPage.toString()),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        print(result);
        if (courseCurrentPage == 1) {
          result['data'].forEach((element) {
            // print(element);
            programs.add(ProgramOverviewModel.fromJson(element));
            // print(result['children']);
          });
          courseCurrentPage += 1;
        } else {
          if (result['data'].length > 0)
            courseCurrentPage += 1;
          else
            lockLoadMoreCourse = true;
          result['data'].forEach((element) {
            // print(element);
            programs.add(ProgramOverviewModel.fromJson(element));
            // print(result['children']);
          });
          isLoadingMoreCourse = false;
          notifyListeners();
        }
      },
    );
  }

  getWorkouts() async {
    if (lockLoadMoreWorkout) {
      return;
    }
    if (workoutCurrentPage == 1) {
      workouts = [];
      // isLoading = true;
      // notifyListeners();
    } else {
      isLoadingMoreWorkout = true;
      notifyListeners();
    }
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(
      Urls.getCategoryWorkoutData(category.id, workoutCurrentPage.toString()),
    );
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading = false;
        notifyListeners();
      },
      (result) {
        print(result);
        if (workoutCurrentPage == 1) {
          result['data'].forEach((element) {
            // print(element);
            workouts.add(WorkoutOverviewModel.fromJson(element));
            // print(result['children']);
          });
          workoutCurrentPage += 1;
        } else {
          if (result['data'].length > 0)
            workoutCurrentPage += 1;
          else
            lockLoadMoreWorkout = true;
          result['data'].forEach((element) {
            // print(element);
            workouts.add(WorkoutOverviewModel.fromJson(element));
            // print(result['children']);
          });
          isLoadingMoreWorkout = false;
          notifyListeners();
        }
      },
    );
  }

  getDatas(BuildContext context, {bool resetPage = false}) async {
    programs = [];
    workouts = [];
    lockLoadMoreCourse = false;
    lockLoadMoreWorkout = false;
    isLoading = true;
    notifyListeners();
    await getCourses();
    await getWorkouts();
    isLoading = false;
    notifyListeners();
  }

  // getWorkouts(BuildContext context, {bool resetPage = false}) async {
  //   if (lockPage) return;
  //   if (resetPage) workoutCurrentPage = 1;
  //   if (workoutCurrentPage == 1) {
  //     workouts = [];
  //     isLoading = true;
  //     // scrollController.jumpTo(0);
  //     notifyListeners();
  //   } else {
  //     isLoadingMore = true;
  //     notifyListeners();
  //   }
  //   // print(Urls.cetprograms(selectedBrand.id));
  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     Urls.getCategoryWorkoutData(category.id),
  //   );
  //   result.fold(
  //     (error) async {
  //       // await ErrorResult.showDlg(error.type, context);
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //     (result) {
  //       print(result);
  //       result['data'].forEach((element) {
  //         // print(element);
  //         workouts.add(WorkoutOverviewModel.fromJson(element));
  //         // print(result['children']);
  //       });
  //       currentTabIndex = 1;
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //   );
  // }

  @override
  void reassemble() {}
}
