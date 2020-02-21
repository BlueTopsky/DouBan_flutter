import 'dart:io';

import 'package:douban_flutter/global/global_constant.dart';
import 'package:douban_flutter/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 全局配置RefreshConfiguration
    return RefreshConfiguration(
        headerBuilder: () =>
            ClassicHeader(
          releaseText: '松手刷新',
          completeText: '刷新成功',
          failedText: '刷新失败',
          refreshingText: '刷新中...',
          idleText: '下拉刷新',
          refreshingIcon: CupertinoActivityIndicator(),
        ), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
        footerBuilder: () => CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败，请重试");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松手加载");
            } else {
              body = Text("没有更多数据了");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ), // 配置默认底部指示器
        headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
        springDescription: SpringDescription(
            stiffness: 170,
            damping: 16,
            mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
        maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted:
            true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
        child: MaterialApp(
          title: 'DouBan',
          theme: ThemeData(
            backgroundColor: GlobalConstant.bgColor,
            primaryColor: GlobalConstant.bgColor,
            platform: TargetPlatform.iOS, //增加后支持侧滑返回
            primaryColorBrightness: Brightness.light,
          ),
          home: SplashPage(),
        ));
  }
}
