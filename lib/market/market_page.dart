
import 'package:douban_flutter/global/global_constant.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final _tabs = ['豆瓣豆品', '豆瓣时间'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: GlobalConstant.bgColor,
          centerTitle: true,
          title: Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              color: GlobalConstant.bgColor,
              child: TabBar(
                isScrollable: false,
                tabs: _tabs.map((String choice) {
                  return Tab(
                    text: choice,
                  );
                }).toList(),
                labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: 16.0),
                labelColor: GlobalConstant.mainColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: GlobalConstant.mainColor,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
        ),
        body: TabBarView(
          children: [
            Text('123'),
            Text('123'),
          ],
        ),
      ),
    );
  }
}
