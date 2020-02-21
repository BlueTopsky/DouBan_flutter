import 'package:douban_flutter/global/global_constant.dart';
import 'package:douban_flutter/my/login.dart';
import 'package:douban_flutter/r.dart';
import 'package:flutter/material.dart';

class DynamicWidget extends StatefulWidget {
  @override
  _DynamicWidgetState createState() => new _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  var isLogined = false;
  @override
  void initState() {
    super.initState();
  }

  //登录组件
  Widget _buildLoginContainer(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            R.assetsImagesIcNewEmptyViewDefault,
            width: 120,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
            child: Text(
              '登录后查看关注人动态',
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          GestureDetector(
            child: Container(
              child: Text(
                '去登录',
                style:
                    TextStyle(fontSize: 16.0, color: GlobalConstant.mainColor),
              ),
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: GlobalConstant.mainColor),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LoginPage(),
              //   ),
              // );
              Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration:
                        Duration(milliseconds: 500), //动画时间为500毫秒
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
          ),
        ],
      ),
    );
  }

  //动态组件
  Widget _buildDynamicContainer(BuildContext context) {
    return Center(
      child: Text('动态'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            child: _buildLoginContainer(context),
            offstage: isLogined,
          ),
          Offstage(
            child: _buildDynamicContainer(context),
            offstage: !isLogined,
          )
        ],
      ),
    );
  }
}
