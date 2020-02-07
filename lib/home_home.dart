import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as client;
import 'dart:convert';

import 'home/xiangqing.dart';


class Product{
    final String movieId="10";
//    Product(this.movieId);
}


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _bannerList = [
    "http://mobile.bwstudent.com/images/movie/stills/whwdzg/whwdzg1_h.jpg",
    "http://mobile.bwstudent.com/images/movie/stills/zgjz/zgjz1_h.jpg",
    "http://mobile.bwstudent.com/images/movie/stills/pdz/pdz1_h.jpg",
    "http://mobile.bwstudent.com/images/movie/stills/sndn/sndn1_h.jpg",
    "http://mobile.bwstudent.com/images/movie/stills/dwsj/dwsj1_h.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 1000,
      color: ColorsUtil.hexColor(0x161B33),
      child: Column(
        children: <Widget>[
          SwiperDiy(swiperDataList: _bannerList), //页面顶部轮播组件
          _Release_Widget(),
          coming_soon_Widget(),
          _hot_movie_Widget(),
        ],
      ),
    );
  }
}

/// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //轮播宽度
      height: 240,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        // 横向
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              child: Container(
            decoration: BoxDecoration(
                //color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("${swiperDataList[index]}"),
                  fit: BoxFit.fill,
                )),
          ));
        },
        itemCount: swiperDataList.length,
        //pagination: new SwiperPagination(),
        autoplay: true,
        viewportFraction: 0.8,
        // 当前视窗展示比例 小于1可见上一个和下一个视窗
        scale: 0.8, // 两张图片之间的间隔
      ),
    );
  }
}

//正在上映
class _Release_Widget extends StatefulWidget {
  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<_Release_Widget> {
  List list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Data();
  }

  get_Data() async {
    client
        .get(
            "http://mobile.bwstudent.com/movieApi/movie/v2/findReleaseMovieList?page=1&&count=5")
        .then((client.Response response) {
      var data = json.decode(response.body);
      data = data["result"];
      //打印请求的结果
      print(data);
      print('打印信息');
      //更新数据
      setState(() {
        list = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      fit: FlexFit.tight,
      child: ListView(
        children: _getItem(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  List<Widget> _getItem() {
    return list.map((item) {
      return new GestureDetector(
        child: Card(
          elevation: 3.0,
          color: ColorsUtil.hexColor(0x1E2444),
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: _item(item),
          ),
          margin: const EdgeInsets.all(10.0),
        ),
        onTap: (){

          Navigator.of(context)//of是对context跨组件获取数据的一个封装。
              .push(MaterialPageRoute(builder: (context) => DyXiangQing2(text: "${item["movieId"]}",)));
        },
      );
    }).toList();
  }
//第一个列表
  Widget _item(item) {
    return   new Stack(
      children: <Widget>[
        //图片
        new Center(
          child: new FadeInImage.assetNetwork(

            placeholder: "images/jc.jpg",
            image: "${item['imageUrl']}",
            width: 150.0,
            height: 100.0,
          ),
        ),
        //文字
        Container(

          width: 150 ,
          alignment: const Alignment(0.0, -1.0),
          child:
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              child:   new Text("${item["director"]}".trim(),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left),
            )
          ,
            Container(child: new Text(
              "${item["name"]}",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),)

          ],
        ),
             )
      ],

    );
  }
}

//即将上映
class coming_soon_Widget extends StatefulWidget {
  @override
  _coming_State createState() => _coming_State();
}

class _coming_State extends State<coming_soon_Widget> {
  List list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Data();
  }

  get_Data() async {
    client
        .get(
            "http://mobile.bwstudent.com/movieApi/movie/v2/findComingSoonMovieList?page=1&&count=5")
        .then((client.Response response) {
      var data = json.decode(response.body);
      data = data["result"];
      //打印请求的结果
      print(data);
      print('打印信息');
      //更新数据
      setState(() {
        list = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      fit: FlexFit.tight,
      child: ListView(
        children: _getItem(),
      ),
    );
  }

  List<Widget> _getItem() {
    return list.map((item) {
      return new Card(
        color: ColorsUtil.hexColor(0x1E2444),

        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: _item(item),
        ),
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),
      );
    }).toList();
  }
//中间
  Widget _item(item) {
    return new Row(
      children: <Widget>[
        new Center(
          child: new FadeInImage.assetNetwork(
            placeholder: "images/jc.jpg",
            image: "${item['imageUrl']}",
            width: 200.0,
            height: 200.0,
          ),
        ),
        new Column(
          children: <Widget>[
            new Text("${item["name"]}".trim(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left),
            new Text(
              "${item["wantSeeNum"]}人想看",
              style: new TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}

//热门电影
//最后一个
class _hot_movie_Widget extends StatefulWidget {
  @override
  _hot_movie_State createState() => _hot_movie_State();
}

class _hot_movie_State extends State<_hot_movie_Widget> {
  List list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Data();
  }

  get_Data() async {
    client
        .get(
            "http://mobile.bwstudent.com/movieApi/movie/v2/findHotMovieList?page=1&&count=3")
        .then((client.Response response) {
      var data = json.decode(response.body);
      data = data["result"];
      //打印请求的结果
      print(data);
      print('打印信息');
      //更新数据
      setState(() {
        list = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      fit: FlexFit.tight,
      child: ListView(
        children: _getItem(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  List<Widget> _getItem() {
    return list.map((item) {
      return new Card(
        color: ColorsUtil.hexColor(0x1E2444),

        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: _item(item),
        ),
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),
      );
    }).toList();
  }

  Widget _item(item) {
    return new Stack(
      children: <Widget>[
        new Center(
          child: new FadeInImage.assetNetwork(
            placeholder: "images/jc.jpg",
            image: "${item['horizontalImage']}",
            width: 200.0,
            height: 200.0,
          ),
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text("${item["name"]}".trim(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left),
            new Text(
              "${item["starring"]}",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ColorsUtil {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex,{double alpha = 1}){
    if (alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16 ,
        (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0,
        alpha);
  }
}