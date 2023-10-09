import '../entities/meta_api_model.dart';

class BaseApiResponse {
  BaseApiResponse({required this.metaInfo, required this.dataInfo});

  final MetaModel metaInfo;
  final dynamic dataInfo;
}
