import 'package:champya/Core/Config/routes.dart';
import 'package:champya/Core/Widgets/flutter_icons.dart';
import 'package:champya/Core/Widgets/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../Providers/custom-program-details.dart';
import '../Widgets/serie-row-navigator.dart';

class CustomProgramDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomProgramDetailsProvider>(
      create: (ctx) => CustomProgramDetailsProvider(
          ModalRoute.of(context)!.settings.arguments as String),
      child: CustomProgramDetailsScreenTile(),
    );
  }
}

class CustomProgramDetailsScreenTile extends StatefulWidget {
  const CustomProgramDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _CustomProgramDetailsScreenTileState createState() =>
      _CustomProgramDetailsScreenTileState();
}

class _CustomProgramDetailsScreenTileState
    extends State<CustomProgramDetailsScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<CustomProgramDetailsProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<CustomProgramDetailsProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      ChampyaHeader(),
                      SizedBox(height: 15),
                      GlobalBackButton(title: 'MY PROGRAMS'),
                      SimpleHeader(
                        mainHeader: 'program details',
                        subHeader: 'programs you created',
                      ),
                      SizedBox(height: 15),
                      Text(
                        provider.program.title,
                        style: themeData.headline3!.copyWith(fontSize: 20),
                        maxLines: 1,
                      ),
                      Text(
                        provider.program.decription,
                        style: themeData.subtitle2!.copyWith(fontSize: 14),
                        maxLines: 1,
                      ),
                      // SizedBox(height: 10),
                      //TODO : details row

                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Expanded(
                      //       child: ProgramDetailsInfoItem(
                      //         title: 'Duration',
                      //         value: ' 12sessions',
                      //         themeData: themeData,
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: ProgramDetailsInfoItem(
                      //         title: 'Session Per Week',
                      //         value: ' 3sessions',
                      //         themeData: themeData,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 15),
                      LayoutBuilder(
                        builder: (ctx, cons) => ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, ind) => SerieRowNavigator(
                            themeData: themeData,
                            serie: provider.program.series[ind],
                            index: ind + 1,
                            programId: provider.program.id,
                            onBackFunction: () => provider.getDatas(context),
                          ),
                          separatorBuilder: (ctx, ind) => SizedBox(
                            height: 5,
                          ),
                          itemCount: provider.program.series.length,
                        ),
                      ),
                      SizedBox(height: 15),
                      SubmitButton(
                        func: () => provider.showAddSerieModal(context),
                        icon: null,
                        title: 'ADD NEW SERIES',
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextIconButton(
                            function: () => Navigator.of(context).pushNamed(
                              Routes.editCustomProgram,
                              arguments: provider.program,
                            ),
                            title: 'EDIT',
                            icon: Icons.edit,
                          ),
                          TextIconButton(
                            function: () => provider.deleteProgram(context),
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
                              // color: Color(0XFFFFFFFF).withOpacity(.3),
                              // height: 45,
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
                                            '''ongoing programs can not be edited or removed.for modifying please first stop the program.''',
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
                      provider.program.series.length > 0
                          ? SubmitButton2(
                              themeData: themeData,
                              title: '''Start
this
program''',
                              func: () =>
                                  provider.showStartProgramModal(context),
                              //program must remove when add to started programs(backend)
                              icon: FlutterIcons.play_linear,
                            )
                          : Container(),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
