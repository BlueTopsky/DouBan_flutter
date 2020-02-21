import 'dart:async';

import 'package:douban_flutter/r.dart';
import 'package:douban_flutter/tabbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var tabbarPage = TabbarPage();
  bool showAd = true;
  var _seconds = 1;
  Timer _timer;

  //这是监听安卓的返回键操作
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('退出App?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('不'),
              ),
              new FlatButton(
                onPressed: () async {
                  await pop();
                },
                child: new Text('是的'),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  void initState() {
    print('init state');
    super.initState();
    _startTimer();
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds <= 1) {
        _cancelTimer();
        setState(() {
          showAd = false;
        });
        return;
      }
      setState(() {
        _seconds--;
      });
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
  }

  // 点击跳过广告
  void _onTapStopAd() {
    _cancelTimer();
    setState(() {
      showAd = false;
    });
  }

  Widget _buildSplashContainer(BuildContext context) {
    // 状态栏高度
    // double _statusBarHeight = MediaQuery.of(context).padding.top;
    // MediaQuery.of(context)这个里面还有其他信息，你们自行发掘吧
    // appbar 高度
    // double _kLeadingWidth = kToolbarHeight;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment(1.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.only(right: 30, top: 20),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                    child: GestureDetector(
                      child: Text(
                        '跳过$_seconds',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF3B3B3B),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onTap: _onTapStopAd,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEDED),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        R.assetsImagesIcLauncher,
                        width: 50,
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "豆瓣",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: <Widget>[
          Offstage(
            child: tabbarPage,
            offstage: showAd,
          ),
          Offstage(
            child: _buildSplashContainer(context),
            offstage: !showAd,
          )
        ],
      ),
    );
  }
}
