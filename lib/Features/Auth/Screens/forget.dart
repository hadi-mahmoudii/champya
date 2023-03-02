import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Providers/forget.dart';

class ForgetPassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetPassProvider>(
      create: (ctx) => ForgetPassProvider(),
      child: ForgetPassScreenTile(),
    );
  }
}

class ForgetPassScreenTile extends StatefulWidget {
  const ForgetPassScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _ForgetPassScreenTileState createState() => _ForgetPassScreenTileState();
}

class _ForgetPassScreenTileState extends State<ForgetPassScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPassProvider>(
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
                      child: Form(
                        key: provider.formKey,
                        child: ListView(
                          controller: provider.scrollController,
                          children: [
                            ChampyaHeader(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: Text(
                                  '''WE’RE
HERE
TO
HELP''',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0XFFFFD600),
                                    fontSize: 60,
                                    // fontWeight: FontWeight.bold,
                                    height: .8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            GlobalBackButton(title: 'BACK'),
                            SimpleHeader(
                              mainHeader: 'forget password',
                              subHeader: 'PLEASE PROVIDE US YOUR LOGIN DETAILS',
                            ),
                            SizedBox(height: 20),
                            InputBox(
                              // icon: null,
                              label: 'Your Email ADDRESS',
                              controller: provider.emailCtrl,
                              validator: (String value) {
                                if (value.isEmpty) return 'Required';
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value);
                                if (!emailValid) {
                                  return 'Enter correct email!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            LayoutBuilder(
                              builder: (ctx, cons) => Row(
                                children: [
                                  Expanded(
                                    child: SubmitButton(
                                      func: () =>
                                          provider.forgetPassRequest(context),
                                      icon: null,
                                      title: 'send the code',
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  // SubmitButton(
                                  //   func: () {},
                                  //   icon: null,
                                  //   title: 'Sign in',
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
