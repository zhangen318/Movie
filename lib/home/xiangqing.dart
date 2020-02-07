

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;
import 'package:movie/bean/dy_bean_entity.dart';

void  main(){
  runApp(MaterialApp(
    title: "电影详情",
    home: DyXiangQing2(),
  ));
}
class DyXiangQing2 extends StatelessWidget{
  DyXiangQing2({
    Key key,
    @required this.text,
  }
      ):super (key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: DyXiangQing(text),
    );
  }

}
//主框架
class DyXiangQing extends StatefulWidget {
  final String text;
  DyXiangQing(this.text);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return XiangQing_Widget(text);
  }
}


class XiangQing_Widget extends  State<DyXiangQing> {
  final String text;
  DyBeanEntity data2;
  XiangQing_Widget(this.text);
  @override
  void initState(){
    super.initState();
    xiangQingGet();
  }
  xiangQingGet() async {
     client
     .get("http://mobile.bwstudent.com/movieApi/movie/v2/findMoviesDetail?movieId="+text)
         .then((client.Response response){
           var data=json.decode(response.body);
            data2 = new DyBeanEntity().fromJson(data);
            setState(() {
              xiangQingGet();

            });
     });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: data2.result.imageUrl,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
          ],
        ),
      ),
    );
  }

}