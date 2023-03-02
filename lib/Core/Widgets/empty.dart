import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String label;
  const EmptyWidget({
    Key? key,
    this.label = 'داده ای برای نمایش وجود ندارد.',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          label,
          textDirection: TextDirection.rtl,
        ),
      );
  }
}
