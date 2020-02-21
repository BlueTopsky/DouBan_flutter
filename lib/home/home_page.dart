import 'package:douban_flutter/common/search_text_field_widget.dart';
import 'package:douban_flutter/global/global_constant.dart';
import 'package:douban_flutter/home/dynamic_widget.dart';
import 'package:douban_flutter/home/recommend_widget.dart';
import 'package:douban_flutter/my/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _tabs = ['动态', '推荐'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: GlobalConstant.mainColor,
        centerTitle: false,
        title: SearchTextFieldWidget(
          hintText: '你和二手书之间的故事',
          bgColor: GlobalConstant.bgColor,
          onTap: () {
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.mail_outline),
            color: Colors.white,
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
              padding: EdgeInsets.only(left: 50, right: 50),
              color: GlobalConstant.bgColor,
              child: TabBar(
                isScrollable: false,
                tabs: _tabs.map((String choice) {
                  return Tab(
                    text: choice,
                  );
                }).toList(),
                labelStyle: TextStyle(fontSize: 16.0),
                unselectedLabelStyle: TextStyle(fontSize: 16.0),
                labelColor: GlobalConstant.mainColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: GlobalConstant.mainColor,
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
                  DynamicWidget(),
                  RecommendWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return new SlideTransition(
                    position: Tween(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: LoginPage(),
                  );
                }),
          );
        },
        tooltip: '创建',
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        child: Icon(Icons.create),
      ),
    );
  }
}
