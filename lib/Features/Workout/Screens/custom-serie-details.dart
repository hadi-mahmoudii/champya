import 'package:champya/Core/Config/routes.dart';
import 'package:champya/Core/Widgets/empty2.dart';
import 'package:champya/Features/Program/Models/custom-program.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/text_icon_button.dart';
import '../Providers/custom-serie-details.dart';
import '../Widgets/wokrday-row-box.dart';

class CustomSerieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List args =
        ModalRoute.of(context)!.settings.arguments! as List<dynamic>;
    return ChangeNotifierProvider<CustomSerieDetailsProvider>(
      create: (ctx) => CustomSerieDetailsProvider(
        args[0] as SerieRowModel,
        args[1] as String,
      ),
      child: CustomSerieDetailsScreenTile(),
    );
  }
}

class CustomSerieDetailsScreenTile extends StatefulWidget {
  const CustomSerieDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _CustomSerieDetailsScreenTileState createState() =>
      _CustomSerieDetailsScreenTileState();
}

class _CustomSerieDetailsScreenTileState
    extends State<CustomSerieDetailsScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<CustomSerieDetailsProvider>(
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
                              provider.scrollController.position
                                      .maxScrollExtent -
                                  30 &&
                          provider.isLoadingMore) {}
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async => print('object'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        controller: provider.scrollController,
                        children: [
                          ChampyaHeader(),
                          SizedBox(height: 15),
                          GlobalBackButton(
                            title: 'PROGRAM DETAILS',
                          ),
                          SimpleHeader(
                            mainHeader: 'WORKDAY DETAILS',
                            subHeader: 'PROGRAMS YOU CREATED',
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              provider.serie.name,
                              style: themeData.headline3!
                                  .copyWith(letterSpacing: 4),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Divider(
                              color: Colors.white,
                              thickness: .3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // TextIconButton(
                              //   function: () {},
                              //   title: 'EDIT',
                              //   icon: Icons.edit,
                              // ),
                              TextIconButton(
                                function: () => provider.deleteSerie(context),
                                title: 'REMOVE',
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            color: Color(0XFFFFFFFF).withOpacity(.1),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  color: Color(0XFFFFFFFF).withOpacity(.3),
                                  height: 45,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  child: Icon(
                                    FlutterIcons.book_reader,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 7),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'NOTE! ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '''ongoing programs can not be edited or removed. for modifying please first stop the program.''',
                                            style: TextStyle(
                                              color: Color(0XFFC9C9C9),
                                              fontFamily: 'montserratlight',
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Text(
                            'WORKOUTS',
                            style: themeData.headline3!.copyWith(fontSize: 22),
                          ),
                          Text(
                            'WHAT YOU SHOULD DO',
                            style: themeData.subtitle2!.copyWith(fontSize: 14),
                          ),
                          SizedBox(height: 20),
                          // Text(
                          //   'Best Moves 6 Packs',
                          //   style: themeData.headline3!.copyWith(fontSize: 22),
                          // ),
                          provider.serie.workouts.isNotEmpty
                              ? LayoutBuilder(
                                  builder: (ctx, cons) => ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, ind) => WorkdayRowBox(
                                      themeData: themeData,
                                      cons: cons,
                                      workout: provider.serie.workouts[ind],
                                    ),
                                    separatorBuilder: (ctx, ind) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Divider(
                                        height: 22,
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                    ),
                                    itemCount: provider.serie.workouts.length,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: Center(
                                    child: EmptyWidget2(
                                      header: 'No Workout Yet',
                                      description:
                                          '''please navigate to workouts section and choose the desired workouts to add to this program''',
                                      buttonText: 'START HERE',
                                      function: () {
                                        Navigator.of(context)
                                            .pushNamed(
                                              Routes.categories,
                                              arguments: true,
                                            )
                                            .then((value) =>
                                                Navigator.of(context).pop());
                                      },
                                    ),
                                  ),
                                ),
                          // Divider(color: Colors.white),
                          SizedBox(height: 50),
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
