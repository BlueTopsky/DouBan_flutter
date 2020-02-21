import 'package:douban_flutter/global/global_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LargePicturePage extends StatefulWidget {
  final List pictureList;
  final int index;
  LargePicturePage({this.pictureList, this.index});
  @override
  _LargePicturePageState createState() => new _LargePicturePageState();
}

class _LargePicturePageState extends State<LargePicturePage> {
  //轮播图单元组件
  Widget _swiperBuilder(BuildContext context, int index) {
    return Hero(
      tag: widget.pictureList[index],
      // child: PhotoView(
      //   imageProvider: NetworkImage(widget.pictureList[index], scale: 1.0),
      // ),
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          widget.pictureList[index],
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Swiper(
            itemBuilder: _swiperBuilder,
            itemCount: widget.pictureList.length,
            index: widget.index,
            pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: GlobalConstant.mainColor,
                size: 6,
                activeSize: 6,
              ),
              margin: EdgeInsets.only(bottom: 5),
            ),
            scrollDirection: Axis.horizontal,
            autoplay: false,
            loop: false,
            onTap: (index) {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
