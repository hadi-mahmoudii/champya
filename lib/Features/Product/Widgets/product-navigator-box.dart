import 'package:share_plus/share_plus.dart';

import '../../../Core/Config/routes.dart';
import '../Models/product.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Core/Widgets/submit_button.dart';

class ProductNavigatorBox extends StatelessWidget {
  const ProductNavigatorBox({
    Key? key,
    required this.themeData,
    required this.cons,
    required this.product,
  }) : super(key: key);

  final TextTheme themeData;
  final BoxConstraints cons;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.productDetails, arguments: product),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: cons.maxWidth / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  width: cons.maxWidth * 28 / 10,
                  height: 100,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (ctx, obj, _) => Image.asset(
                    'assets/Images/program_placeholder.png',
                    width: cons.maxWidth * 28 / 10,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: themeData.headline3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.title,
                    style: themeData.subtitle2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  product.buyLink.contains('http')
                      ? Row(
                          children: [
                            Expanded(
                              child: SubmitButton(
                                func: () => launch(product.buyLink),
                                icon: Icons.shopping_cart_rounded,
                                title: 'BUY THIS ITEM',
                                fontSize: 9,
                              ),
                            ),
                            SizedBox(width: 5),
                            SubmitButton(
                              func: () {
                                Share.share(product.buyLink);
                              },
                              icon: Icons.share,
                              title: '',
                              fontSize: 9,
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
