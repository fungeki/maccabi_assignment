import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class HeadlineValueRichText extends StatelessWidget {
  const HeadlineValueRichText(
      {Key? key, required this.headline, required this.value})
      : super(key: key);
  final String headline;
  final String value;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: headline,
          style: Styles.kInfoHeadlineTextStyle,
          children: <TextSpan>[
            TextSpan(text: value, style: Styles.kInfoValueTextStyle),
          ]),
    );
  }
}
