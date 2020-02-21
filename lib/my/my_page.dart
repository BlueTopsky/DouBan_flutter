import 'package:douban_flutter/global/global_constant.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          style: TextStyle(fontSize: 18.0, color: Color(0xFF3A3A3A)),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: GlobalConstant.bgColor,
      ),
      body: new Center(
        child: new Text('MyPage'),
      ),
    );
  }
}
