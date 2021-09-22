import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';
import 'package:snake_player_flutter_example/model/video_list_data.dart';

import 'video_list_widget.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({Key? key}) : super(key: key);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  final _random = Random();
  final List<String> _videos = [
    VideoConstants.bugBuckBunnyVideoUrl,
    VideoConstants.forBiggerBlazesUrl,
    VideoConstants.forBiggerJoyridesVideoUrl,
    VideoConstants.elephantDreamVideoUrl,
  ];
  List<VideoListData> dataList = [];
  var value = 0;

  @override
  void initState() {
    _setupData();
    super.initState();
  }

  void _setupData() {
    for (int index = 0; index < 10; index++) {
      var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
      dataList.add(VideoListData("Video $index", randomVideoUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VideoListPage")),
      body: Container(
        color: Colors.grey,
        child: Column(children: [
          TextButton(
            child: const Text("Update page state"),
            onPressed: () {
              setState(() {
                value++;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                VideoListData videoListData = dataList[index];
                return VideoListWidget(
                  videoListData: videoListData,
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
