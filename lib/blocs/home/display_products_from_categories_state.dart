part of 'display_products_from_categories_bloc.dart';

@immutable
abstract class DisplayProductsFromCategoriesState {}

class DisplayProductsFromCategoriesInitial
    extends DisplayProductsFromCategoriesState {}

class ErrorDisplayProductsFromCategoriesState
    extends DisplayProductsFromCategoriesState {}

class NoProductsDisplayProductsFromCategoriesState
    extends DisplayProductsFromCategoriesState {}

class LoadingDisplayProductsFromCategoriesState
    extends DisplayProductsFromCategoriesState {}

class ComputingSortDisplayProductsFromCategoriesState
    extends DisplayProductsFromCategoriesState {}

class FinishedSortDisplayProductsFromCategoriesState
    extends DisplayProductsFromCategoriesState {}

class OnFinishedLoadingDisplayProductsFromCategoriesState
    extends DisplayProductsFromCategoriesState {
  final List<ProductsDisplayCategoryModel> categories;

  OnFinishedLoadingDisplayProductsFromCategoriesState(this.categories);
}
