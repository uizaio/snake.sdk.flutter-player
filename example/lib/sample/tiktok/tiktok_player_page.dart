import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';

class TiktokPlayerPage extends StatefulWidget {
  const TiktokPlayerPage({Key? key}) : super(key: key);

  @override
  _TiktokPlayerPageState createState() => _TiktokPlayerPageState();
}

class _TiktokPlayerPageState extends State<TiktokPlayerPage> {
  PageController controller = PageController();
  final List<Widget> _list = <Widget>[
    Pages(
      link: VideoConstants.linkPlayVODPortrait1,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait2,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait3,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait4,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: _list,
        scrollDirection: Axis.vertical,
        controller: controller,
        onPageChanged: (int num) {
          setState(() {});
        },
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final String link;

  const Pages({required this.link});

  @override
  Widget build(BuildContext context) {
    BetterPlayerControlsConfiguration _controlsConfiguration =
        const BetterPlayerControlsConfiguration(
      enableSkips: false,
      enableFullscreen: false,
    );
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: Get.width / Get.height,
      fit: BoxFit.cover,
      autoPlay: true,
      looping: true,
      controlsConfiguration: _controlsConfiguration,
    );
    BetterPlayerController _betterPlayerController =
        BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      link,
    );
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: Get.width / Get.height,
          child: BetterPlayer(controller: _betterPlayerController),
        ),
      ],
    );
  }
}
