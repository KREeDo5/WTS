// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryId: json['categoryId'] as int,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      hasSubcategories: json['hasSubcategories'] as int,
      fullName: json['fullName'] as String,
      categoryDescription: json['categoryDescription'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'hasSubcategories': instance.hasSubcategories,
      'fullName': instance.fullName,
      'categoryDescription': instance.categoryDescription,
    };
