import 'package:amebo/main.dart';
import 'package:amebo/model/article_response.dart';
import 'package:amebo/model/source_response.dart';
import 'package:dio/dio.dart';

import 'api.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2";
  final String apiKey = APIKey;

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  //function to get NewsSource from Api
  Future<SourceResponse> getSources() async {
    var params = {"apiKey": apiKey, "language": "en", "country": "us"};
    try {
      Response response =
          await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured:$error stackTrace:$stacktrace");
      return SourceResponse.withError(error);
    }
  }

  //get the top headlines from API
  Future<ArticleResponse> getTopHeadlines() async {
    var params = {"apiKey": apiKey, "country": "ng"};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      return ArticleResponse.withError(error);
    }
  }

  //get the hot news from API
  Future<ArticleResponse> getHotNews() async {
    var params = {
      "apiKey": apiKey,
      "country": "us",
      "q": "apple",
      "sortBy": "popularity"
    };
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      return ArticleResponse.withError(error);
    }
  }

  //get the individual Souce news from API
  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceId,
    };
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      return ArticleResponse.withError(error);
    }
  }

  //search news from api
  Future<ArticleResponse> search(String searchValue) async {
    var params = {"apiKey": apiKey, "q": searchValue};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      return ArticleResponse.withError(error);
    }
  }
}
