import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as client;
import 'dart:convert';

import 'package:movie/Home.dart'; //使用 json 解析

void main() => runApp(Login_Widget());

class Login_Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: TextFieldAndCheckPage(),
    );
  }
}

class TextFieldAndCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TextFieldAndCheckPageState();
}

class TextFieldAndCheckPageState extends State<TextFieldAndCheckPage> {
  List list;

  get_Data(String phone, String pwd) async {
    client
        .post("http://mobile.bwstudent.com/movieApi/user/v2/login")
        .then((client.Response response) {
      var data = json.decode(response.body);
      data = data["result"];
      //打印请求的结果
      print(data);
      //更新数据
      setState(() {
        list = data;
      });
    });
  }

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), hintText: '请输入账号'),
            autofocus: false,
          ),
          TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0), hintText: '请输入密码'),
              obscureText: true),
          RaisedButton(
            onPressed: _login,
            child: Text('登录'),
          ),
        ],
      ),
    );
  }

  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('手机号码格式不对'),
              ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('请填写密码'),
              ));
    } else {
      get_Data(phoneController.text, passController.text);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('登录成功'),
              ));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home_Widget()));
      phoneController.clear();
    }
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }
}
