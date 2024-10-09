import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/sho_category_model.dart';
import '../services/show_category_data.dart';

class CategorysNewsPage extends StatefulWidget {
  String name;
  CategorysNewsPage({required this.name});
  @override
  State<CategorysNewsPage> createState() => _CategorysNewsPageState();
}

class _CategorysNewsPageState extends State<CategorysNewsPage> {
  List<ShowCategoryModel> showCategory = [];
  bool _loading = true;
  getNews() async {
    ShowCategoryNews showCategoryClass = ShowCategoryNews();
    await showCategoryClass.getCategoryNews(widget.name.toLowerCase());
    showCategory = showCategoryClass.showCategoryData;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '  News',
                  style: TextStyle(
                      color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: showCategory.length,
              itemBuilder: (context, index) {
                return ShowCategory(
                  url: showCategory[index].url!,
                  title: showCategory[index].title!,
                  desc: showCategory[index].description!,
                  imageUrl: showCategory[index].urlToImage!,
                );
              }),
        ));
  }
}

class ShowCategory extends StatelessWidget {
  String imageUrl, title, desc, url;
  ShowCategory(
      {required this.title,
      required this.desc,
      required this.imageUrl,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
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
