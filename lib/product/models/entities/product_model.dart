import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel({
    required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.images,
    required this.isAvailableForSale,
  });

  dynamic rating;
  List<String>? images;
  String? title;
  String? productDescription;
  String? imageUrl;
  int price;
  int isAvailableForSale;
  int productId;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}