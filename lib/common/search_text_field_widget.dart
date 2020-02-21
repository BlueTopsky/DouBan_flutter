
import 'package:douban_flutter/global/global_constant.dart';
import 'package:douban_flutter/r.dart';
import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final String hintText;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;
  final Color bgColor;
  final double width;
  SearchTextFieldWidget({Key key, this.hintText, this.margin, this.bgColor, this.onTap, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.all(0) : margin,
      height: 37,
      width: width == null ? MediaQuery.of(context).size.width : width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        onTap: onTap,
        onSubmitted: (text) {},
        cursorColor: GlobalConstant.mainColor, // 光标的颜色
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 1),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 192, 191, 191),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 25,
            color: Color.fromARGB(255, 128, 128, 128),
          ),
          suffixIcon: ImageIcon(
            AssetImage(R.assetsImagesScanning),
            size: 10,
            color: Color.fromARGB(255, 128, 128, 128),
          ),
        ),
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
