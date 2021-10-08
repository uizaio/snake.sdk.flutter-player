import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';
import 'package:snake_player_flutter_example/common/util/file_utils.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
      GlobalKey();
  final List<BetterPlayerDataSource> _dataSourceList = [];
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;

  _PlaylistPageState() {
    _betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 1,
      fit: BoxFit.cover,
      placeholderOnTop: true,
      showPlaceholderUntilPlay: true,
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(fontSize: 10),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      autoPlay: true,
    );
    _betterPlayerPlaylistConfiguration =
        const BetterPlayerPlaylistConfiguration(
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 3),
    );
  }

  Future<List<BetterPlayerDataSource>> setupData() async {
    _dataSourceList.add(
      BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, VideoConstants.forBiggerBlazesUrl,
          subtitles: BetterPlayerSubtitlesSource.single(
            type: BetterPlayerSubtitlesSourceType.file,
            url: await FileUtils.getFileUrl(
                VideoConstants.fileExampleSubtitlesUrl),
          ),
          placeholder: Image.network(
            VideoConstants.catImageUrl,
            fit: BoxFit.cover,
          )),
    );

    _dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        VideoConstants.bugBuckBunnyVideoUrl,
        placeholder: Image.network(
          VideoConstants.catImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
    _dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        VideoConstants.forBiggerJoyridesVideoUrl,
      ),
    );

    return _dataSourceList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlaylistPage"),
      ),
      body: FutureBuilder<List<BetterPlayerDataSource>>(
        future: setupData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Building!");
          } else {
            return ListView(children: [
              const Padding(
                padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
                child: Text(
                    "Playlist widget will load automatically next video once current "
                    "finishes. User can't use player controls when video is changing."),
              ),
              AspectRatio(
                child: BetterPlayerPlaylist(
                  key: _betterPlayerPlaylistStateKey,
                  betterPlayerConfiguration: _betterPlayerConfiguration,
                  betterPlayerPlaylistConfiguration:
                      _betterPlayerPlaylistConfiguration,
                  betterPlayerDataSourceList: snapshot.data!,
                ),
                aspectRatio: 1,
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.setupDataSource(0);
                },
                child: const Text("Change to first data source"),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.setupDataSource(2);
                },
                child: const Text("Change to last source"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("Currently playing video: " +
                      _betterPlayerPlaylistController!.currentDataSourceIndex
                          .toString());
                  Get.snackbar(
                    "Currently playing video",
                    _betterPlayerPlaylistController?.currentDataSourceIndex
                            .toString() ??
                        "",
                  );
                },
                child: const Text("Check currently playing video index"),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.betterPlayerController!
                      .pause();
                },
                child: const Text(
                    "Pause current video with BetterPlayerController"),
              ),
              ElevatedButton(
                onPressed: () {
                  var list = [
                    BetterPlayerDataSource(
                      BetterPlayerDataSourceType.network,
                      VideoConstants.bugBuckBunnyVideoUrl,
                      placeholder: Image.network(
                        VideoConstants.catImageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  ];
                  _betterPlayerPlaylistController?.setupDataSourceList(list);
                },
                child: const Text("Setup new data source list"),
              ),
            ]);
          }
        },
      ),
    );
  }

  BetterPlayerPlaylistController? get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey
          .currentState!.betterPlayerPlaylistController;
}
