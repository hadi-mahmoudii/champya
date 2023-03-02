import 'package:champya/Features/Program/Models/custom-program.dart';
import 'package:champya/Features/Program/Providers/edit_custom.dart';
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

class EditCustomProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditCustomProvider>(
      create: (ctx) => EditCustomProvider(
        ModalRoute.of(context)!.settings.arguments as CustomProgramModel,
      ),
      child: EditCustomProgramScreenTile(),
    );
  }
}

class EditCustomProgramScreenTile extends StatefulWidget {
  const EditCustomProgramScreenTile({
    Key? key,
  }) : super(key: key);

  @override
  _EditCustomProgramScreenTileState createState() =>
      _EditCustomProgramScreenTileState();
}

class _EditCustomProgramScreenTileState
    extends State<EditCustomProgramScreenTile> {
  @override
  initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<EditCustomProvider>(context, listen: false)
          .getCategories(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditCustomProvider>(
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
                          func: () => provider.editProgram(context),
                          icon: null,
                          title: 'EDIT THE PROGRAM',
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
