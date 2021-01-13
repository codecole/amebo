import 'package:amebo/bloc/get_sources_bloc.dart';
import 'package:amebo/elements/error_element.dart';
import 'package:amebo/elements/loader_element.dart';
import 'package:amebo/model/source_response.dart';
import 'package:flutter/material.dart';
import 'package:amebo/model/sources.dart';



class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState(){
    super.initState();
    getSourcesBloc..getSources();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
        stream: getSourcesBloc.subject.stream,
        builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
          if (snapshot.hasData) {
            //checking if there is an error in the source coming from the stream
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return buildErrorWidget((snapshot.data.error));
            }
            return _buildTopChannel(snapshot.data);
            //checking if no data is returned or any 404 status
          } else if (snapshot.hasError) {
            return buildErrorWidget((snapshot.error));
          } else {
            return buildLoaderWidget();
          }
        });
  }
  Widget _buildTopChannel(SourceResponse data){
    List <SourceModel> source = data.sources;
    if(source.length==0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("No Sources")
          ],
        ),
      );
    }else{
      return Container(
        height: 115.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: source.length,
            itemBuilder: (context,index){
              return Container(
                width: 80.0,
                child: GestureDetector(
                  onTap: (){},
                  child: Column(
                    children: [
                      Hero(tag: source[index].id,child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(1.0,1.0))
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/${source[index].id}.png")
                          )
                        ),

                      ),),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(source[index].name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0
                      ),),
                      SizedBox(height: 3.0,),
                      Text(source[index].category,
                      maxLines: 2,
                          textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.black54,
                        fontSize: 9/0

                      ),)
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
