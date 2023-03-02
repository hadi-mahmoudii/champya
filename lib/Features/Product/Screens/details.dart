import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Models/product.dart';
import '../Providers/details.dart';
import '../Widgets/product-header-images.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsProvider>(
      create: (ctx) => ProductDetailsProvider(
          product: ModalRoute.of(context)!.settings.arguments! as ProductModel),
      child: ProductDetailsScreenTile(),
    );
  }
}

class ProductDetailsScreenTile extends StatefulWidget {
  const ProductDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailsScreenTileState createState() =>
      _ProductDetailsScreenTileState();
}

class _ProductDetailsScreenTileState extends State<ProductDetailsScreenTile> {
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
    return Consumer<ProductDetailsProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
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
                      GlobalBackButton(
                        title: 'PRODUCTS',
                      ),
                      SimpleHeader(
                        mainHeader: 'PRODUCT DETAILS',
                        subHeader: 'we care about your health',
                      ),
                      SizedBox(height: 10),
                      ProductHeaderImagesBox(
                        thumbnail: provider.product.image,
                        images: provider.product.images,
                      ),
                      SizedBox(height: 20),
                      Text(
                        provider.product.name,
                        textAlign: TextAlign.left,
                        style: themeData.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        provider.product.description,
                        textAlign: TextAlign.left,
                        style: themeData.button,
                      ),
                      SizedBox(height: 10),
                      provider.product.buyLink.contains('http')
                          ? Row(
                              children: [
                                Expanded(
                                  child: SubmitButton(
                                    func: () {
                                      print(provider.product.buyLink);
                                      launch(provider.product.buyLink);
                                    },
                                    icon: Icons.shopping_cart_rounded,
                                    title: 'BUY THIS ITEM',
                                    fontSize: 9,
                                  ),
                                ),
                                SizedBox(width: 5),
                                SubmitButton(
                                  func: () {
                                    Share.share(provider.product.buyLink);
                                  },
                                  icon: Icons.share,
                                  title: '',
                                  fontSize: 9,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 60),
                      // ProductTabBar(
                      //   themeData: themeData,
                      //   provider: provider,
                      //   contx: context,
                      // ),
                      // SizedBox(height: 10),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
