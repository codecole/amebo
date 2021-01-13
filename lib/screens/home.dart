import 'package:amebo/style/theme.dart';
import 'package:amebo/widgets/headline_slider.dart';
import 'package:amebo/widgets/hot_news.dart';
import 'package:amebo/widgets/top_channels.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderWidget(),

        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Top Channels",style: kSubHeading,),
        ),
        TopChannels(),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Hot News",style: kSubHeading,),
        ),
        HotNews()

      ],

    );
  }
}
