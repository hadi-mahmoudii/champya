import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../Program/Models/program.dart';
import '../Providers/mentor-info.dart';

class MentorInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MentorInfoProvider>(
      create: (ctx) => MentorInfoProvider(
        ModalRoute.of(context)!.settings.arguments as TrainerModel,
      ),
      child: MentorInfoScreenTile(),
    );
  }
}

class MentorInfoScreenTile extends StatefulWidget {
  const MentorInfoScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _MentorInfoScreenTileState createState() => _MentorInfoScreenTileState();
}

class _MentorInfoScreenTileState extends State<MentorInfoScreenTile> {
  // @override
  // initState() {
  //   super.initState();
  //   Future.microtask(
  //     () => Provider.of<MentorInfoProvider>(context, listen: false)
  //         .getDatas(context),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<MentorInfoProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RefreshIndicator(
                    onRefresh: () async => print('object'),
                    child: ListView(
                      children: [
                        ChampyaHeader(),
                        SizedBox(height: 15),
                        GlobalBackButton(
                          title: 'COURSE DETAILS',
                        ),
                        SimpleHeader(
                          mainHeader: 'MENTOR PROFILE',
                          subHeader: 'MEET OUR EXPERT',
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                provider.trainer.image,
                                width:
                                    MediaQuery.of(context).size.width * 2 / 5,
                                height:
                                    MediaQuery.of(context).size.width * 2 / 5,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (ctx, obj, _) => Center(
                                  child: Image.asset(
                                    'assets/Images/user_placeholder.png',
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        5,
                                    height: MediaQuery.of(context).size.width *
                                        2 /
                                        5,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.trainer.name,
                                  style: themeData.headline3,
                                ),
                                Text(
                                  provider.trainer.name,
                                  style: themeData.button,
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AGE:',
                                        style: themeData.button!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(provider.trainer.age,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontFamily: 'montserratlight',
                                          )),
                                      SizedBox(height: 5),
                                      Text(
                                        'NATIONALITY: ',
                                        style: themeData.button!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(provider.trainer.nationality,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontFamily: 'montserratlight',
                                          )),
                                      SizedBox(height: 5),
                                      Text(
                                        'HEIGHT:',
                                        style: themeData.button!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(provider.trainer.height,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontFamily: 'montserratlight',
                                          )),
                                      SizedBox(height: 5),
                                      Text(
                                        'WEIGHT:',
                                        style: themeData.button!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(provider.trainer.weight,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontFamily: 'montserratlight',
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'ABOUT ME',
                          textAlign: TextAlign.left,
                          style: themeData.headline3!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          provider.trainer.decription,
                          textAlign: TextAlign.left,
                          style: themeData.button,
                        ),
                        // SizedBox(height: 20),
                        // MentorHeaderVideo(),
                        // Divider(height: 50, color: Colors.grey),
                        // SimpleHeader(
                        //   mainHeader: 'my programs',
                        //   subHeader: 'here is my hard efforts',
                        // ),
                        // SizedBox(height: 20),
                        // TODO : Mentor programs list

                        // LayoutBuilder(
                        //   builder: (ctx, cons) => ConstrainedBox(
                        //     constraints: BoxConstraints(
                        //       maxWidth: cons.maxWidth * 6 / 10,
                        //       maxHeight: 250,
                        //     ),
                        //     child: ListView.separated(
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //       itemBuilder: (ctx, ind) => VideoItemNavigator(
                        //         cons: cons,
                        //         index: ind + 1,
                        //       ),
                        //       separatorBuilder: (ctx, ind) =>
                        //           SizedBox(width: 20),
                        //       itemCount: 3,
                        //     ),
                        //   ),
                        // ),
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
