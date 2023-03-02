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
import '../Providers/change-pass.dart';
import '../Widgets/info-contact-navigator.dart';

class ChangePassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePassProvider>(
      create: (ctx) => ChangePassProvider(),
      child: ChangePassScreenTile(),
    );
  }
}

class ChangePassScreenTile extends StatefulWidget {
  const ChangePassScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePassScreenTileState createState() => _ChangePassScreenTileState();
}

class _ChangePassScreenTileState extends State<ChangePassScreenTile> {
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
    return Consumer<ChangePassProvider>(
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
                        child: Form(
                          key: provider.formKey,
                          child: ListView(
                            children: [
                              ChampyaHeader(),
                              SizedBox(height: 15),
                              GlobalBackButton(
                                title: 'DASHBOARD',
                              ),
                              SimpleHeader(
                                mainHeader: 'change password',
                                subHeader: '',
                              ),
                              SizedBox(height: 20),
                              InputBox(
                                // icon: null,
                                label: 'Your CURRENT Pass',
                                controller: provider.curPass,
                                hideContent: true,
                                maxLines: 1,
                                validator: (String value) {
                                  if (value.isEmpty) return 'Required';
                                  if (value.length < 8)
                                    return 'Atleast 8 characters';
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              InputBox(
                                // icon: null,
                                label: 'new password',
                                controller: provider.newPass,
                                hideContent: true,
                                maxLines: 1,
                                validator: (String value) {
                                  if (value.isEmpty) return 'Required';
                                  if (value.length < 8)
                                    return 'Atleast 8 characters';
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              InputBox(
                                // icon: null,
                                label: 'retype new password',
                                controller: provider.reNewPass,
                                hideContent: true,
                                maxLines: 1,
                                validator: (String value) {
                                  if (value.isEmpty) return 'Required';
                                  if (value.length < 8)
                                    return 'Atleast 8 characters';
                                  if (provider.newPass.text !=
                                      provider.reNewPass.text)
                                    return 'Passwords must be samed';
                                  return null;
                                },
                              ),
                              SizedBox(height: 40),
                              SubmitButton(
                                func: () => provider.changePassword(context),
                                icon: null,
                                title: 'CHANGE THE PASSWORD',
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
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
