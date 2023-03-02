import 'package:champya/Core/Config/app_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/champya_bottom_header.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/main_screen.dart';
import '../Providers/dashboard.dart';
import '../Widgets/dashboard-row-navigator.dart';
import '../Widgets/info-contact-navigator.dart';
import '../Widgets/logout-button.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardProvider>(
      create: (ctx) => DashboardProvider(),
      child: DashboardScreenTile(),
    );
  }
}

class DashboardScreenTile extends StatefulWidget {
  const DashboardScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardScreenTileState createState() => _DashboardScreenTileState();
}

class _DashboardScreenTileState extends State<DashboardScreenTile>
    with AutomaticKeepAliveClientMixin<DashboardScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<DashboardProvider>(
      builder: (ctx, provider, _) => Scaffold(
        bottomNavigationBar: GlobalBottomNavigationBar(),
        body: FilterWidget(
          child: LayoutBuilder(
            builder: (ctx, cons) => ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ChampyaHeader(),
                          // GlobalBackButton(title: 'Home'),
                          SimpleHeader(
                            mainHeader: 'YOUR DASHBOARD',
                            subHeader: '',
                          ),
                          Center(
                            child: Text(
                              'WELCOME',
                              style: themeData.button!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                          Center(
                            child: Text(
                              AppSession.userName,
                              style: themeData.headline3,
                            ),
                          ),
                          SizedBox(height: 15),
                          DashboardRowNavigator(
                            themeData: themeData,
                            title: 'MY PERSONAL INFO',
                            subtitle: 'Like name, email, address …',
                            route: Routes.info,
                          ),
                          DashboardRowNavigator(
                            themeData: themeData,
                            title: 'CHANGE MY PASSWORD',
                            subtitle: 'Reset your password',
                            route: Routes.changePass,
                          ),
                          DashboardRowNavigator(
                            themeData: themeData,
                            title: 'MY PROGRAMS',
                            subtitle: 'Manage the program for your sport life',
                            route: Routes.myPrograms,
                          ),
                          DashboardRowNavigator(
                            themeData: themeData,
                            title: 'MY FAVORITES',
                            subtitle:
                                'The workouts you marked as your loved ones',
                            route: Routes.myFavorites,
                          ),
                          // DashboardRowNavigator(
                          //   themeData: themeData,
                          //   title: 'MY VIDEOES',
                          //   subtitle: 'The Videos you uploaded',
                          //   route: Routes.videoList,
                          // ),
                          SizedBox(height: 25),
                          LogoutButton(
                            themeData: themeData,
                            func: () => provider.logout(context),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                    InfoContactNavigators(themeData: themeData),
                    ChampyaBottomHeader(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
