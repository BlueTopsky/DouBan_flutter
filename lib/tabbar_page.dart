import 'package:douban_flutter/audio/audio_page.dart';
import 'package:douban_flutter/global/global_constant.dart';
import 'package:douban_flutter/group/group_page.dart';
import 'package:douban_flutter/home/home_page.dart';
import 'package:douban_flutter/market/market_page.dart';
import 'package:douban_flutter/my/my_page.dart';
import 'package:douban_flutter/r.dart';
import 'package:flutter/material.dart';

class TabbarPage extends StatefulWidget {
  @override
  _TabbarPageState createState() => new _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  List<Widget> pages;
  List<BottomNavigationBarItem> itemList;
  int _selectIndex = 0;
  final tabbarItems = [
    _TabbarItem(
        "首页", R.assetsImagesIcTabHomeNormal, R.assetsImagesIcTabHomeActive),
    _TabbarItem("书影音", R.assetsImagesIcTabSubjectNormal,
        R.assetsImagesIcTabShijiActive),
    _TabbarItem(
        "小组", R.assetsImagesIcTabGroupNormal, R.assetsImagesIcTabGroupActive),
    _TabbarItem(
        "市集", R.assetsImagesIcTabShijiNormal, R.assetsImagesIcTabShijiActive),
    _TabbarItem("我的", R.assetsImagesIcTabProfileNormal,
        R.assetsImagesIcTabProfileActive),
  ];

  @override
  void initState() {
    super.initState();
    pages = [HomePage(), AudioPage(), GroupPage(), MarketPage(), MyPage()];
    itemList = tabbarItems
        .map((item) => BottomNavigationBarItem(
            icon: Image.asset(
              item.normalIcon,
              width: 30.0,
              height: 30.0,
            ),
            title: Text(
              item.title,
              style: TextStyle(fontSize: 10.0),
            ),
            activeIcon:
                Image.asset(item.activeIcon, width: 30.0, height: 30.0)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalConstant.bgColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: GlobalConstant.mainColor,
        unselectedItemColor: Color.fromARGB(255, 125, 125, 125),
        currentIndex: _selectIndex,
        items: itemList,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _selectIndex,
        children: pages,
      ),
    );
  }
}

class _TabbarItem {
  String title, normalIcon, activeIcon;
  _TabbarItem(this.title, this.normalIcon, this.activeIcon);
}
