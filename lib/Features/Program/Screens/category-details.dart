import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Models/category-overview.dart';
import '../Providers/category-details.dart';
import '../Widgets/category-program-navigator.dart';
import '../Widgets/category-workout-navigator.dart';

class CategoryDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryDetails>(
      create: (ctx) => CategoryDetails(
          category: ModalRoute.of(context)!.settings.arguments
              as CategoryOverviewModel),
      child: CategoryDetailsScreenTile(),
    );
  }
}

class CategoryDetailsScreenTile extends StatefulWidget {
  const CategoryDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryDetailsScreenTileState createState() =>
      _CategoryDetailsScreenTileState();
}

class _CategoryDetailsScreenTileState extends State<CategoryDetailsScreenTile>
    with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  @override
  initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);

    Future.microtask(
      () => Provider.of<CategoryDetails>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Consumer<CategoryDetails>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (provider.scrollController.position.pixels >
                          provider.scrollController.position.maxScrollExtent -
                              30) {
                        if (currentTabIndex == 0 &&
                            !provider.isLoadingMoreCourse) {
                          provider.getCourses();
                        }
                        if (currentTabIndex == 1 &&
                            !provider.isLoadingMoreWorkout) {
                          provider.getWorkouts();
                        }
                      }
                    }
                    return true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      controller: provider.scrollController,
                      children: [
                        ChampyaHeader(),
                        SizedBox(height: 15),
                        GlobalBackButton(title: 'RETURN'),
                        SimpleHeader(
                          mainHeader: 'CATEGORy DETAILS',
                          subHeader: 'we care about your health',
                        ),
                        // SizedBox(height: 20),
                        //TODO : filters must add here

                        // CategoryDetailsFilterButton(themeData: themeData),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: .25,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TabBar(
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            unselectedLabelColor: const Color(0XFFA8A8A8),
                            controller: tabCtrl,
                            onTap: (index) {
                              setState(() {
                                currentTabIndex = index;
                              });
                            },
                            tabs: const [
                              Tab(
                                text: 'PROGRAMS',
                              ),
                              Tab(
                                text: 'WORKOUTS',
                              ),
                            ],
                          ),
                        ),

                        Builder(builder: (_) {
                          if (currentTabIndex == 0) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: LayoutBuilder(
                                builder: (ctx, cons) => ListView.separated(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (ctx, ind) =>
                                      CategoryProgramNavigator(
                                    themeData: themeData,
                                    program: provider.programs[ind],
                                  ),
                                  separatorBuilder: (ctx, ind) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Divider(
                                      color: Colors.white,
                                      height: 10,
                                    ),
                                  ),
                                  itemCount: provider.programs.length,
                                ),
                              ),
                            ); //1st custom tabBarView
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: LayoutBuilder(
                                builder: (ctx, cons) => ListView.separated(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (ctx, ind) =>
                                      CategoryWorkoutNavigator(
                                    themeData: themeData,
                                    cons: cons,
                                    workout: provider.workouts[ind],
                                  ),
                                  separatorBuilder: (ctx, ind) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Divider(
                                        color: Colors.grey.withOpacity(.6),
                                      ),
                                    ),
                                  ),
                                  itemCount: provider.workouts.length,
                                ),
                              ),
                            ); //2nd tabView
                          }
                        }),
                        // CategoryDetailsTabbar(
                        //   themeData: themeData,
                        //   provider: provider,
                        // ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
