import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/main_screen.dart';
import '../Providers/categories.dart';
import '../Widgets/category-row-navigator.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool navigateFromProgramDetails = false;
    try {
      navigateFromProgramDetails =
          ModalRoute.of(context)!.settings.arguments as bool;
    } catch (e) {}
    return ChangeNotifierProvider<CategoriesProvider>(
      create: (ctx) => CategoriesProvider(navigateFromProgramDetails),
      child: TestScreenTile(),
    );
  }
}

class TestScreenTile extends StatefulWidget {
  const TestScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _TestScreenTileState createState() => _TestScreenTileState();
}

class _TestScreenTileState extends State<TestScreenTile>
    with AutomaticKeepAliveClientMixin<TestScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<CategoriesProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Consumer<CategoriesProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification) {
                if (provider.scrollController.position.pixels >
                        provider.scrollController.position.maxScrollExtent -
                            30 &&
                    provider.isLoadingMore) {}
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async =>
                  provider.getDatas(context, resetPage: true),
              child: Stack(
                children: [
                  provider.isLoading
                      ? Center(
                          child: LoadingWidget(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView(
                            controller: provider.scrollController,
                            children: [
                              ChampyaHeader(),
                              SizedBox(height: 15),
                              // GlobalBackButton(title: 'HOME'),
                              SimpleHeader(
                                mainHeader: 'CATEGORIES',
                                subHeader: 'we care about your health',
                              ),
                              SizedBox(height: 20),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, ind) => Container(
                                  child: CategoryRowNavigator(
                                    themeData: themeData,
                                    category: provider.categories[ind],
                                    icon: Icons.import_contacts_rounded,
                                  ),
                                ),
                                separatorBuilder: (ctx, ind) =>
                                    SizedBox(height: 5),
                                itemCount: provider.categories.length,
                              ),
                              SizedBox(height: 100),
                            ],
                          ),
                        ),
                  provider.navigateFromProgramDetails
                      ? Container()
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GlobalBottomNavigationBar(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
