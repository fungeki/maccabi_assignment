import 'package:flutter/material.dart';
import 'package:maccabi_assignment/pages/home/utils/display_products_filter_enum.dart';

import '../../../utils/styles.dart';

class DisplayCategoriesProductDetailSortDialog extends StatelessWidget {
  const DisplayCategoriesProductDetailSortDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sortTypes = DisplayProductsFilterEnum.values;
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeadline(),
            buildListView(sortTypes),
          ],
        ));
  }

  Text buildHeadline() {
    return const Text(
      "Sort by:",
      textAlign: TextAlign.center,
      style: Styles.kHeadlineTextStyle,
    );
  }

  ListView buildListView(List<DisplayProductsFilterEnum> sortTypes) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortTypes.length,
      itemBuilder: (context, index) {
        final sortValue = sortTypes[index];
        return SizedBox(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(sortValue),
            child: Text(
              sortValue.getCaption(),
              style: Styles.kSortCaptionTextStyle,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
