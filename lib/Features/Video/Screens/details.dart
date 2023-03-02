import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Providers/details.dart';
import '../Widgets/video-details-header-image.dart';
import '../Widgets/video-details-tabbar.dart';

class VideoDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoDetailsProvider>(
      create: (ctx) => VideoDetailsProvider(),
      child: VideoDetailsScreenTile(),
    );
  }
}

class VideoDetailsScreenTile extends StatefulWidget {
  const VideoDetailsScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _VideoDetailsScreenTileState createState() => _VideoDetailsScreenTileState();
}

class _VideoDetailsScreenTileState extends State<VideoDetailsScreenTile> {
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
    return Consumer<VideoDetailsProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          imagePath: 'assets/Images/image2.jpg',
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
                        GlobalBackButton(title: 'Videoes'),
                        SimpleHeader(
                          mainHeader: 'VIDEO DEtails',
                          subHeader: 'feel the power',
                        ),
                        SizedBox(height: 15),
                        VideoDetailsHeaderImage(),
                        SizedBox(height: 10),
                        Text(
                          'Title',
                          textAlign: TextAlign.left,
                          style: themeData.headline3!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                          textAlign: TextAlign.left,
                          style: themeData.button,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'AUTHOR :',
                          style:
                              themeData.subtitle2!.copyWith(letterSpacing: 3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person, size: 16, color: Colors.white),
                            SizedBox(width: 3),
                            Text(
                              'Writer',
                              textAlign: TextAlign.start,
                              style: themeData.headline3,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        VideoDetailsTabbar(
                          themeData: themeData,
                          provider: provider,
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
