import 'package:champya/Core/Widgets/flutter_icons.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../Config/urls.dart';
import '../Models/server_request.dart';
import 'error_result.dart';
import 'loading.dart';

class BookmarkBox extends StatefulWidget {
  const BookmarkBox({
    Key? key,
    required this.currentState,
    required this.type,
    required this.id,
  }) : super(key: key);

  final bool currentState;
  final String type;
  final String id;

  @override
  State<BookmarkBox> createState() => _BookmarkBoxState();
}

class _BookmarkBoxState extends State<BookmarkBox> {
  late bool hasBookmark;
  bool isLoading = false;
  @override
  void initState() {
    hasBookmark = widget.currentState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : InkWell(
            onTap: () async {
              setState(() {
                hasBookmark = !hasBookmark;
                // isLoading = true;
              });
              if (hasBookmark) {
                final Either<ErrorResult, dynamic> result =
                    await ServerRequest().sendData(
                  Urls.addBookmark,
                  datas: {
                    'bookmarkable_type': widget.type,
                    'bookmarkable_id': widget.id,
                    'toggle': true,
                  },
                );
                result.fold(
                  (error) async {
                    await ErrorResult.showDlg(error.type!, context);
                  },
                  (result) async {
                    print(result);
                  },
                );
              } else {
                final Either<ErrorResult, dynamic> result =
                    await ServerRequest().sendData(
                  Urls.addBookmark,
                  datas: {
                    'bookmarkable_type': widget.type,
                    'bookmarkable_id': widget.id,
                    'toggle': false,
                  },
                );
                result.fold(
                  (error) async {
                    await ErrorResult.showDlg(error.type!, context);
                  },
                  (result) async {
                    print(result);
                  },
                );
              }
              // setState(() {
              //   isLoading = false;
              // });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
              child: Icon(
                hasBookmark
                    ? FlutterIcons.bookmark
                    : FlutterIcons.bookmark_empty,
                color: Colors.white,
                size: 20,
              ),
            ),
          );
  }
}
