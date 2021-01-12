import 'article.dart';

class ArticleResponse {
  List<ArticleModel> articles;
  String error;

  ArticleResponse({this.articles, this.error});

  ArticleResponse.fromJson(dynamic json) {
    if (json["articles"] != null) {
      articles = [];
      json["articles"].forEach((v) {
        articles.add(ArticleModel.fromJson(v));
      });
    } else {
      error = "";
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (articles != null) {
      map["articles"] = articles.map((v) => v.toJson()).toList();
    }
    return map;
  }

  ArticleResponse.withError(String errorValue)
      : articles = List(),
        error = errorValue;
}
