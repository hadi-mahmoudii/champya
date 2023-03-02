import '../../../Core/Config/app_session.dart';
import '../../../Core/Widgets/date_picker.dart';
import '../../../Core/Widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_bottom_header.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Providers/info.dart';
import '../Widgets/info-contact-navigator.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InfoProvider>(
      create: (ctx) => InfoProvider(),
      child: InfoScreenTile(),
    );
  }
}

class InfoScreenTile extends StatefulWidget {
  const InfoScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _InfoScreenTileState createState() => _InfoScreenTileState();
}

class _InfoScreenTileState extends State<InfoScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<InfoProvider>(context, listen: false).getDatas(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Consumer<InfoProvider>(
      builder: (ctx, provider, _) => Scaffold(
        body: FilterWidget(
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            ChampyaHeader(),
                            SizedBox(height: 15),
                            GlobalBackButton(
                              title: 'DASHBOARD',
                            ),
                            SimpleHeader(
                              mainHeader: 'PERSONAL INFO',
                              subHeader: '',
                            ),
                            SizedBox(height: 20),
                            InputBox(
                              label: 'Your email address',
                              controller: provider.emailCtrl,
                              textType: TextInputType.emailAddress,
                              readOnly: true,
                            ),
                            SizedBox(height: 20),
                            InputBox(
                              label: 'Your first name',
                              controller: provider.fNameCtrl,
                            ),
                            SizedBox(height: 20),
                            InputBox(
                              label: 'Your last name',
                              controller: provider.lNameCtrl,
                            ),
                            SizedBox(height: 20),
                            InputBox(
                              label: 'Your cell number',
                              controller: provider.cellCtrl,
                              textType: TextInputType.phone,
                            ),
                            // TODO : Country field needed

                            // SizedBox(height: 20),
                            // InputBox(
                            //   label: 'Your country',
                            //   controller: provider.countryCtrl,
                            // ),
                            SizedBox(height: 20),
                            InputBox(
                              label: 'address',
                              controller: provider.addressCtrl,
                            ),
                            SizedBox(height: 20),
                            DatePicker(
                              color: mainFontColor,
                              icon: Icons.calendar_today_outlined,
                              label: 'Birthday',
                              controller: provider.birthdayCtrl,
                              dateLabelCtrl: provider.birthdayLabelCtrl,
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                            ),
                            // InputBox(
                            //   label: 'birthday',
                            //   controller: provider.birthdayCtrl,
                            // ),
                            SizedBox(height: 40),
                            SubmitButton(
                              func: () => provider.updateDatas(context),
                              icon: null,
                              title: 'SAVE THE INFO',
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                      InfoContactNavigators(themeData: themeData),
                      ChampyaBottomHeader(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
