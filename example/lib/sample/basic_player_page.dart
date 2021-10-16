import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';
import 'package:snake_player_flutter_example/common/util/file_utils.dart';

class BasicPlayerPage extends StatefulWidget {
  const BasicPlayerPage({Key? key}) : super(key: key);

  @override
  _BasicPlayerPageState createState() => _BasicPlayerPageState();
}

class _BasicPlayerPageState extends State<BasicPlayerPage> {
  final BetterPlayerConfiguration _betterPlayerConfiguration =
      const BetterPlayerConfiguration(
    aspectRatio: 16 / 9,
    fit: BoxFit.contain,
    autoPlay: true,
    deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic player"),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Basic player created with the simplest factory method. Shows video from URL.",
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer.network(
              VideoConstants.forBiggerBlazesUrl,
              betterPlayerConfiguration: _betterPlayerConfiguration,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Next player shows video from file.",
            ),
          ),
          FutureBuilder<String>(
            future: FileUtils.getFileUrl(VideoConstants.fileTestVideoUrl),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.data != null) {
                return BetterPlayer.file(
                  snapshot.data!,
                  betterPlayerConfiguration: _betterPlayerConfiguration,
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
