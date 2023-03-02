import '../Providers/category-details.dart';
import 'package:flutter/material.dart';

import 'category-program-navigator.dart';
import 'category-workout-navigator.dart';

class CategoryDetailsTabbar extends StatefulWidget {
  const CategoryDetailsTabbar({
    Key? key,
    required this.themeData,
    required this.provider,
  }) : super(key: key);

  final TextTheme themeData;
  final CategoryDetails provider;
  @override
  State<CategoryDetailsTabbar> createState() => _CategoryDetailsTabbarState();
}

class _CategoryDetailsTabbarState extends State<CategoryDetailsTabbar>
    with TickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  @override
  initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  tabCtrl.animateTo(0);
                  setState(() {
                    currentTabIndex = 0;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: currentTabIndex == 0
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    'PROGRAMS',
                    style: widget.themeData.headline6!.copyWith(
                      color: currentTabIndex == 0 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 25),
              InkWell(
                onTap: () {
                  tabCtrl.animateTo(1);
                  setState(() {
                    currentTabIndex = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: currentTabIndex == 1
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    'WORKOUTS',
                    style: widget.themeData.headline6!.copyWith(
                      color: currentTabIndex == 1 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 3,
          child: DefaultTabController(
            length: 2,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabCtrl,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LayoutBuilder(
                    builder: (ctx, cons) => ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (ctx, ind) => CategoryProgramNavigator(
                        themeData: widget.themeData,
                        program: widget.provider.programs[ind],
                      ),
                      separatorBuilder: (ctx, ind) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Divider(
                          color: Colors.white,
                          height: 10,
                        ),
                      ),
                      itemCount: widget.provider.programs.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LayoutBuilder(
                    builder: (ctx, cons) => ListView.separated(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, ind) => CategoryWorkoutNavigator(
                        themeData: widget.themeData,
                        cons: cons,
                        workout: widget.provider.workouts[ind],
                      ),
                      separatorBuilder: (ctx, ind) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Divider(
                            color: Colors.grey.withOpacity(.6),
                          ),
                        ),
                      ),
                      itemCount: widget.provider.workouts.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
