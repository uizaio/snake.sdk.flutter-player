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
      ratio: Get.width / Get.height,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait2,
      ratio: Get.width / Get.height,
    ),
    Pages(
      link: VideoConstants.linkPlayVOD,
      ratio: 16 / 9,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait3,
      ratio: Get.width / Get.height,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait4,
      ratio: Get.width / Get.height,
    ),
    Pages(
      link: VideoConstants.linkPlayVODPortrait5,
      ratio: Get.width / Get.height,
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
  final double ratio;

  const Pages({required this.link, required this.ratio});

  @override
  Widget build(BuildContext context) {
    BetterPlayerControlsConfiguration _controlsConfiguration =
        const BetterPlayerControlsConfiguration(
      enableSkips: false,
      enableFullscreen: false,
    );
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: ratio,
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

    return Center(
      child: AspectRatio(
        aspectRatio: ratio,
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }
}
