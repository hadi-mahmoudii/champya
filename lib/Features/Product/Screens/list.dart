import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/main_screen.dart';
import '../Providers/list.dart';
import '../Widgets/product-navigator-box.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductListProvider>(
      create: (ctx) => ProductListProvider(),
      child: ProductListScreenTile(),
    );
  }
}

class ProductListScreenTile extends StatefulWidget {
  const ProductListScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _ProductListScreenTileState createState() => _ProductListScreenTileState();
}

class _ProductListScreenTileState extends State<ProductListScreenTile>
    with AutomaticKeepAliveClientMixin<ProductListScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ProductListProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<ProductListProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification) {
                if (provider.scrollController.position.pixels >
                        provider.scrollController.position.maxScrollExtent -
                            30 &&
                    !provider.isLoadingMore) {
                  provider.getDatas(context);
                }
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
                                mainHeader: 'OUR PRODUCTS',
                                subHeader: 'we care about your health',
                              ),
                              //TODO : filter must add here

                              // SizedBox(height: 10),
                              // ProductFilterButton(themeData: themeData),
                              SizedBox(height: 30),
                              LayoutBuilder(
                                builder: (ctx, cons) => ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx, ind) =>
                                      ProductNavigatorBox(
                                    themeData: themeData,
                                    cons: cons,
                                    product: provider.products[ind],
                                  ),
                                  separatorBuilder: (ctx, ind) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: SizedBox(height: 40),
                                  ),
                                  itemCount: provider.products.length,
                                ),
                              ),
                              SizedBox(height: 100)
                            ],
                          ),
                        ),
                  Positioned(
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
