import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Models/category-overview.dart';
import 'package:flutter/material.dart';

class CategoryRowNavigator extends StatelessWidget {
  const CategoryRowNavigator({
    Key? key,
    required this.themeData,
    required this.icon,
    required this.category,
  }) : super(key: key);

  final TextTheme themeData;
  final IconData icon;
  final CategoryOverviewModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.categoryDetails, arguments: category),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(.7),
            ),
            bottom: BorderSide(
              color: Colors.grey.withOpacity(.7),
            ),
          ),
        ),
        child: Row(
          children: [
            Image.network(
              category.image,
              width: 40,
              height: 40,
              fit: BoxFit.fitHeight,
              errorBuilder: (ctx, obj, _) => Image.asset(
                'assets/Images/program_placeholder.png',
                width: 40,
                height: 40,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: themeData.headline3,
                ),
                Text(
                  category.title,
                  style: themeData.button,
                ),
              ],
            ),
            Spacer(),
            Icon(
              FlutterIcons.right_chevron,
              size: 24,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
