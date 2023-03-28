import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:maccabi_assignment/model/products_display/products_display_category_model.dart';
import 'package:maccabi_assignment/pages/home/utils/display_products_filter_enum.dart';
import 'package:maccabi_assignment/services/url_requests.dart';
import 'package:meta/meta.dart';

import '../../model/animated_list/animated_list_model.dart';
import '../../model/products_display/products_display_product_model.dart';
import '../../utils/urls.dart';

part 'display_products_from_categories_event.dart';
part 'display_products_from_categories_state.dart';

class DisplayProductsFromCategoriesBloc extends Bloc<
    DisplayProductsFromCategoriesEvent, DisplayProductsFromCategoriesState> {
  final List<ProductsDisplayProductModel> products = [];
  final List<ProductsDisplayCategoryModel> categories = [];
  DisplayProductsFromCategoriesBloc()
      : super(DisplayProductsFromCategoriesInitial()) {
    on<DisplayProductsFromCategoriesEvent>((event, emit) async {
      if (event is OnProductReturnDisplayProductsFromCategoriesEvent) {
        if (categories[event.categoryIndex].products.isEmpty) {
          categories.removeAt(event.categoryIndex);
        }
        emit(FinishedSortDisplayProductsFromCategoriesState());
      }
      if (event is OnDeleteDisplayProductsFromCategoriesEvent) {
        final product = event.product;
        final category = categories[event.categoryIndex];
        category.products.remove(product);
        category.stock -= product.stock.toInt();
        if (category.products.isEmpty) {
          emit(NoProductsDisplayProductsFromCategoriesState());
        }
      }
      if (event is FetchDataDisplayProductsFromCategoriesEvent) {
        emit(LoadingDisplayProductsFromCategoriesState());
        final didSucceed = await fetchData();
        if (!didSucceed) {
        } else {
          emit(OnFinishedLoadingDisplayProductsFromCategoriesState(categories));
        }
      }
      if (event is OnFilterDisplayProductsFromCategoriesEvent) {
        emit(ComputingSortDisplayProductsFromCategoriesState());
        final products = event.list.items;
        switch (event.filterType) {
          case DisplayProductsFilterEnum.price:
            products.sort((a, b) => a.price.compareTo(b.price));
            break;
          case DisplayProductsFilterEnum.discountPercentage:
            products.sort(
                (a, b) => a.discountPercentage.compareTo(b.discountPercentage));
            break;
          case DisplayProductsFilterEnum.name:
            products.sort((a, b) => a.name.compareTo(b.name));
            break;
        }
        emit(FinishedSortDisplayProductsFromCategoriesState());
      }
    });
  }

  Future<bool> fetchData() async {
    final response = await UrlRequests.getRequest(url: Urls.kGetProductListUrl);
    if (response != null) {
      final dataMap = response as Map<String, dynamic>;
      try {
        final productsDataList = dataMap["products"] as List?;
        if (productsDataList == null) return false;
        final categoriesMap = <String, int>{};
        for (final productJson in productsDataList) {
          if (productJson is Map<String, dynamic>) {
            final product = ProductsDisplayProductModel.fromJson(productJson);
            products.add(product);
            final categoryFromMap = categoriesMap[product.category];
            final doesCategoryExist = categoryFromMap != null;
            if (doesCategoryExist) {
              categories[categoryFromMap].addProduct(product);
            } else {
              categoriesMap[product.category] = categories.length;
              categories.add(ProductsDisplayCategoryModel.fromProduct(product));
            }
          }
        }
        return true;
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());
        return false;
      }
    } else {
      return false;
    }
  }
}
