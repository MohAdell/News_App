import '../model/article_model.dart';

List<ArticleCategory> getArticles() {
  List<ArticleCategory> article = [];
  ArticleCategory articleModel = new ArticleCategory();
  articleModel.articleName = "Middle-East";
  articleModel.articleImage = "assets/middle-east.png";
  article.add(articleModel);
  articleModel = new ArticleCategory();

  articleModel.articleName = "World";
  articleModel.articleImage = "assets/world news.webp";
  article.add(articleModel);
  articleModel = new ArticleCategory();

  articleModel.articleName = "Politics";
  articleModel.articleImage = "assets/politics news.jpg";
  article.add(articleModel);
  articleModel = new ArticleCategory();

  articleModel.articleName = "Business";
  articleModel.articleImage = "assets/Business news.jpg";
  article.add(articleModel);
  articleModel = new ArticleCategory();

  articleModel.articleName = "Health";
  articleModel.articleImage = "assets/Health news.png";
  article.add(articleModel);
  articleModel = new ArticleCategory();

  return article;
}
