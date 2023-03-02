// import 'package:flutter/material.dart';

// import '../Providers/my-programs.dart';
// import 'add-favorite-program-button.dart';
// import 'my-custom-program-navigator-row.dart';
// import 'my-program-navigator-row.dart';

// class MyProgramsTabbar extends StatefulWidget {
//   const MyProgramsTabbar({
//     Key? key,
//     required this.themeData,
//     required this.provider,
//   }) : super(key: key);

//   final TextTheme themeData;
//   final MyProgramsProvider provider;
//   @override
//   State<MyProgramsTabbar> createState() => _MyProgramsTabbarState();
// }

// class _MyProgramsTabbarState extends State<MyProgramsTabbar>
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
//                     'READY TO START',
//                     style: widget.themeData.headline6!.copyWith(
//                       color: currentTabIndex == 0 ? Colors.white : Colors.grey,
//                       letterSpacing: 3,
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
//                     'ONGOING',
//                     style: widget.themeData.headline6!.copyWith(
//                       letterSpacing: 3,
//                       color: currentTabIndex == 1 ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 7 / 10,
//           child: DefaultTabController(
//             length: 2,
//             child: TabBarView(
//               physics: NeverScrollableScrollPhysics(),
//               controller: tabCtrl,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: LayoutBuilder(
//                     builder: (ctx, cons) => ListView(
//                       shrinkWrap: true,
//                       children: [
//                         AddCustomProgramButton(themeData: widget.themeData),
//                         SizedBox(height: 4),
//                         ListView.separated(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (ctx, ind) =>
//                               MyCustomProgramNavigatorRow(
//                             themeData: widget.themeData,
//                             program: widget.provider.myCustomPrograms[ind],
//                           ),
//                           separatorBuilder: (ctx, ind) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 50),
//                             child: SizedBox(height: 1),
//                           ),
//                           itemCount: widget.provider.myCustomPrograms.length,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: LayoutBuilder(
//                     builder: (ctx, cons) => ListView.separated(
//                       shrinkWrap: true,
//                       itemBuilder: (ctx, ind) => MyProgramNavigatorRow(
//                         themeData: widget.themeData,
//                         program: widget.provider.myPrograms[ind],
//                       ),
//                       separatorBuilder: (ctx, ind) => SizedBox(height: 1),
//                       itemCount: widget.provider.myPrograms.length,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
