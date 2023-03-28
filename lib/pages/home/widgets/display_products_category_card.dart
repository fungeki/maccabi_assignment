import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maccabi_assignment/generics/layouts/headline_value_rich_text.dart';
import 'package:maccabi_assignment/utils/extensions.dart';

import '../../../model/products_display/products_display_category_model.dart';
import '../../../utils/styles.dart';

class DisplayProductsCategoryCard extends StatelessWidget {
  const DisplayProductsCategoryCard({Key? key, required this.category})
      : super(key: key);

  final ProductsDisplayCategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeadline(),
          Expanded(
            child: _buildCachedNetworkImage(),
          ),
          _buildBottomCaption()
        ],
      ),
    );
  }

  Padding _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        category.name.capitalize(),
        style: Styles.kHeadlineTextStyle,
      ),
    );
  }

  CachedNetworkImage _buildCachedNetworkImage() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: category.thumbnail,
      width: double.maxFinite,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
  }

  Padding _buildBottomCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeadlineValueRichText(
              headline: 'Items amount: ',
              value: category.products.length.toString()),
          HeadlineValueRichText(
              headline: 'Stock: ', value: category.stock.toString()),
        ],
      ),
    );
  }
}
