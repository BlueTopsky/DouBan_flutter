import 'package:douban_flutter/common/search_text_field_widget.dart';
import 'package:douban_flutter/global/global_constant.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => new _GroupPageState();
}

class _GroupPageState extends State<GroupPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: GlobalConstant.bgColor,
        centerTitle: false,
        title: SearchTextFieldWidget(
          hintText: '搜索书影音 小组 日记 用户等',
          bgColor: Color.fromARGB(255, 237, 236, 237),
          onTap: () {
            print('点击');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.mail_outline),
            color: Color.fromARGB(255, 128, 128, 128),
            onPressed: () {},
          )
        ],
      ),
      body: new Center(
        child: new Text('GroupPage'),
      ),
    );
  }
}
