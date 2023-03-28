import 'package:maccabi_assignment/model/products_display/products_display_product_model.dart';

class ProductsDisplayCategoryModel {
  final String name;
  final List<ProductsDisplayProductModel> products;
  final String thumbnail;
  int stock;

  ProductsDisplayCategoryModel(
      {required this.name,
      required this.products,
      required this.thumbnail,
      required this.stock});

  factory ProductsDisplayCategoryModel.fromProduct(
      ProductsDisplayProductModel product) {
    return ProductsDisplayCategoryModel(
      name: product.category,
      products: [product],
      thumbnail: product.thumbnail,
      stock: product.stock.toInt(),
    );
  }

  void addProduct(ProductsDisplayProductModel product) {
    products.add(product);
    stock += product.stock.toInt();
  }
}
