import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const VideoPlayerScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _initializeChewieController();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoPath);
    await _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      showControlsOnInitialize: false,
      looping: true,
      // Other customization options can be added here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player Screen'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.isInitialized
                ? Chewie(
              controller: _chewieController,
            )
                : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
