import 'dart:convert';

import '../model/article_api.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2024-09-09&sortBy=publishedAt&apiKey=c839eee721ed4898987a8216789cbaca';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              auther: element["author"],
              content: element["content"],
              published: element["publishedAt"]);
          news.add(articleModel);
        }
      });
    }
  }
}
