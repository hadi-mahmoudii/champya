import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../Program/Widgets/program-navigator-box.dart';
import '../Providers/favorites.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesProvider>(
      create: (ctx) => FavoritesProvider(),
      child: FavoritesScreenTile(),
    );
  }
}

class FavoritesScreenTile extends StatefulWidget {
  const FavoritesScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _FavoritesScreenTileState createState() => _FavoritesScreenTileState();
}

class _FavoritesScreenTileState extends State<FavoritesScreenTile> {
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
    return Consumer<FavoritesProvider>(
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
                        children: [
                          ChampyaHeader(),
                          SizedBox(height: 15),
                          GlobalBackButton(
                            title: 'DASHBOARD',
                          ),
                          SimpleHeader(
                            mainHeader: 'FAVORITES',
                            subHeader: '',
                          ),
                          SizedBox(height: 20),
                          LayoutBuilder(
                            builder: (ctx, cons) => ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, ind) => ProgramNavigatorBox(
                                themeData: themeData,
                                cons: cons,
                              ),
                              separatorBuilder: (ctx, ind) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Divider(
                                  height: 22,
                                  color: Colors.white.withOpacity(.3),
                                ),
                              ),
                              itemCount: 2,
                            ),
                          ),
                          SizedBox(height: 50)
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
