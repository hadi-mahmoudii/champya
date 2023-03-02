import 'package:champya/Features/Program/Widgets/category-workout-navigator.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/simple_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../Providers/my-favorites.dart';

class MyFavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyFavoritesProvider>(
      create: (ctx) => MyFavoritesProvider(),
      child: MyFavoritesScreenTile(),
    );
  }
}

class MyFavoritesScreenTile extends StatefulWidget {
  const MyFavoritesScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _MyFavoritesScreenTileState createState() => _MyFavoritesScreenTileState();
}

class _MyFavoritesScreenTileState extends State<MyFavoritesScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MyFavoritesProvider>(context, listen: false)
          .getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<MyFavoritesProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : RefreshIndicator(
                  onRefresh: () async => print('object'),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        ChampyaHeader(),
                        SizedBox(height: 15),
                        GlobalBackButton(title: 'DASHBOARD'),
                        SimpleHeader(
                          mainHeader: 'FAVORITES',
                          subHeader: '',
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: LayoutBuilder(
                            builder: (ctx, cons) => ListView.separated(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, ind) =>
                                  CategoryWorkoutNavigator(
                                themeData: themeData,
                                cons: cons,
                                workout: provider.workouts[ind],
                                letAddWorkout: false,
                              ),
                              separatorBuilder: (ctx, ind) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Divider(
                                    color: Colors.grey.withOpacity(.6),
                                  ),
                                ),
                              ),
                              itemCount: provider.workouts.length,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
