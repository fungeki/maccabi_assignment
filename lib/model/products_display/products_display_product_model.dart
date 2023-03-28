class ProductsDisplayProductModel {
  final int id;
  final String name;
  final String category;
  final String thumbnail;
  final num price;
  final num discountPercentage;
  final num rating;
  final num stock;

  ProductsDisplayProductModel(
      {required this.id,
      required this.name,
      required this.discountPercentage,
      required this.thumbnail,
      required this.category,
      required this.price,
      required this.stock,
      required this.rating});

  factory ProductsDisplayProductModel.fromJson(Map<String, dynamic> json) {
    return ProductsDisplayProductModel(
        id: json['id'] as int,
        name: json['title'] as String,
        category: json['category'] as String,
        price: json['price'] as num,
        rating: json['rating'] as num,
        stock: json['stock'] as num,
        discountPercentage: json['discountPercentage'] as num,
        thumbnail: json['thumbnail'] as String);
  }
}
