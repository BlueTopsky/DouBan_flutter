import 'package:douban_flutter/common/search_text_field_widget.dart';
import 'package:douban_flutter/global/global_constant.dart';
import 'package:flutter/material.dart';

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => new _AudioPageState();
}

class _AudioPageState extends State<AudioPage>{
  final _tabs = ['电影', '电视', '读书', '原创小说', '音乐', '同城'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: GlobalConstant.bgColor,
        centerTitle: false,
        title: SearchTextFieldWidget(
          hintText: '第92届奥斯卡竞争力分析',
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
      body: DefaultTabController(
        length: _tabs.length,
        initialIndex: 1,
        child: Column(
          children: <Widget>[
            Container(
              color: GlobalConstant.bgColor,
              child: TabBar(
                isScrollable: true,
                tabs: _tabs.map((String choice) {
                  return Tab(
                    text: choice,
                  );
                }).toList(),
                labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: 16.0),
                labelColor: Colors.black,
                unselectedLabelColor: Color.fromARGB(255, 117, 117, 117),
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
            Container(
              height: 1,
              color: Color.fromARGB(255, 228, 228, 228),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: [
                  Text('123'),
                  Text('123'),
                  Text('123'),
                  Text('123'),
                  Text('123'),
                  Text('123'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
