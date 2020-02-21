import 'package:douban_flutter/r.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatelessWidget {
  final String title;
  final String url;
  WebPage(this.title, this.url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        leading: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(17),
            child: ImageIcon(
              AssetImage(R.assetsImagesIcArrowBack),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new WebviewScaffold(
        url: url,
        hidden: false,
        initialChild: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
