import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:start_project/models/entities/meta_api_model.dart';
import 'base_api_response.dart';

const String _baseUrl = 'ostest.whitetigersoft.ru';
const String _appKey = 'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';

class BaseApi {
  var client = http.Client();

  Future<BaseApiResponse> get(String api, Map<String, dynamic> parameters) async {
    parameters['appKey'] = _appKey;
    var url = Uri(
      scheme: 'http',
      host: _baseUrl,
      path: api,
      queryParameters: parameters,
    );
    var rawResponse = await client.get(url);

    if (rawResponse.statusCode == 200) {
      return parseResponse(rawResponse.body);
    } else {
      throw Exception('Request failed with status: ${rawResponse.statusCode}');
    }
  }

  BaseApiResponse parseResponse(String responseBody) {
    try {
      final rawResponse = json.decode(responseBody);
      final metaJson = rawResponse['meta'];
      final dataJson = rawResponse['data'];
      return BaseApiResponse(metaInfo: metaJson, dataInfo: dataJson);

    } catch (e) {
      return BaseApiResponse(metaInfo: MetaModel(success: false, error: 'Failed to parse JSON: $e',), dataInfo: []);
    }
  }
}