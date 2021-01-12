class ArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  ArticleModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  ArticleModel.fromJson(dynamic json) {
    author = json["author"];
    title = json["title"];
    description = json["description"];
    url = json["url"];
    urlToImage = json["urlToImage"];
    publishedAt = json["publishedAt"];
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["author"] = author;
    map["title"] = title;
    map["description"] = description;
    map["url"] = url;
    map["urlToImage"] = urlToImage;
    map["publishedAt"] = publishedAt;
    map["content"] = content;
    return map;
  }
}
