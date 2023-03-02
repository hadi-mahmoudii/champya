import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Models/program.dart';
import '../Widgets/serie_row_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../Providers/series-details.dart';

class SeriesDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeriesDetailsProvider>(
      create: (ctx) => SeriesDetailsProvider(
          serie: (ModalRoute.of(context)!.settings.arguments!
              as List<Object>)[0] as SerieRowModel),
      child: SeriesDetailsScreenTile(),
    );
  }
}

class SeriesDetailsScreenTile extends StatefulWidget {
  const SeriesDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _SeriesDetailsScreenTileState createState() =>
      _SeriesDetailsScreenTileState();
}

class _SeriesDetailsScreenTileState extends State<SeriesDetailsScreenTile> {
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
    return Consumer<SeriesDetailsProvider>(
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
                          title: 'PROGRAM DETAILS',
                        ),
                        SimpleHeader(
                          mainHeader: 'SERIES DETAILS',
                          subHeader: 'PROGRAMS YOU CREATED',
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Text(
                            'SERIES ${(ModalRoute.of(context)!.settings.arguments! as List<Object>)[1]}',
                            style:
                                themeData.headline3!.copyWith(letterSpacing: 4),
                          ),
                        ),
                        SizedBox(height: 4),
                        Center(
                          child: Text(
                            '${provider.serie.time} EST. Time',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'montserratlight',
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'WORKOUTS',
                          style: themeData.headline3!.copyWith(fontSize: 22),
                        ),
                        Text(
                          'WHAT YOU SHOULD DO',
                          style: themeData.subtitle2!.copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (ctx, cons) => ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, ind) => SerieRowBox(
                              themeData: themeData,
                              cons: cons,
                              workout: provider.serie.workouts[ind],
                            ),
                            separatorBuilder: (ctx, ind) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Divider(
                                height: 22,
                                color: Colors.white.withOpacity(.3),
                              ),
                            ),
                            itemCount: provider.serie.workouts.length,
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
