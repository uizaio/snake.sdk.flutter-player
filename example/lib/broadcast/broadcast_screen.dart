import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_stream/camera.dart';
import 'package:wakelock/wakelock.dart';

import '../main.dart';

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
}

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({Key? key}) : super(key: key);

  @override
  _BroadcastScreenState createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller =
      CameraController(cameras[1], ResolutionPreset.high);
  String? imagePath;
  String? videoPath;
  String? url;
  late VoidCallback videoPlayerListener;
  bool enableAudio = true;
  bool useOpenGL = true;
  String streamURL = "rtmp://a.rtmp.youtube.com/live2/s0tx-t5ru-p009-38pw-8k1m";
  bool streaming = false;
  String? cameraDirection;

  Timer? _timer;

  @override
  void initState() {
    _initialize();
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Future<void> _initialize() async {
    streaming = false;
    cameraDirection = 'front';
    // controller = CameraController(cameras[1], Resolution.high);
    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller!.description!);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleCameraDirection() async {
    if (cameraDirection == 'front') {
      if (controller != null) {
        await controller?.dispose();
      }
      controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: enableAudio,
        androidUseOpenGL: useOpenGL,
      );

      // If the controller is updated then update the UI.
      controller!.addListener(() {
        if (mounted) setState(() {});
        if (controller!.value.hasError) {
          showInSnackBar('Camera error ${controller!.value.errorDescription}');
          if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
          Wakelock.disable();
        }
      });

      try {
        await controller!.initialize();
      } on CameraException catch (e) {
        _showCameraException(e);
      }

      if (mounted) {
        setState(() {});
      }
      cameraDirection = 'back';
    } else {
      if (controller != null) {
        await controller!.dispose();
      }
      controller = CameraController(
        cameras[1],
        ResolutionPreset.high,
        enableAudio: enableAudio,
        androidUseOpenGL: useOpenGL,
      );

      // If the controller is updated then update the UI.
      controller!.addListener(() {
        if (mounted) setState(() {});
        if (controller!.value.hasError) {
          showInSnackBar('Camera error ${controller!.value.errorDescription}');
          if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
          Wakelock.disable();
        }
      });

      try {
        await controller!.initialize();
      } on CameraException catch (e) {
        _showCameraException(e);
      }

      if (mounted) {
        setState(() {});
      }
      cameraDirection = 'front';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BroadcastScreen'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: streaming
                      ? ElevatedButton(
                          onPressed: () => onStopButtonPressed(),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.videocam_off),
                              SizedBox(width: 10),
                              Text(
                                'End Stream',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () => onVideoStreamingButtonPressed(),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.videocam),
                              SizedBox(width: 10),
                              Text(
                                'Start Stream',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: const Icon(Icons.switch_video),
                        tooltip: 'Switch Camera',
                        onPressed: () {
                          toggleCameraDirection();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: CameraPreview(controller!),
      );
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription? cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    if (cameraDescription == null) {
      print('cameraDescription is null');
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
      androidUseOpenGL: useOpenGL,
    );

    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError) {
        showInSnackBar('Camera error ${controller!.value.errorDescription}');
        if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
        Wakelock.disable();
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoStreamingButtonPressed() {
    startVideoStreaming().then((url) {
      if (mounted) {
        setState(() {
          streaming = true;
        });
      }
      if (url!.isNotEmpty) showInSnackBar('Streaming video to $url');
      Wakelock.enable();
    });
  }

  void onStopButtonPressed() {
    stopVideoStreaming().then((_) {
      if (mounted) {
        setState(() {
          streaming = false;
        });
      }
      showInSnackBar('Streaming to: $url');
    });
    Wakelock.disable();
  }

  void onPauseStreamingButtonPressed() {
    pauseVideoStreaming().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Streaming paused');
    });
  }

  void onResumeStreamingButtonPressed() {
    resumeVideoStreaming().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Streaming resumed');
    });
  }

  Future<String?> startVideoStreaming() async {
    if (!controller!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    // Open up a dialog for the url
    String myUrl = streamURL;

    try {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
      url = myUrl;
      await controller!.startVideoStreaming(url!, androidUseOpenGL: false);
      // _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      //   var stats = await controller!.getStreamStatistics();
      //   print(stats);
      // });
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return url;
  }

  Future<void> stopVideoStreaming() async {
    try {
      await controller!.stopVideoStreaming();
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<void> pauseVideoStreaming() async {
    if (!controller!.value.isStreamingVideoRtmp) {
      return;
    }

    try {
      await controller!.pauseVideoStreaming();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoStreaming() async {
    try {
      await controller!.resumeVideoStreaming();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
