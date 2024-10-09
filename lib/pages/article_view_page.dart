import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/article_api.dart';
import '../services/news.dart';

class ArticleViewPage extends StatelessWidget {
  List<ArticleModel> articleModel = [];
  String imageUrl, title, desc;
  ArticleViewPage({
    required this.title,
    required this.desc,
    required this.imageUrl,
  });

  @override
  void initState() {
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articleModel = newsClass.news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'News',
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
          ),
          Text(
            'App',
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ]),
      ),
      body: GestureDetector(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ArticleViewPage()));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        imageUrl: imageUrl,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      title,
                      // maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                          fontFamily: 'Tako'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            '______________________________________',
                            // maxLines: 2,
                            style: TextStyle(
                              color: Colors.black12,
                              fontWeight: FontWeight.w100,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      desc,
                      maxLines: 200,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                  ),

                  // Column(
                  //   children: [
                  //     Container(
                  //       width: MediaQuery.of(context).size.width / 1.7,
                  //       child: Text(
                  //         title,
                  //         maxLines: 2,
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 17),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 5.0,
                  //     ),
                  //     Container(
                  //       width: MediaQuery.of(context).size.width / 1.7,
                  //       child: Text(
                  //         desc,
                  //         maxLines: 3,
                  //         style: TextStyle(
                  //             color: Colors.black26,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 17),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          )),
    );
  }
}
