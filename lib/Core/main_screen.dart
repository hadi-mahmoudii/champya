import 'dart:io';
import 'dart:ui';

import 'package:champya/Core/Widgets/flutter_icons.dart';
import 'package:champya/Features/Auth/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Features/General/Screens/home.dart';
import '../Features/Product/Screens/list.dart';
import '../Features/Profile/Screens/dashboard.dart';
import '../Features/Program/Screens/categories.dart';
import 'Config/app_session.dart';
import 'Widgets/loading.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

  bool isInit = true;
  bool isLoggedIn = false;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      isLoggedIn = await Provider.of<AppSession>(context, listen: false)
          .tryAutoLogin(context);
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again . . .');
      return Future.value(false);
    }
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return isInit
        ? const Center(
            child: LoadingWidget(),
          )
        : Consumer<AppSession>(
            builder: (ctx, provider, _) => WillPopScope(
              onWillPop: onWillPop,
              child: isLoggedIn
                  ? SafeArea(
                      child: Scaffold(
                        key: scaffoldKey,
                        body: PageView(
                          onPageChanged: (index) {
                            if (index > 3) {
                              return;
                            }
                            provider.changePage(index);
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            HomeScreen(),
                            CategoriesScreen(),
                            ProductListScreen(),
                            // VideoListScreen(),
                            DashboardScreen(),
                          ],
                          controller: provider.pgCtrl,
                        ),
                      ),
                    )
                  : LoginScreen(),
            ),
          );
  }
}

class GlobalBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppSession>(
      builder: (ctx, provider, _) => Container(
        color: Colors.transparent,
        height: 70,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30.0,
              sigmaY: 30.0,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: mainFontColor,
              unselectedItemColor: mainFontColor.withOpacity(.5),
              showUnselectedLabels: true,
              currentIndex: provider.selectedPage,
              onTap: (index) {
                provider.pgCtrl.jumpToPage(index);
              },
              elevation: 10,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.home_icon),
                  label: 'HOME',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.view_dashboard),
                  label: 'WORKOUTS',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.hexagon),
                  label: 'PRODUCTS',
                  backgroundColor: Colors.transparent,
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.video_collection),
                //   label: 'VIDEOES',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.heartbeat),
                  label: 'PROFILE',
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
