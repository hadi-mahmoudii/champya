import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/add_comment_button.dart';
import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/comment_box.dart';
import '../../../Core/Widgets/filter.dart' as originalFilter;
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Models/program-overview.dart';
import '../Providers/our-program-details.dart';
import '../Widgets/mentor-navigator-box.dart';
import '../Widgets/our-program-workout-navigator.dart';

class OurProgramDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OurProgramDetailsProvider>(
      create: (ctx) => OurProgramDetailsProvider(
          programOverview: ModalRoute.of(context)!.settings.arguments
              as ProgramOverviewModel),
      child: OurProgramDetailsScreenTile(),
    );
  }
}

class OurProgramDetailsScreenTile extends StatefulWidget {
  const OurProgramDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _OurProgramDetailsScreenTileState createState() =>
      _OurProgramDetailsScreenTileState();
}

class _OurProgramDetailsScreenTileState
    extends State<OurProgramDetailsScreenTile>
    with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  @override
  initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);

    Future.microtask(
      () => Provider.of<OurProgramDetailsProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<OurProgramDetailsProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: provider.isLoading
            ? originalFilter.FilterWidget(
                child: Center(
                  child: LoadingWidget(),
                ),
              )
            : FilterWidget(
                // imagePath: 'assets/Images/image2.jpg',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      ChampyaHeader(),
                      SizedBox(height: 15),
                      GlobalBackButton(title: 'CATEGORy Details'),
                      SimpleHeader(
                        mainHeader: 'Program DETAILS',
                        subHeader: 'feel the power',
                      ),
                      SizedBox(height: 20),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              provider.program.image,
                              fit: BoxFit.fill,
                              height: 200,
                              width: double.infinity,
                              errorBuilder: (ctx, obj, _) => Center(
                                child: Image.asset(
                                  'assets/Images/program_placeholder.png',
                                  fit: BoxFit.fill,
                                  height: 200,
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 8,
                          //   right: 10,
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //       vertical: 5,
                          //       horizontal: 10,
                          //     ),
                          //     decoration: BoxDecoration(
                          //       color: Colors.black,
                          //       borderRadius: BorderRadius.only(
                          //         bottomRight: Radius.circular(20),
                          //       ),
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           FlutterIcons.align_right,
                          //           size: 12,
                          //           color: Colors.white,
                          //         ),
                          //         SizedBox(width: 5),
                          //         Text(
                          //           '2',
                          //           style: Theme.of(context).textTheme.button,
                          //         ),
                          //         SizedBox(width: 15),
                          //         Icon(
                          //           FlutterIcons.clock_1,
                          //           size: 12,
                          //           color: Colors.white,
                          //         ),
                          //         SizedBox(width: 5),
                          //         Text(
                          //           '15:30',
                          //           style: Theme.of(context).textTheme.button,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        provider.program.title,
                        style: themeData.headline3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        provider.program.decription,
                        textAlign: TextAlign.left,
                        style: themeData.button,
                      ),
                      SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.symmetric(
                      //           vertical: 5, horizontal: 10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0XFFDDDDDD),
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       child: Text(
                      //         '3 SETS',
                      //         style: themeData.bodyText1!.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 3),
                      //     Container(
                      //       padding: EdgeInsets.symmetric(
                      //           vertical: 5, horizontal: 10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0XFFDDDDDD),
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       child: Text(
                      //         '12 WORKOUTS',
                      //         style: themeData.bodyText1!.copyWith(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     Spacer(),
                      //   ],
                      // ),
                      SizedBox(height: 30),
                      SubmitButton(
                        func: () => provider.showStartProgramModal(context),
                        icon: Icons.play_arrow,
                        title: 'BEGIN THIS PROGRAM',
                      ),
                      SizedBox(height: 25),
                      MentorNavigatorBox(
                        themeData: themeData,
                        trainer: provider.program.trainer,
                        courseId: provider.program.id,
                      ),
                      const SizedBox(height: 50),
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
                              text: 'WORKOUTS',
                            ),
                            Tab(
                              text: 'COMMENTS',
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
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, ind) =>
                                    OurProgramWorkoutNavigator(
                                  themeData: themeData,
                                  serie: provider.program.series[ind],
                                  index: ind += 1,
                                ),
                                separatorBuilder: (ctx, ind) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: SizedBox(height: 4),
                                ),
                                itemCount: provider.program.series.length,
                              ),
                            ),
                          ); //1st custom tabBarView
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: provider.isLoadingComments
                                ? Center(
                                    child: LoadingWidget(),
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    children: [
                                      AddNewCommentButton(
                                        themeData: themeData,
                                        contx: context,
                                        function: (commentCtrl) => provider
                                            .addComment(context, commentCtrl),
                                      ),
                                      SizedBox(height: 10),
                                      LayoutBuilder(
                                        builder: (ctx, cons) =>
                                            ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (ctx, ind) => CommentBox(
                                            cons: cons,
                                            themeData: themeData,
                                            comment: provider.commnets[ind],
                                          ),
                                          separatorBuilder: (ctx, ind) =>
                                              SizedBox(
                                            height: 20,
                                          ),
                                          itemCount: provider.commnets.length,
                                        ),
                                      ),
                                    ],
                                  ),
                          ); //2nd tabView
                        }
                      }),
                      // OurProgramDetailsTabbar(
                      //   themeData: themeData,
                      //   provider: provider,
                      //   contx: context,
                      // ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final Widget child;
  final String imagePath;
  const FilterWidget({
    Key? key,
    required this.child,
    this.imagePath = 'assets/Images/background.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    return Container(
      height: mediaData.size.height,
      width: mediaData.size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
