import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../screens/module/task pages/watch screens/basic_overlay.dart';

//This is the screen where the video sits.
//This widget is necessary to make it easier to put overlays on the video.
class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: buildVideo(),
        )
      : Container(
          height: 200,
          child: const Center(child: CircularProgressIndicator()),
        );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(
            child: BasicOverlayWidget(controller: controller),
          ),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
