import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maccabi_assignment/generics/layouts/headline_value_rich_text.dart';

import '../../../model/products_display/products_display_product_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/styles.dart';

class DisplayProductsDetailsCard extends StatelessWidget {
  const DisplayProductsDetailsCard(
      {Key? key, required this.product, this.onDelete, required this.animation})
      : super(key: key);

  final ProductsDisplayProductModel product;
  final VoidCallback? onDelete;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        height: Constants.kDetailsCardHeight,
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            extentRatio: 0.3,
            dismissible: DismissiblePane(
              onDismissed: () => onDelete?.call(),
            ),
            dragDismissible: true,
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => onDelete?.call(),
                backgroundColor: Styles.kDeleteColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  _buildCachedNetworkImage(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildCardContent(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildProductName(), _buildProductInfoRow()],
    );
  }

  Text _buildProductName() {
    return Text(
      product.name,
      style: Styles.kHeadlineTextStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductInfoRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineValueRichText(
            headline: "Discount: ", value: "${product.discountPercentage}%"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadlineValueRichText(
                headline: "Final Price: ", value: "${product.price}₪"),
            HeadlineValueRichText(
                headline: "Rating: ", value: product.rating.toString()),
          ],
        ),
      ],
    );
  }

  CachedNetworkImage _buildCachedNetworkImage() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: product.thumbnail,
      width: Constants.kThumbImageSize,
      height: Constants.kThumbImageSize,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
  }
}
