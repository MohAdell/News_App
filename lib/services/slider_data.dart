import '../model/slider_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// List<SliderModel> getSliders() {
//   List<SliderModel> slider = [];
//   SliderModel categoryModel = new SliderModel();
//   categoryModel.name = "BBC News";
//   categoryModel.image = "assets/BBC News.webp";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   categoryModel.name = "CNN News";
//   categoryModel.image = "assets/cnn.png";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   categoryModel.name = "Al Jazeeraaaaaaa News";
//   categoryModel.image = "assets/Al Jazeera news.jpg";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   categoryModel.name = "ABC News";
//   categoryModel.image = "assets/ABCNews.jpg";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   return slider;
// }

class SlidersView {
  List<SliderModelView> slidersvieww = [];

  Future<void> getSliders() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c839eee721ed4898987a8216789cbaca';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          SliderModelView slidersView = SliderModelView(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              auther: element["author"],
              content: element["content"],
              published: element["publishedAt"]);
          slidersvieww.add(slidersView as SliderModelView);
        }
      });
    }
  }
}
