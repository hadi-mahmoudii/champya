import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../Providers/our-programs.dart';

class OurProgramsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OurProgramsProvider>(
      create: (ctx) => OurProgramsProvider(),
      child: OurProgramsScreenTile(),
    );
  }
}

class OurProgramsScreenTile extends StatefulWidget {
  const OurProgramsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _OurProgramsScreenTileState createState() => _OurProgramsScreenTileState();
}

class _OurProgramsScreenTileState extends State<OurProgramsScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OurProgramsProvider>(
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
                    child: ListView(
                      children: [
                        ChampyaHeader(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
