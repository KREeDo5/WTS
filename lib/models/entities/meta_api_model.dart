import 'package:json_annotation/json_annotation.dart';
part 'meta_api_model.g.dart';

@JsonSerializable()
class MetaModel {
  final bool success;
  final String? error;

  MetaModel({
    required this.success,
    required this.error,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}