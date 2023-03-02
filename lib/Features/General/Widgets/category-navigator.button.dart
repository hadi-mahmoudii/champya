import 'package:champya/Core/Config/routes.dart';
import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';
import '../../Program/Models/category-overview.dart';

class HomeCategoryNavigatorButton extends StatelessWidget {
  final BoxConstraints cons;
  final CategoryOverviewModel category;
  const HomeCategoryNavigatorButton({
    Key? key,
    required this.cons,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: (cons.maxWidth - 40) / 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.categoryDetails, arguments: category);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(
                FlutterIcons.chart_bar,
                color: Colors.white,
                size: 40,
              ),
              Text(
                category.title.toUpperCase(),
                style: Theme.of(context).textTheme.button,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
