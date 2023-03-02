import 'package:champya/Features/Profile/Widgets/my-custom-program-navigator-row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Providers/my-programs.dart';
import '../Widgets/add-favorite-program-button.dart';
import '../Widgets/my-program-navigator-row.dart';

class MyProgramsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProgramsProvider>(
      create: (ctx) => MyProgramsProvider(),
      child: MyProgramsScreenTile(),
    );
  }
}

class MyProgramsScreenTile extends StatefulWidget {
  const MyProgramsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _MyProgramsScreenTileState createState() => _MyProgramsScreenTileState();
}

class _MyProgramsScreenTileState extends State<MyProgramsScreenTile>
    with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  @override
  initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);
    Future.microtask(
      () => Provider.of<MyProgramsProvider>(context, listen: false)
          .getPrograms(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<MyProgramsProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : RefreshIndicator(
                  onRefresh: () async =>
                      provider.getPrograms(context, resetPage: true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChampyaHeader(),
                        SizedBox(height: 15),
                        GlobalBackButton(
                          title: 'DASHBOARD',
                        ),
                        SimpleHeader(
                          mainHeader: 'MY PROGRAMS',
                          subHeader: 'PROGRAMS YOU CREATED',
                        ),
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
                                text: 'READY TO START',
                              ),
                              Tab(
                                text: 'ONGOING',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Builder(builder: (_) {
                            if (currentTabIndex == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: LayoutBuilder(
                                  builder: (ctx, cons) => ListView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      AddCustomProgramButton(
                                          themeData: themeData),
                                      SizedBox(height: 4),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, ind) =>
                                            MyCustomProgramNavigatorRow(
                                          themeData: themeData,
                                          program:
                                              provider.myCustomPrograms[ind],
                                          onBackFunction: () =>
                                              provider.getPrograms(context),
                                        ),
                                        separatorBuilder: (ctx, ind) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: SizedBox(height: 1),
                                        ),
                                        itemCount:
                                            provider.myCustomPrograms.length,
                                      )
                                    ],
                                  ),
                                ),
                              ); //1st custom tabBarView
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: LayoutBuilder(
                                  builder: (ctx, cons) => ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, ind) =>
                                        MyProgramNavigatorRow(
                                      themeData: themeData,
                                      program: provider.myPrograms[ind],
                                      onBackFunction: () =>
                                          provider.getPrograms(context),
                                    ),
                                    separatorBuilder: (ctx, ind) =>
                                        SizedBox(height: 1),
                                    itemCount: provider.myPrograms.length,
                                  ),
                                ),
                              ); //2nd tabView
                            }
                          }),
                        ),
                        // MyProgramsTabbar(
                        //   themeData: themeData,
                        //   provider: provider,
                        // ),
                        // SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
