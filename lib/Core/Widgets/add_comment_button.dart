import 'package:flutter/material.dart';

import 'filter.dart';
import 'input_box.dart';
import 'loading.dart';
import 'simple_header.dart';
import 'submit_button.dart';

class AddNewCommentButton extends StatefulWidget {
  const AddNewCommentButton({
    Key? key,
    required this.themeData,
    required this.contx,
    required this.function,
  }) : super(key: key);
  final TextTheme themeData;
  final BuildContext contx;
  final Function function;

  @override
  State<AddNewCommentButton> createState() => _AddNewCommentButtonState();
}

class _AddNewCommentButtonState extends State<AddNewCommentButton> {
  final TextEditingController commentCtrl = TextEditingController();
  bool isSending = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(widget.contx).size.height / 2),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(widget.contx).viewInsets.bottom),
          child: FilterWidget(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: isSending
                    ? Center(
                        child: LoadingWidget(),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SimpleHeader(
                            mainHeader: 'ADD COMMENT',
                            subHeader: '',
                          ),
                          SizedBox(height: 20),
                          InputBox(
                            label: 'Comment',
                            controller: commentCtrl,
                            minLines: 4,
                            maxLines: 5,
                          ),
                          SizedBox(height: 20),
                          SubmitButton(
                            func: () async {
                              setState(() {
                                isSending = true;
                              });
                              widget.function(commentCtrl);
                            },
                            icon: Icons.add,
                            title: 'Send',
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
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
              'ADD NEW COMMENT',
              style: widget.themeData.overline!.copyWith(
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
