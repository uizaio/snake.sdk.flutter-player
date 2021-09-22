import 'package:flutter/material.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Snake Player'),
        ),
        body: Column(
          children: [
            const Text('Running on'),
            SampleButton(
              text: "Sample Button",
              onPressed: () {
                print("Sample Button Click");
              },
            ),
          ],
        ),
      ),
    );
  }
}
