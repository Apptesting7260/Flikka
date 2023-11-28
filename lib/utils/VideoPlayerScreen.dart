import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  const VideoPlayerScreen({  Key? key, required this.videoPath}) : super(key: key);

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player Screen'),
      ),
      body: Center(
        child: PlayerWidget(
          videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse(widget.videoPath),
          ),
          looping: true,
        ),
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  const PlayerWidget({super.key,  required this.videoPlayerController, this.looping = false, });

  @override
  PlayerWidgetState createState() => PlayerWidgetState();
}

class PlayerWidgetState extends State<PlayerWidget> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      placeholder: const Center(child: CircularProgressIndicator()),
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      showControlsOnInitialize: false,
      looping: widget.looping,
      // Other customization options can be added here
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller:_chewieController
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
