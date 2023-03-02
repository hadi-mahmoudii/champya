import 'package:champya/Core/Widgets/submit_button.dart';
import 'package:flutter/material.dart';

class EmptyWidget2 extends StatelessWidget {
  final String header;
  final String description;
  final String buttonText;
  final Function function;
  const EmptyWidget2({
    Key? key,
    required this.header,
    required this.description,
    required this.buttonText,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              color: Color(0XFFFFD600),
              fontSize: 20,
              fontFamily: 'teamamerica'
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'montserratlight',
              fontSize: 15,
            ),
          ),
          SizedBox(height: 7),
          SubmitButton(
            func: function,
            icon: null,
            title: buttonText,
            buttonWidth: MediaQuery.of(context).size.width / 2,
          ),
        ],
      ),
    );
  }
}
