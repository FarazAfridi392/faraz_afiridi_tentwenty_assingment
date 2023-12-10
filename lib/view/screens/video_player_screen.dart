import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/util/styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoPlayerScreen extends StatefulWidget {
  final String videoId;

  YouTubeVideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _YouTubeVideoPlayerScreenState createState() =>
      _YouTubeVideoPlayerScreenState();
}

class _YouTubeVideoPlayerScreenState extends State<YouTubeVideoPlayerScreen> {
  late YoutubePlayerController _controller;
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
    
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        
      
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    // if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
    //   setState(() {
    //     _playerState = _controller.value.playerState;
    //     _videoMetaData = _controller.metadata;
    //   });
    // }
  }

  @override
  void deactivate() {
    
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        
        controller: _controller,
        showVideoProgressIndicator: true,
        onEnded: (metadata) {
          Get.back();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Trailer',style: poppinsMedium,),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: poppinsMedium.color,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: Center(
            child: player,
          ),
        );
      },
    );
  }
}
