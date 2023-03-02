import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Providers/list.dart';
import '../Widgets/add-video-navigator-button.dart';
import '../Widgets/video-filter-button.dart';
import '../Widgets/video-row-navigator.dart';

class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoListProvider>(
      create: (ctx) => VideoListProvider(),
      child: VideoListScreenTile(),
    );
  }
}

class VideoListScreenTile extends StatefulWidget {
  const VideoListScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _VideoListScreenTileState createState() => _VideoListScreenTileState();
}

class _VideoListScreenTileState extends State<VideoListScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Consumer<VideoListProvider>(
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
                        controller: provider.scrollController,
                        children: [
                          ChampyaHeader(),
                          SizedBox(height: 15),
                          // GlobalBackButton(title: 'HOME'),
                          SimpleHeader(
                            mainHeader: 'VIDEOES',
                            subHeader: 'what people share',
                          ),
                          SizedBox(height: 15),
                          AddVideoNavigator(themeData: themeData),
                          SizedBox(height: 10),
                          VideosFiltersNavigator(themeData: themeData),
                          SizedBox(height: 10),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, ind) => Container(
                              margin: EdgeInsets.only(top: 20),
                              child: VideoRowNavigator(themeData: themeData),
                            ),
                            separatorBuilder: (ctx, ind) =>
                                Divider(color: Colors.white),
                            itemCount: 3,
                          ),
                          SizedBox(height: 50),
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
