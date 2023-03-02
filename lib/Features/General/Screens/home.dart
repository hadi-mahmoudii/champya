import 'package:champya/Core/Widgets/flutter_icons.dart';
import 'package:champya/Core/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Providers/home.dart';
import '../Widgets/category-navigator.button.dart';
import '../Widgets/section_box.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (ctx) => HomeProvider(),
      child: HomeScreenTile(),
    );
  }
}

class HomeScreenTile extends StatefulWidget {
  const HomeScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenTileState createState() => _HomeScreenTileState();
}

class _HomeScreenTileState extends State<HomeScreenTile>
    with AutomaticKeepAliveClientMixin<HomeScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<HomeProvider>(context, listen: false).fetchDatas(),
    );
  }

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: RefreshIndicator(
            onRefresh: () async => provider.fetchDatas(resetPage: true),
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
                            SizedBox(height: 20),
                            SimpleHeader(
                              mainHeader: 'Lets Get to work',
                              subHeader: 'we offer you a great shape',
                            ),
                            SizedBox(height: 20),
                            HomeHeaderImagesBox(),
                            SizedBox(height: 35),
                            LayoutBuilder(
                              builder: (ctx, cons) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (var i = 0;
                                      i < provider.categories.length;
                                      i++)
                                    HomeCategoryNavigatorButton(
                                      cons: cons,
                                      category: provider.categories[i],
                                    )
                                ],
                              ),
                            ),
                            SizedBox(height: 50),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, ind) =>
                                  provider.sections[ind].type ==
                                          'sport_category'
                                      ? LayoutBuilder(
                                          builder: (ctx, cons) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (var i = 0;
                                                  i <
                                                      provider.sections[ind]
                                                          .sections.length;
                                                  i++)
                                                HomeCategoryNavigatorButton(
                                                  cons: cons,
                                                  category: provider
                                                      .sections[ind]
                                                      .sections[i],
                                                )
                                            ],
                                          ),
                                        )
                                      : SectionBox(
                                          section: provider.sections[ind],
                                        ),
                              separatorBuilder: (ctx, ind) => Divider(
                                color: Colors.white,
                                height: 100,
                              ),
                              itemCount: provider.sections.length,
                            ),
                            SizedBox(height: 100),
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
    );
  }
}

class HomeHeaderImagesBox extends StatefulWidget {
  const HomeHeaderImagesBox({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeaderImagesBox> createState() => _HomeHeaderImagesBoxState();
}

class _HomeHeaderImagesBoxState extends State<HomeHeaderImagesBox> {
  int _current = 0;
  final ScrollController _controller = ScrollController();
  final List<String> images = [
    'assets/Images/1.jpg',
    'assets/Images/2.jpg',
    'assets/Images/3.jpg',
    'assets/Images/4.jpg',
    'assets/Images/5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: 200,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemBuilder: (ctx, ind) => ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                images[_current],
                width: MediaQuery.of(context).size.width - 40,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            separatorBuilder: (ctx, ind) => SizedBox(width: 0),
            itemCount: images.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                if (_current > 0) {
                  _controller.jumpTo(
                    _controller.position.pixels -
                        MediaQuery.of(context).size.width +
                        40,
                    // duration: const Duration(milliseconds: 50),
                    // curve: Curves.linear,
                  );
                  setState(() {
                    _current--;
                  });
                }
              },
              icon: const Icon(
                FlutterIcons.left_chevron,
                size: 20,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return GestureDetector(
                  // onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _current == entry.key ? 30.0 : 10.0,
                    height: 2.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: _current == entry.key ? Colors.white : Colors.grey,
                    ),
                    child: Text(' '),
                  ),
                );
              }).toList(),
            ),
            IconButton(
              onPressed: () async {
                if (_current < images.length - 1) {
                  _controller.jumpTo(
                    _controller.position.pixels +
                        MediaQuery.of(context).size.width -
                        40,
                  );
                  setState(() {
                    _current++;
                  });
                }
              },
              icon: const Icon(
                FlutterIcons.right_chevron,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // CarouselSlider.builder(
        //   itemCount: 5,
        //   itemBuilder: (ctx, ind, _) => InkWell(
        //     onTap: () {},
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(30),
        //       child: Image.asset(
        //         images[_current],
        //         width: MediaQuery.of(context).size.width - 40,
        //         height: 200,
        //         fit: BoxFit.fitWidth,
        //       ),
        //     ),
        //   ),
        //   options: CarouselOptions(
        //     onPageChanged: (index, reason) {
        //       setState(() {
        //         _current = index;
        //       });
        //     },
        //     viewportFraction: 1.0,
        //     enlargeCenterPage: false,
        //   ),
        // ),
        // SizedBox(height: 10),
      ],
    );
  }
}
