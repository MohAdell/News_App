import 'dart:core';

class ArticleModel {
  String? auther;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  String? published;

  ArticleModel(
      {this.auther,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.published});
}
