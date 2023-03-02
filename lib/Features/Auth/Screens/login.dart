import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Providers/login.dart';
import '../Widgets/forget_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (ctx) => LoginProvider(),
      child: LoginScreenTile(),
    );
  }
}

class LoginScreenTile extends StatefulWidget {
  const LoginScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenTileState createState() => _LoginScreenTileState();
}

class _LoginScreenTileState extends State<LoginScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
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
                                  '''LET’S
ROCK
AND
ROLL''',
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
                            // GlobalBackButton(
                            //   title: 'HOME',
                            // ),
                            SimpleHeader(
                              mainHeader: 'sign in',
                              subHeader: 'PLEASE PROVIDE US YOUR LOGIN DETAILS',
                            ),
                            SizedBox(height: 20),
                            InputBox(
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
                            SizedBox(height: 20),
                            InputBox(
                              label: 'password',
                              controller: provider.passwordCtrl,
                              hideContent: true,
                              minLines: 1,
                              maxLines: 1,
                              validator: (String value) {
                                if (value.isEmpty) return 'Required';
                                if (value.length < 8)
                                  return 'Atleast 8 characters';
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            LayoutBuilder(
                              builder: (ctx, cons) => Row(
                                children: [
                                  Expanded(
                                    child: SubmitButton(
                                      func: () => provider.login(context),
                                      icon: null,
                                      title: 'Do Sign in',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SubmitButton(
                                    func: () => Navigator.of(context)
                                        .pushNamed(Routes.register),
                                    icon: null,
                                    title: 'Sign up',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            ForgetNavigatorButton(),
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
