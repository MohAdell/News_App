import 'dart:convert';

import '../model/article_api.dart';
import 'package:http/http.dart' as http;

import '../model/sho_category_model.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> showCategoryData = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=c839eee721ed4898987a8216789cbaca';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ShowCategoryModel showCategoryModel = ShowCategoryModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              auther: element["author"],
              content: element["content"],
              published: element["publishedAt"]);
          showCategoryData.add(showCategoryModel);
        }
      });
    }
  }
}
