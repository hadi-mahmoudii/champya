import 'package:flutter/material.dart';

import '../../../Core/Widgets/simple_header.dart';
import '../Models/section.dart';
import 'program_home_navigator.dart';

class SectionBox extends StatelessWidget {
  const SectionBox({
    Key? key,
    required this.section,
  }) : super(key: key);
  final HomeSectionModel section;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        section.type != 'sport_category'
            ? SimpleHeader(
                mainHeader: section.title,
                subHeader: section.subTitle,
              )
            : Container(),
        SizedBox(height: 20),
        LayoutBuilder(
          builder: (ctx, cons) => ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: cons.maxWidth * 6 / 10,
              maxHeight: 250,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, ind) {
                switch (section.type) {
                  case 'course':
                    return ProgramHomeNavigator(
                      cons: cons,
                      index: ind + 1,
                      program: section.sections[ind],
                    );
                  // case 'sport_category':
                  //   return HomeCategoryNavigatorButton(
                  //     cons: cons,
                  //     category: section.sections[ind],
                  //   );
                  case 'product':
                    return Container();
                  case 'workout':
                    return Container();
                  default:
                    return ProgramHomeNavigator(
                      cons: cons,
                      index: ind + 1,
                      program: section.sections[ind],
                    );
                }
              },
              separatorBuilder: (ctx, ind) => SizedBox(width: 20),
              itemCount: section.sections.length,
            ),
          ),
        ),
      ],
    );
  }
}
