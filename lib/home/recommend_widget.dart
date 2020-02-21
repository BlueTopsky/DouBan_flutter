import 'dart:convert';
import 'dart:io';
import 'package:douban_flutter/common/large_picture_page.dart';
import 'package:douban_flutter/global/global_constant.dart';
import 'package:douban_flutter/home/video_widget.dart';
import 'package:douban_flutter/home/web_page.dart';
import 'package:douban_flutter/r.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendWidget extends StatefulWidget {
  @override
  _RecommendWidgetState createState() => new _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {
  List<dynamic> list = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _requestRecommendData() async {
    var responseStr = await rootBundle.loadString('mock/recommend.json');
    var responseJson = json.decode(responseStr);
    setState(() {
      list = responseJson['subjects'];
    });
  }

  @override
  void initState() {
    super.initState();
    _requestRecommendData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    var responseStr = await rootBundle.loadString('mock/recommend.json');
    var responseJson = json.decode(responseStr);
    setState(() {
      list = responseJson['subjects'];
    });
    _refreshController.refreshCompleted();
    if (responseJson['total'] <= list.length) {
      _refreshController.loadNoData();
    } else {
      _refreshController.resetNoData();
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    var responseStr = await rootBundle.loadString('mock/recommend.json');
    var responseJson = json.decode(responseStr);
    setState(() {
      list.addAll(responseJson['subjects']);
    });

    if (responseJson['total'] <= list.length) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  //GridView单元组件
  List<GestureDetector> _buildGridTileList(List data, int count, Map item) {
    return new List<GestureDetector>.generate(
      count,
      (int index) => new GestureDetector(
        child: Hero(
          createRectTween: _createRectTween,
          tag: data[index],
          transitionOnUserGestures: true,
          child: new Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(data[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return LargePicturePage(
          //     pictureList: data,
          //     index: index,
          //   );
          // }));
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 700), //动画时间为500毫秒
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return new FadeTransition(
                    //使用渐隐渐入过渡,
                    opacity: animation,
                    child: LargePicturePage(
                      pictureList: data,
                      index: index,
                    ), //路由B
                  );
                }),
          );
        },
      ),
    );
  }

  Widget _buildRecommendItemWidget(int index) {
    void _onTapMenu() {
      if (Platform.isAndroid) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return new SimpleDialog(
                children: <Widget>[
                  new SimpleDialogOption(
                    child: new Text(
                      '收藏',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new SimpleDialogOption(
                    child: new Text(
                      '对此话题不敢兴趣',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new SimpleDialogOption(
                    child: new Text(
                      '内容质量差',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new SimpleDialogOption(
                    child: new Text(
                      '不看作者',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } else {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('收藏'),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('对此话题不敢兴趣'),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('内容质量差'),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('不看此作者'),
                ),
              ],
            );
          },
        );
      }
    }

    return Container(
      color: GlobalConstant.bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(list[index]['avatars']),
                  backgroundColor: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(list[index]['title']),
                ),
                Expanded(
                  child: Align(
                    child: IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                      onPressed: () {
                        _onTapMenu();
                      },
                    ),
                    alignment: Alignment.centerRight,
                  ),
                )
              ],
            ),
          ),
          Container(
            child: list[index]['desc'] == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                    child: Text(
                      list[index]['desc'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 8),
            child: list[index]['subtype'] == 'picture'
                ? GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 3,
                    children: _buildGridTileList(
                      list[index]['data'],
                      list[index]['data'].length,
                      list[index],
                    ),
                  )
                : VideoWidget(list[index]['data'][0]),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 35.0, right: 35.0, bottom: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  R.assetsImagesIcVote,
                  width: 25.0,
                  height: 25.0,
                ),
                GestureDetector(
                  child: Image.asset(
                    R.assetsImagesIcNotificationTvCalendarComments,
                    width: 20.0,
                    height: 20.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(
                              list[index]['title'], list[index]['alt'])),
                    );
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    R.assetsImagesIcStatusDetailReshareIcon,
                    width: 25.0,
                    height: 25.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(
                              list[index]['title'], list[index]['alt'])),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildRecommendItemWidget(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 4,
              color: Color(0xFFF5F5F5),
            );
          },
        ),
      ),
    );
  }
}
