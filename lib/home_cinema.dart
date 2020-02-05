import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;
import 'dart:convert'; //使用 json 解析

class Cinema extends StatefulWidget {
  @override
  _CinemaState createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: TabBar(
                  ///TabBar布局
                  tabs: <Widget>[
                    Tab(text: "推荐影院"),
                    Tab(text: "附近影院"),
                    Tab(text: "查询区域地址"),
                  ],
                ),
              )
            ],
          ),

          ///设置标题居中
          centerTitle: true,
        ),
        body: Tabs(),
      ),
    );
    return Column(
      children: <Widget>[],
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  TabsWidget createState() => TabsWidget();
}

class TabsWidget extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TabBarView(
      children: <Widget>[
        _movie_Cinema(),
        _nearby_cinema(),
        _region_cinema(),
      ],
    );
  }
}

//热门影院
class _movie_Cinema extends StatefulWidget {
  @override
  _movie_CinemaWidget createState() => _movie_CinemaWidget();
}

class _movie_CinemaWidget extends State<_movie_Cinema> {
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
            "http://mobile.bwstudent.com/movieApi/cinema/v1/findRecommendCinemas?page=1&&count=10")
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
    return ListView(
      children: _getItem(),
    );
  }

  List<Widget> _getItem() {
    return list.map((item) {
      return new Card(
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
            image: "${item['logo']}",
            width: 200.0,
            height: 200.0,
          ),
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text("${item["name"]}".trim(),
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left),
            new Text(
              "${item["address"]}",
            )
          ],
        ),
      ],
    );
  }
}

//附近影院
class _nearby_cinema extends StatefulWidget {
  @override
  _nearby_cinemawidget createState() => _nearby_cinemawidget();
}

class _nearby_cinemawidget extends State<_nearby_cinema> {
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
            "http://mobile.bwstudent.com/movieApi/cinema/v1/findNearbyCinemas?page=1&&count=10")
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
    return ListView(
      children: _getItem(),
    );
  }

  List<Widget> _getItem() {
    return list.map((item) {
      return new Card(
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
            image: "${item['logo']}",
            width: 200.0,
            height: 200.0,
          ),
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text("${item["name"]}".trim(),
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left),
            new Text(
              "${item["address"]}",
            )
          ],
        ),
      ],
    );
  }
}

//查询区域ID
class _region_cinema extends StatefulWidget {
  @override
  _region_cinemawidget createState() => _region_cinemawidget();
}

class _region_cinemawidget extends State<_region_cinema> {
  List list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Data();
  }

  get_Data() async {
    client
        .get("http://mobile.bwstudent.com/movieApi/tool/v2/findRegionList")
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
    return ListView(
      children: _getItem(),
    );
  }

  List<Widget> _getItem() {
    return list.map((item) {
      return new Card(
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
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text("${item["regionName"]}".trim(),
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left),
          ],
        ),
      ],
    );
  }
}
