import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/back_button.dart';
import '../../../Core/Widgets/champya_header.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/static_bottom_selector.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Providers/add_custom.dart';

class AddCustomProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCustomProvider>(
      create: (ctx) => AddCustomProvider(),
      child: AddCustomProgramScreenTile(),
    );
  }
}

class AddCustomProgramScreenTile extends StatefulWidget {
  const AddCustomProgramScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _AddCustomProgramScreenTileState createState() =>
      _AddCustomProgramScreenTileState();
}

class _AddCustomProgramScreenTileState
    extends State<AddCustomProgramScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AddCustomProvider>(context, listen: false)
          .getCategories(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCustomProvider>(
      builder: (ctx, provider, _) => Scaffold(
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
                        SizedBox(height: 15),
                        GlobalBackButton(title: 'MY PROGRAMS'),
                        SimpleHeader(
                          mainHeader: 'Add a program',
                          subHeader: 'lets begin',
                        ),
                        SizedBox(height: 15),
                        StaticBottomSelector(
                          label: 'CATEGORY',
                          controller: provider.categoryCtrl,
                          datas: provider.categories,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        InputBox(
                          label: 'PROGRAM NAME',
                          controller: provider.titleCtrl,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        InputBox(
                          label: 'How many days',
                          controller: provider.periodCtrl,
                          textType: TextInputType.number,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        InputBox(
                          label: 'PROGRAM DESCRIPTION',
                          controller: provider.descriptionCtrl,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            return null;
                          },
                          minLines: 3,
                          maxLines: 6,
                        ),
                        SizedBox(height: 25),
                        SubmitButton(
                          func: () => provider.addProgram(context),
                          icon: null,
                          title: 'ADD THE PROGRAM',
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
