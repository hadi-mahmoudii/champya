import 'package:champya/Features/Program/Screens/edit_custom.dart';
import 'package:flutter/material.dart';

import '../../Features/Auth/Screens/forget.dart';
import '../../Features/Auth/Screens/login.dart';
import '../../Features/Auth/Screens/register.dart';
import '../../Features/Auth/Screens/submit_code.dart';
import '../../Features/General/Screens/home.dart';
import '../../Features/Product/Screens/details.dart';
import '../../Features/Product/Screens/list.dart';
import '../../Features/Profile/Screens/change-pass.dart';
import '../../Features/Profile/Screens/dashboard.dart';
import '../../Features/Profile/Screens/favorites.dart';
import '../../Features/Profile/Screens/info.dart';
import '../../Features/Profile/Screens/mentor-info.dart';
import '../../Features/Profile/Screens/my-favorites.dart';
import '../../Features/Profile/Screens/my-programs.dart';
import '../../Features/Program/Screens/add_custom.dart';
import '../../Features/Program/Screens/categories.dart';
import '../../Features/Program/Screens/category-details.dart';
import '../../Features/Program/Screens/custom-program-details.dart';
import '../../Features/Program/Screens/our-program-details.dart';
import '../../Features/Program/Screens/our-programs.dart';
import '../../Features/Program/Screens/program-details.dart';
import '../../Features/Program/Screens/series-details.dart';
import '../../Features/Video/Screens/add.dart';
import '../../Features/Video/Screens/details.dart';
import '../../Features/Video/Screens/list.dart';
import '../../Features/Video/Screens/show.dart';
import '../../Features/Workout/Screens/custom-serie-details.dart';
import '../../Features/Workout/Screens/rest.dart';
import '../../Features/Workout/Screens/work-prepration.dart';
import '../../Features/Workout/Screens/working-day-program.dart';
import '../../Features/Workout/Screens/workout.dart';
import '../main_screen.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const forgetPass = '/forgetPass';
  static const submitCode = '/submitCode';
  static const home = '/home';
  static const mainScreen = '/MainScreen';
  static const productDetails = '/productDetails';
  static const productList = '/productList';
  static const changePass = '/changePass';
  static const dashboard = '/dashboard';
  static const favorites = '/favorites';
  static const info = '/info';
  static const mentorInfo = '/mentorInfo';
  static const myFavorites = '/myFavorites';
  static const myPrograms = '/myPrograms';
  static const addCustomProgram = '/addCustomProgram';
  static const editCustomProgram = '/editCustomProgram';
  static const categories = '/categories';
  static const categoryDetails = '/courses';
  static const programDetails = '/ongoingProgramDetails';
  static const ourProgramDetails = '/ourProgramDetails';
  static const ourPrograms = '/ourPrograms';
  static const customProgramDetails = '/programDetails';
  static const seriesDetails = '/seriesDetails';
  static const addVideo = '/addVideo';
  static const videoDetails = '/videoDetails';
  static const videoList = '/videoList';
  static const showVideo = '/showVideo';
  static const customSerieDetails = '/customSerieDetails';
  static const workoutRestDetails = '/workoutRestDetails';
  static const workPrepration = '/workPrepration';
  static const workingDayProgram = '/workingDayProgram';
  static const workout = '/workout';

  final Map<String, Widget Function(BuildContext)> appRoutes = {
    Routes.login: (ctx) => LoginScreen(),
    Routes.register: (ctx) => RegisterScreen(),
    Routes.forgetPass: (ctx) => ForgetPassScreen(),
    Routes.submitCode: (ctx) => SubmitCodeScreen(),
    Routes.home: (ctx) => HomeScreen(),
    Routes.mainScreen: (ctx) => MainScreen(),
    Routes.productDetails: (ctx) => ProductDetailsScreen(),
    Routes.productList: (ctx) => ProductListScreen(),
    Routes.changePass: (ctx) => ChangePassScreen(),
    Routes.dashboard: (ctx) => DashboardScreen(),
    Routes.favorites: (ctx) => FavoritesScreen(),
    Routes.info: (ctx) => InfoScreen(),
    Routes.mentorInfo: (ctx) => MentorInfoScreen(),
    Routes.myFavorites: (ctx) => MyFavoritesScreen(),
    Routes.myPrograms: (ctx) => MyProgramsScreen(),
    Routes.addCustomProgram: (ctx) => AddCustomProgramScreen(),
    Routes.editCustomProgram: (ctx) => EditCustomProgramScreen(),
    Routes.categories: (ctx) => CategoriesScreen(),
    Routes.categoryDetails: (ctx) => CategoryDetailsScreen(),
    Routes.programDetails: (ctx) => ProgramDetailsScreen(),
    Routes.ourProgramDetails: (ctx) => OurProgramDetailsScreen(),
    Routes.ourPrograms: (ctx) => OurProgramsScreen(),
    Routes.customProgramDetails: (ctx) => CustomProgramDetailsScreen(),
    Routes.seriesDetails: (ctx) => SeriesDetailsScreen(),
    Routes.addVideo: (ctx) => AddVideoScreen(),
    Routes.videoDetails: (ctx) => VideoDetailsScreen(),
    Routes.videoList: (ctx) => VideoListScreen(),
    Routes.showVideo: (ctx) => ShowVideoScreen(),
    Routes.customSerieDetails: (ctx) => CustomSerieDetailsScreen(),
    Routes.workoutRestDetails: (ctx) => WorkoutRestScreen(),
    Routes.workPrepration: (ctx) => WorkPreprationScreen(),
    Routes.workingDayProgram: (ctx) => WorkingDayProgramScreen(),
    Routes.workout: (ctx) => WorkoutScreen(),
  };
}
