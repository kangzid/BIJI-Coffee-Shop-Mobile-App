import 'category_model.dart';

class Product {
  final int id;
  final int categoryId;
  final String title;
  final String? subtitle;
  final double price;
  final String? image;
  final Category? category;

  Product({
    required this.id,
    required this.categoryId,
    required this.title,
    this.subtitle,
    required this.price,
    this.image,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      price: double.parse(json['price'].toString()),
      image: json['image'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }
}
