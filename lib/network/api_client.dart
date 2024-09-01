import 'package:basic_utils/basic_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shepherd_voice/global/constants/domain_constants.dart';
import 'package:shepherd_voice/global/helpers/shared_pref_manager.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/models/module.dart';

import '../models/app_exception.dart';
import '../models/module_response.dart';

class APIClient {
  static final APIClient shared = APIClient._privateConstructor();
  final String baseUrl = '18.218.44.244:8080';
  static const _api = 'api/v1';

  APIClient._privateConstructor();

  Future<List<FilmResponse>> getMovies({
    required int page,
    int pageSize = Constants.pageSize,
  }) async {
    return _getItems(
      module: Module.film,
      converter: (json) => FilmResponse.fromJson(json),
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<FilmResponse>> getHymens({
    required int page,
    int pageSize = Constants.pageSize,
  }) async {
    return _getItems(
      module: Module.song,
      converter: (json) => FilmResponse.fromJson(json),
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<FilmResponse>> getBooks({
    required int page,
    int pageSize = Constants.pageSize,
  }) async {
    return _getItems(
      module: Module.book,
      converter: (json) => FilmResponse.fromJson(json),
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<FilmResponse>> getActivities({
    required int page,
    int pageSize = Constants.pageSize,
  }) async {
    return _getItems(
      module: Module.activity,
      converter: (json) => FilmResponse.fromJson(json),
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<FilmResponse>> getPopeWords({
    required int page,
    int pageSize = Constants.pageSize,
  }) async {
    return _getItems(
      module: Module.popeWord,
      converter: (json) => FilmResponse.fromJson(json),
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<T>> _getItems<T extends ModuleResponse>({
    required Module module,
    required T Function(Map<String, dynamic> json) converter,
    required int page,
    required int pageSize,
  }) async {
    Map<String, String> params =
        _trailingParametersPref(page: page, pageSize: pageSize);
    params
        .addAll({'type': StringUtils.camelCaseToLowerUnderscore(module.name)});
    var response = await http.get(Uri.http(baseUrl, '$_api/items', params));
    if (response.statusCode == 200) {
      return listFromJson(
        response.body,
        (json) => converter(json),
      );
    } else {
      throw _returnResponse(response);
    }
  }

  Map<String, String> _trailingParametersPref({
    required int page,
    required int pageSize,
  }) {
    return {'locale': _languagePref(), 'page': page, 'per_page': pageSize}
        .map((key, value) => MapEntry(key, value.toString()));
  }

  String _languagePref() {
    return '${SharedPrefManager.getLocale()}';
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw AppException(response.body.toString());
      case 401:
        throw AppException(response.body.toString());
      case 403:
        throw AppException(response.body.toString());
      case 500:
      default:
        throw AppException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
