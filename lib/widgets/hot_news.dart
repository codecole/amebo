import 'package:amebo/bloc/get_hotnews_bloc.dart';
import 'package:amebo/elements/error_element.dart';
import 'package:amebo/elements/loader_element.dart';
import 'package:amebo/model/article.dart';
import 'package:amebo/model/article_response.dart';
import 'package:amebo/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HotNews extends StatefulWidget {
  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    super.initState();
    getHotNewsBloc..getHotNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
        stream: getHotNewsBloc.subject.stream,
        builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
          if (snapshot.hasData) {
            //checking if there is an error in the article coming from the stream
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return buildErrorWidget((snapshot.data.error));
            }
            return _buildHotNews(snapshot.data);
            //checking if no data is returned or any 404 status
          } else if (snapshot.hasError) {
            return buildErrorWidget((snapshot.error));
          } else {
            return buildLoaderWidget();
          }
        });
  }

  Widget _buildHotNews(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    return Container(
      height: articles.length / 2 * 210.0,
      padding: EdgeInsets.all(5.0),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Container(
              height: 220.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(1.0, 1.0))
                ],
              ),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                              image: articles[index].urlToImage == null
                                  ? AssetImage("assets/img/placeholder.png")
                                  : NetworkImage(articles[index].urlToImage),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Text(
                      articles[index].title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(height: 1.3, fontSize: 15.0),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: 180.0,
                        height: 1.0,
                        color: Colors.black12,
                      ),
                      Container(
                        width: 30.0,
                        height: 3.0,
                        color: kMainColor,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          articles[index].source.name,
                          style: TextStyle(color: kMainColor, fontSize: 9.0),
                        ),
                        Text(
                          timeAgo(DateTime.parse(articles[index].publishedAt)),
                          style: TextStyle(color: kMainColor, fontSize: 9.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
    if (articles.length == 0) {
      return Container(
        height: articles.length / 2 * 210.0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("No Articles")],
        ),
      );
    } else {
      return Container(
        width: 80.0,
        height: 300.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Container(
                height: 220.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(1.0, 1.0))
                  ],
                ),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              topLeft: Radius.circular(5.0),
                            ),
                            image: DecorationImage(
                                image: articles[index].urlToImage == null
                                    ? AssetImage("assets/img/placeholder.png")
                                    : NetworkImage(articles[index].urlToImage),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Text(
                        articles[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(height: 1.3, fontSize: 15.0),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          width: 180.0,
                          height: 1.0,
                          color: Colors.black12,
                        ),
                        Container(
                          width: 30.0,
                          height: 3.0,
                          color: kMainColor,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            articles[index].source.name,
                            style: TextStyle(color: kMainColor, fontSize: 9.0),
                          ),
                          Text(
                            timeAgo(
                                DateTime.parse(articles[index].publishedAt)),
                            style: TextStyle(color: kMainColor, fontSize: 9.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      );
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
