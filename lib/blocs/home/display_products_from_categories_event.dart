part of 'display_products_from_categories_bloc.dart';

@immutable
abstract class DisplayProductsFromCategoriesEvent {}

class FetchDataDisplayProductsFromCategoriesEvent
    extends DisplayProductsFromCategoriesEvent {}

class ComputingSortDisplayProductsFromCategoriesEvent
    extends DisplayProductsFromCategoriesEvent {}

class OnProductReturnDisplayProductsFromCategoriesEvent
    extends DisplayProductsFromCategoriesEvent {
  final int categoryIndex;

  OnProductReturnDisplayProductsFromCategoriesEvent(this.categoryIndex);
}

class OnDeleteDisplayProductsFromCategoriesEvent
    extends DisplayProductsFromCategoriesEvent {
  final ProductsDisplayProductModel product;
  final int categoryIndex;
  OnDeleteDisplayProductsFromCategoriesEvent({
    required this.product,
    required this.categoryIndex,
  });
}

class OnFilterDisplayProductsFromCategoriesEvent
    extends DisplayProductsFromCategoriesEvent {
  final AnimatedListModel<ProductsDisplayProductModel> list;
  final DisplayProductsFilterEnum filterType;

  OnFilterDisplayProductsFromCategoriesEvent(
      {required this.list, required this.filterType});
}
