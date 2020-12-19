import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  bool played = false;
  CustomVideoPlayer({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      // looping: widget.looping,
      showControls: true,
      allowedScreenSleep: false,
      allowFullScreen: true,
      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.landscapeRight,
      //   DeviceOrientation.landscapeLeft,
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ],
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    // _chewieController.addListener(() {
    //   if (_chewieController.isFullScreen) {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.landscapeRight,
    //       DeviceOrientation.landscapeLeft,
    //     ]);
    //   } else {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.portraitUp,
    //       DeviceOrientation.portraitDown,
    //     ]);
    //   }
    // });
    widget.videoPlayerController.addListener(() async {
      if (widget.videoPlayerController.value.isPlaying) {
        if (!widget.played) {
          widget.played = true;
          print("PLAYED IN CVP" + DateTime.now().toString());
          await DatabaseService(uid: uid).updateViewsCount(
              widget.videoPlayerController.dataSource.toString());
        }
      }
    });
    // while (true) {

    // }
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).copyWith().size.width,
          height: 200,
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }
}
