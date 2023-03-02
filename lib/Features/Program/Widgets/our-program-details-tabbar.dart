// import 'package:flutter/material.dart';

// import '../../../Core/Widgets/add_comment_button.dart';
// import '../../../Core/Widgets/comment_box.dart';
// import '../Providers/our-program-details.dart';
// import 'our-program-workout-navigator.dart';

// class OurProgramDetailsTabbar extends StatefulWidget {
//   const OurProgramDetailsTabbar({
//     Key? key,
//     required this.themeData,
//     required this.provider,
//     required this.contx,
//   }) : super(key: key);

//   final TextTheme themeData;
//   final OurProgramDetailsProvider provider;
//   final BuildContext contx;
//   @override
//   State<OurProgramDetailsTabbar> createState() =>
//       _OurProgramDetailsTabbarState();
// }

// class _OurProgramDetailsTabbarState extends State<OurProgramDetailsTabbar>
//     with TickerProviderStateMixin {
//   late TabController tabCtrl;
//   int currentTabIndex = 0;
//   @override
//   initState() {
//     super.initState();
//     tabCtrl = TabController(length: 2, vsync: this);
//     // Future.microtask(
//     //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.grey.withOpacity(.7),
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () {
//                   tabCtrl.animateTo(0);
//                   setState(() {
//                     currentTabIndex = 0;
//                   });
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: currentTabIndex == 0
//                             ? Colors.white
//                             : Colors.transparent,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     'WORKOUTS',
//                     style: widget.themeData.headline6!.copyWith(
//                       color: currentTabIndex == 0 ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 25),
//               InkWell(
//                 onTap: () {
//                   tabCtrl.animateTo(1);
//                   setState(() {
//                     currentTabIndex = 1;
//                   });
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: currentTabIndex == 1
//                             ? Colors.white
//                             : Colors.transparent,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     'COMMENTS',
//                     style: widget.themeData.headline6!.copyWith(
//                       color: currentTabIndex == 1 ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 3,
//           child: DefaultTabController(
//             length: 2,
//             child: TabBarView(
//               physics: NeverScrollableScrollPhysics(),
//               controller: tabCtrl,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: LayoutBuilder(
//                     builder: (ctx, cons) => ListView.separated(
//                       shrinkWrap: true,
//                       // physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, ind) => OurProgramWorkoutNavigator(
//                         themeData: widget.themeData,
//                         serie: widget.provider.program.series[ind],
//                         index: ind += 1,
//                       ),
//                       separatorBuilder: (ctx, ind) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         child: SizedBox(height: 4),
//                       ),
//                       itemCount: widget.provider.program.series.length,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: ListView(
//                     children: [
//                       AddNewCommentButton(
//                         themeData: widget.themeData,
//                         contx: widget.contx,
//                         function: (commentCtrl) =>
//                             widget.provider.addComment(context, commentCtrl),
//                       ),
//                       SizedBox(height: 10),
//                       LayoutBuilder(
//                         builder: (ctx, cons) => ListView.separated(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemBuilder: (ctx, ind) => CommentBox(
//                             cons: cons,
//                             themeData: widget.themeData,
//                             comment: widget.provider.commnets[ind],
//                           ),
//                           separatorBuilder: (ctx, ind) => SizedBox(
//                             height: 20,
//                           ),
//                           itemCount: widget.provider.commnets.length,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
