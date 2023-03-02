import '../../../Core/Config/routes.dart';
import 'package:flutter/material.dart';

class AddCustomProgramButton extends StatelessWidget {
  const AddCustomProgramButton({
    Key? key,
    required this.themeData,
  }) : super(key: key);
  final TextTheme themeData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(Routes.addCustomProgram),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white54),
            bottom: BorderSide(color: Colors.white54),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 13,
            ),
            SizedBox(width: 10),
            Text(
              'ADD NEW ONE',
              style: themeData.overline!.copyWith(
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
