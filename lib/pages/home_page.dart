import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/services/category_data.dart';
import 'package:news_app/services/news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/article_api.dart';
import '../model/article_model.dart';
import '../model/category_model.dart';
import '../model/slider_model.dart';
import '../services/article_data.dart';
import '../services/slider_data.dart';
import 'article_view_page.dart';
import 'categorys_news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<ArticleCategory> articlesShow = [];
  List<ArticleModel> articleModel = [];
  List<SliderModelView> sliders = [];
  int activeIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    categories = getCategorys();
    articlesShow = getArticles();
    getSliders();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articleModel = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  getSliders() async {
    SlidersView sliderClass = SlidersView();
    await sliderClass.getSliders();
    sliders = sliderClass.slidersvieww;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'News ',
              style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
            ),
            Text(
              'App',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    icon: Icon(Icons.change_circle)),
              ],
            )
          ]),
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   height: 70,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return CategoryTitle(
                      //         image: categories[index].image,
                      //         categoryName: categories[index].categoryName,
                      //       );
                      //     },
                      //     itemCount: categories.length,
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CategoryTitle(
                              image: articlesShow[index].articleImage,
                              categoryName: articlesShow[index].articleName,
                              title: articleModel[index].title!,
                              desc: articleModel[index].description!,
                              imageUrl: articleModel[index].urlToImage!,
                            );
                          },
                          itemCount: articlesShow.length,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Breaking News',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Teko'),
                            ),
                            // Text(
                            //   'More..',
                            //   style: TextStyle(
                            //       color: Colors.blue,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold,
                            //       fontFamily: 'Teko'),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CarouselSlider.builder(
                          itemCount: sliders.length,
                          itemBuilder: (context, index, realIndex) {
                            String? res = sliders[index].urlToImage;
                            String? res1 = sliders[index].title;
                            return buildImage(res!, index, res1!);
                          },
                          options: CarouselOptions(
                              height: 200,
                              enlargeCenterPage: true,
                              // viewportFraction: 1,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                              // enableInfiniteScroll: true,
                              enlargeStrategy:
                                  CenterPageEnlargeStrategy.height),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: buildIndicator(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trending News',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Teko'),
                            ),
                            // Text(
                            //   'More..',
                            //   style: TextStyle(
                            //       color: Colors.blue,
                            //       fontSize: 20,
                            //       fontWeight: FontWeight.bold,
                            //       fontFamily: 'Teko'),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: articleModel.length,
                            itemBuilder: (context, index) {
                              return BlogTitle(
                                url: articleModel[index].url!,
                                title: articleModel[index].title!,
                                desc: articleModel[index].description!,
                                imageUrl: articleModel[index].urlToImage!,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }

  Widget buildImage(String urlImage, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                imageUrl: urlImage,
              )),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 10.0),
            margin: EdgeInsets.only(top: 125),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          )
        ],
      ));
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        axisDirection: Axis.horizontal,
      );
}

class CategoryTitle extends StatelessWidget {
  final image, categoryName;
  String imageUrl, title, desc;

  CategoryTitle({
    super.key,
    this.image,
    this.categoryName,
    required this.title,
    required this.desc,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategorysNewsPage(
                        name: categoryName,
                      )));
        },
        onSecondaryTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleViewPage(
                        title: title,
                        desc: desc,
                        imageUrl: imageUrl,
                      )));
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 100,
                  height: 90,
                  fit: BoxFit.fill,
                ),
              ),
              // Container(
              //   width: 100,
              //   height: 90,
              //   decoration: BoxDecoration(borderRadius: BorderRadius.horizontal()),
              //   child: Text(
              //     categoryName,
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ));
  }
}

class ArticleTitle extends StatelessWidget {
  final articleImage, articleName;
  const ArticleTitle({super.key, this.articleImage, this.articleName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              articleImage,
              width: 100,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          // Container(
          //   width: 100,
          //   height: 90,
          //   decoration: BoxDecoration(borderRadius: BorderRadius.horizontal()),
          //   child: Text(
          //     articleName,
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          // )
        ],
      ),
    );
  }
}

class BlogTitle extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTitle(
      {required this.title,
      required this.desc,
      required this.imageUrl,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleViewPage(
                      title: title,
                      desc: desc,
                      imageUrl: imageUrl,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                            imageUrl: imageUrl,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            title,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 6),
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            desc,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
