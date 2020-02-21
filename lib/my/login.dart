import 'package:douban_flutter/global/global_constant.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalConstant.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: GlobalConstant.bgColor,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new Center(
        child: new Text(
          '登录',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
