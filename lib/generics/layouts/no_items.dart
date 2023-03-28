import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class NoItems extends StatelessWidget {
  const NoItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No items ... :( ",
        style: Styles.kHeadlineTextStyle,
      ),
    );
  }
}
