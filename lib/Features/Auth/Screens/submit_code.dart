import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Providers/submit_code.dart';

class SubmitCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubmitCodeProvider>(
      create: (ctx) => SubmitCodeProvider(
          ModalRoute.of(context)!.settings.arguments as String),
      child: SubmitCodeScreenTile(),
    );
  }
}

class SubmitCodeScreenTile extends StatefulWidget {
  const SubmitCodeScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _SubmitCodeScreenTileState createState() => _SubmitCodeScreenTileState();
}

class _SubmitCodeScreenTileState extends State<SubmitCodeScreenTile> {
  @override
  initState() {
    super.initState();
    // Future.microtask(
    Provider.of<SubmitCodeProvider>(context, listen: false).startTimer();
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitCodeProvider>(
      builder: (ctx, provider, _) => SafeArea(
        child: Scaffold(
          body: FilterWidget(
            child: provider.isLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: provider.formKey,
                      child: ListView(
                        children: [
                          ChampyaHeader(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Center(
                              child: Text(
                                '''JUST A
FINAL
CHECK''',
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
                            mainHeader: 'code verification',
                            subHeader: 'ENTER THE CODE',
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Spacer(),
                              SizedBox(
                                width: 150,
                                child: InputBox(
                                  // icon: null,
                                  label: 'Code',
                                  controller: provider.codeCtrl,
                                  validator: (String value) {
                                    if (value.isEmpty) return 'Required';
                                    return null;
                                  },
                                  maxLength: 9,
                                  textType: TextInputType.number,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 40),
                          LayoutBuilder(
                            builder: (ctx, cons) => Row(
                              children: [
                                Expanded(
                                  child: SubmitButton(
                                    func: () => provider.submitCode(context),
                                    icon: null,
                                    title: 'VERIFY THE CODE',
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
                          SizedBox(height: 20),
                          provider.timerValue != 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Didnt get the code? Resend it after',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      color: Colors.white,
                                      child: Text(
                                        '${provider.timerValue} s',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SubmitButton(
                                  title: 'Resend code',
                                  func: () => provider.resendCode(context),
                                  icon: null,
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
