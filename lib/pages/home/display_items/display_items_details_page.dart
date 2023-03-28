import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maccabi_assignment/model/animated_list/animated_list_model.dart';
import 'package:maccabi_assignment/pages/home/dialog/display_categories_product_detail_sort_dialog.dart';
import 'package:maccabi_assignment/pages/home/utils/display_products_filter_enum.dart';
import 'package:maccabi_assignment/pages/home/widgets/display_products_details_card.dart';

import '../../../blocs/home/display_products_from_categories_bloc.dart';
import '../../../generics/layouts/no_items.dart';
import '../../../model/products_display/products_display_product_model.dart';
import '../../../utils/styles.dart';

/*
* The second screen is a list of all of the items in this category ...
* every item should show the products name, thumbnail,
* price and rating ...
* in the app bar you should create a sort button...
* when the sort button is pressed you should show a popup menu to sort items by price,
* rating, and discount percentage ...
* the sort is ascending from top to bottom.
* the default sort is by price.*/
class DisplayItemsDetailsPage extends StatefulWidget {
  const DisplayItemsDetailsPage(
      {Key? key, required this.initialProducts, required this.categoryIndex})
      : super(key: key);

  final List<ProductsDisplayProductModel> initialProducts;
  final int categoryIndex;

  @override
  State<DisplayItemsDetailsPage> createState() =>
      _DisplayItemsDetailsPageState();
}

class _DisplayItemsDetailsPageState extends State<DisplayItemsDetailsPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimatedListModel<ProductsDisplayProductModel> _list;
  late DisplayProductsFromCategoriesBloc bloc;

  @override
  void initState() {
    _list = AnimatedListModel<ProductsDisplayProductModel>(
        listKey: _listKey,
        removedItemBuilder: _buildRemovedItem,
        initialItems: widget.initialProducts);
    bloc = context.read<DisplayProductsFromCategoriesBloc>();
    bloc.add(OnFilterDisplayProductsFromCategoriesEvent(
      list: _list,
      filterType: DisplayProductsFilterEnum.price,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Display items',
          style: Styles.kHeadlineTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => onSortPressed(),
            icon: const Icon(
              Icons.filter_alt,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DisplayProductsFromCategoriesBloc,
            DisplayProductsFromCategoriesState>(
          builder: (context, state) {
            if (state is ComputingSortDisplayProductsFromCategoriesState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NoProductsDisplayProductsFromCategoriesState) {
              return const NoItems();
            }
            return buildAnimatedList();
          },
        ),
      ),
    );
  }

  AnimatedList buildAnimatedList() {
    return AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: (context, index, animation) {
          return DisplayProductsDetailsCard(
            product: _list[index],
            onDelete: () async {
              final product = _list[index];
              bloc.add(OnDeleteDisplayProductsFromCategoriesEvent(
                  product: product, categoryIndex: widget.categoryIndex));
              if (_list.length == 1) return;
              _list.removeAt(index);
            },
            animation: animation,
          );
        });
  }

  Widget _buildRemovedItem(ProductsDisplayProductModel item,
      BuildContext context, Animation<double> animation) {
    return DisplayProductsDetailsCard(
      product: item,
      animation: animation,
    );
  }

  Future onSortPressed() async {
    final sortValue = await showDialog(
        context: context,
        builder: (context) => const DisplayCategoriesProductDetailSortDialog());
    if (sortValue == null) return;
    bloc.add(OnFilterDisplayProductsFromCategoriesEvent(
      list: _list,
      filterType: sortValue,
    ));
  }
}
