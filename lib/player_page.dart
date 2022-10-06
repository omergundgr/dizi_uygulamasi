import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wistv/consts/colors.dart';
import 'package:wistv/widgets/appbar2.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

late VideoPlayerController _videoPlayerCtrl;
late ChewieController _chewieCtrl;

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    _videoPlayerCtrl = VideoPlayerController.network(Get.arguments);
    _chewieCtrl = ChewieController(
      videoPlayerController: _videoPlayerCtrl,
      aspectRatio: 16 / 9,
      autoInitialize: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerCtrl.dispose();
    _chewieCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar2(),
      backgroundColor: MyColors.backgroundColor,
      body: Chewie(
        controller: _chewieCtrl,
      ),
    );
  }
}
