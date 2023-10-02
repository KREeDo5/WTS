// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as int,
      title: json['title'] as String?,
      productDescription: json['productDescription'] as String?,
      price: json['price'] as int,
      rating: json['rating'],
      imageUrl: json['imageUrl'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isAvailableForSale: json['isAvailableForSale'] as int,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'images': instance.images,
      'title': instance.title,
      'productDescription': instance.productDescription,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'isAvailableForSale': instance.isAvailableForSale,
      'productId': instance.productId,
    };
