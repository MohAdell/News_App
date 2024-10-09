import 'package:news_app/model/category_model.dart';

List<CategoryModel> getCategorys() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();
  categoryModel.categoryName = "BBC News";
  categoryModel.image = "assets/BBC News.webp";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "CNN News";
  categoryModel.image = "assets/cnn.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Al Jazeera News";
  categoryModel.image = "assets/Al Jazeera news.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "ABC News";
  categoryModel.image = "assets/ABCNews.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
