import 'package:champya/Features/Program/Widgets/like-percent-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Providers/program-details.dart';
import '../Widgets/my-program-info-item.dart';
import '../Widgets/program-prograss-item.dart';

class ProgramDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProgramDetailsProvider>(
      create: (ctx) => ProgramDetailsProvider(
          ModalRoute.of(context)!.settings.arguments as String),
      child: ProgramDetailsScreenTile(),
    );
  }
}

class ProgramDetailsScreenTile extends StatefulWidget {
  const ProgramDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _ProgramDetailsScreenTileState createState() =>
      _ProgramDetailsScreenTileState();
}

class _ProgramDetailsScreenTileState extends State<ProgramDetailsScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ProgramDetailsProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<ProgramDetailsProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : RefreshIndicator(
                  onRefresh: () async => print('object'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        ChampyaHeader(),
                        SizedBox(height: 15),
                        GlobalBackButton(
                          title: 'PROGRAMS',
                        ),
                        SimpleHeader(
                          mainHeader: 'PRGRAM DETAILS',
                          subHeader: 'PROGRAMS YOU CREATED',
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.program!.title,
                                    style: themeData.headline3!
                                        .copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    provider.program!.decription,
                                    style: themeData.subtitle2!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            DonePercentWidget(
                              themeData: themeData,
                              value: provider.program!.donePercent,
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ProgramDetailsInfoItem(
                                title: 'Duration',
                                value:
                                    ' ${provider.program!.sessionLength}sessions',
                                themeData: themeData,
                              ),
                            ),
                            Expanded(
                              child: ProgramDetailsInfoItem(
                                title: 'Session per week',
                                value:
                                    ' ${provider.program!.sessionPerWeek}sessions',
                                themeData: themeData,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ProgramDetailsInfoItem(
                                title: 'Begin date',
                                value: provider.program!.startDate,
                                themeData: themeData,
                              ),
                            ),
                            Expanded(
                              child: ProgramDetailsInfoItem(
                                title: 'End date',
                                value: provider.program!.endDate,
                                themeData: themeData,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 45),
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch_later_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 7),
                              Text(
                                provider.program!.nextDate.toUpperCase(),
                                style: themeData.headline3,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 10,
                            childAspectRatio: 85 / 100,
                          ),
                          itemBuilder: (ctx, ind) => ProgramPrograssItem(
                            dayDatas: provider.program!.days[ind],
                            programId: provider.program!.id,
                          ),
                          itemCount: provider.program!.days.length,
                        ),
                        SizedBox(height: 45),
                        InkWell(
                          onTap: () => provider.stopProgram(context),
                          child: Container(
                            color: Color(0XFFEE3552).withOpacity(.1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Text(
                              'stop and leave the program'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0XFFEE3552),
                                fontSize: 15,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
