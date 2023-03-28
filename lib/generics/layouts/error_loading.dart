import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class ErrorLoading extends StatelessWidget {
  const ErrorLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Error loading data ... :( ",
        style: Styles.kHeadlineTextStyle,
      ),
    );
  }
}
