import 'package:amebo/bloc/get_top_headlines_bloc.dart';
import 'package:amebo/elements/error_element.dart';
import 'package:amebo/elements/loader_element.dart';
import 'package:amebo/model/article.dart';
import 'package:amebo/model/article_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSliderWidget extends StatefulWidget {
  @override
  _HeadlineSliderWidgetState createState() => _HeadlineSliderWidgetState();
}

class _HeadlineSliderWidgetState extends State<HeadlineSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc..getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
        stream: getTopHeadlinesBloc.subject.stream,
        builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
          if (snapshot.hasData) {
            //checking if there is an error in the article coming from the stream
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return buildErrorWidget((snapshot.data.error));
            }
            return _buildHeadlineSlider(snapshot.data);
            //checking if no data is returned or any 404 status
          } else if (snapshot.hasError) {
            return buildErrorWidget((snapshot.error));
          } else {
            return buildLoaderWidget();
          }
        });
  }

  Widget _buildHeadlineSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: false, height: 200.0, viewportFraction: 0.9),
        items: getExpenseSliders(articles),
      ),
    );
  }

  getExpenseSliders(List<ArticleModel> articles)  {
    return articles.map(
      (articles) => GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: articles.urlToImage == null
                              ? AssetImage("assets/img/placeholder.png")
                              : NetworkImage((articles.urlToImage)))),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.white.withOpacity(0.4)
                          ])),
                ),
                Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: 250.0,
                      child: Column(
                        children: [
                          Text(
                            articles.title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          )
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      articles.source.name,
                      style: TextStyle(color: Colors.white54, fontSize: 9.0),
                    )),
                Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      timeAgo(DateTime.parse(articles.publishedAt)),
                      style: TextStyle(color: Colors.white54, fontSize: 9.0),
                    )),
              ],
            ),
          )),
    ).toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
