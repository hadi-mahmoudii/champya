import 'package:flutter/material.dart';

import '../../../Core/Widgets/add_comment_button.dart';
import '../../../Core/Widgets/comment_box.dart';
import '../Providers/details.dart';
import 'program-navigator-box.dart';

class ProductTabBar extends StatefulWidget {
  const ProductTabBar({
    Key? key,
    required this.themeData,
    required this.provider,
    required this.contx,

  }) : super(key: key);

  final TextTheme themeData;
  final ProductDetailsProvider provider;
  final BuildContext contx;
  @override
  State<ProductTabBar> createState() => _ProductTabBarState();
}

class _ProductTabBarState extends State<ProductTabBar>
    with TickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  @override
  initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  tabCtrl.animateTo(0);
                  setState(() {
                    currentTabIndex = 0;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: currentTabIndex == 0
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    'VIDEOES',
                    style: widget.themeData.headline6!.copyWith(
                      color: currentTabIndex == 0 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 25),
              InkWell(
                onTap: () {
                  tabCtrl.animateTo(1);
                  setState(() {
                    currentTabIndex = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: currentTabIndex == 1
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    'COMMENTS',
                    style: widget.themeData.headline6!.copyWith(
                      color: currentTabIndex == 1 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: DefaultTabController(
            length: 2,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabCtrl,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LayoutBuilder(
                    builder: (ctx, cons) => ListView.separated(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, ind) => ProductVideoNavigatorBox(
                        themeData: widget.themeData,
                        cons: cons,
                      ),
                      separatorBuilder: (ctx, ind) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Divider(
                          height: 22,
                          color: Colors.white.withOpacity(.3),
                        ),
                      ),
                      itemCount: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView(
                    children: [
                      AddNewCommentButton(
                        themeData: widget.themeData,
                        contx: widget.contx,
                        function: (commentCtrl) =>
                            widget.provider.addComment(context, commentCtrl),
                      ),
                      // AddNewCommentButton(
                      //   themeData: widget.themeData,
                      //   contx: widget.contx,
                      //   id: widget.provider.product.id,
                      //   type: 'product',
                      // ),
                      SizedBox(height: 10),
                      LayoutBuilder(
                        builder: (ctx, cons) => ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, ind) => CommentBox(
                            cons: cons,
                            themeData: widget.themeData,
                            comment: widget.provider.comments[ind],
                          ),
                          separatorBuilder: (ctx, ind) => SizedBox(
                            height: 20,
                          ),
                          itemCount: widget.provider.comments.length,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
