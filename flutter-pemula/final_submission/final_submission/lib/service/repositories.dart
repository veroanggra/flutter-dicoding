import 'package:dio/dio.dart';
import 'package:final_submission/model/article_response.dart';
import 'package:final_submission/model/source_response.dart';

class NewsRepo {
  static String baseUrl = 'https://newsapi.org/v2/';
  final String apikey = 'd7525c19bc0f4a928614e46943fb20e7';

  final Dio _dio = Dio();
  var getSourcesUrl = '$baseUrl/sources';
  var getHeadlinesUrl = '$baseUrl//top-headlines';
  var everythingUrl = '$baseUrl/everything';

  Future<SourceResponse> getSources() async {
    var params = {'apikey': apikey, 'language': 'en', 'country': 'us'};
    try {
      Response response =
          await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace : $stacktrace');
      return SourceResponse.withError('$error');
    }
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {'apikey': apikey, 'country': 'us'};
    try {
      Response response =
          await _dio.get(getHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace : $stacktrace');
      return ArticleResponse.withError('$error');
    }
  }

  Future<ArticleResponse> search(String value) async {
    var params = {'apikey': apikey, 'q': value, 'sortBy': 'popularity'};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace : $stacktrace');
      return ArticleResponse.withError('$error');
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {'apikey': apikey, 'q': 'apple', 'sortBy': 'popularity'};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace : $stacktrace');
      return ArticleResponse.withError('$error');
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {'apikey': apikey, 'sources': sourceId};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace : $stacktrace');
      return ArticleResponse.withError('$error');
    }
  }
}
