import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  VideoWidget(this.url, {Key key}) : super(key: key);
  @override
  _VideoWidgetState createState() => new _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      // 播放状态
      ..addListener(() {
        setState(() {});
      })
      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.initialized
          ? GestureDetector(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              onTap: () {
                print(_controller.value.isPlaying);
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              })
          : Container(
            color: Colors.yellow,
          ),
    );
  }
}
