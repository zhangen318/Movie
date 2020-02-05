import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new MyHomeWidget(),
    );
  }
}

class MyHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demo'),
      ),
      body: new ListView(
        children: <Widget>[
          new Image.network(
            "http://172.17.8.100/images/health/user/head_pic/2019-12-30/m8zOGS20191230073957.jpeg",
            width: 600.0,
            height: 300.0,
            fit: BoxFit.cover,
          ),
          titleWidget,
          buttonWidget,
          textWidget
        ],
      ),
    );
  }
}

Widget titleWidget = new Container(
  padding: const EdgeInsets.all(30.0),
  child: new Row(
    children: <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Text(
                'Oeschinen Lake Campground',
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            new Text(
              'Kandersteg, Switzerland',
              style: new TextStyle(
                color: Colors.grey[450],
              ),
            )
          ],
        ),
      ),
      new Icon(
        Icons.star,
        color: Colors.red[400],
      ),
      new Text('41'),
    ],
  ),
);

Column getText(IconData icon, String text) {
  return new Column(
    //聚集widgets
    mainAxisSize: MainAxisSize.min,
    //child居中
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Icon(icon, color: Colors.blue[500]),
      new Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: new Text(
          text,
          style: new TextStyle(
            color: Colors.blue[500],
          ),
        ),
      )
    ],
  );
}

Widget buttonWidget = new Container(
  child: new Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      getText(Icons.call, "CALL"),
      getText(Icons.near_me, "ROUTE"),
      getText(Icons.share, "SHARE"),
    ],
  ),
);

Widget textWidget = new Container(
  alignment: Alignment.center,
  //设置内边距
  padding: const EdgeInsets.all(10.0),
  child: new Text(
    '加油  ',
  ),
);
