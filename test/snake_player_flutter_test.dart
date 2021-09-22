import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('snake_player_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SnakePlayerFlutter.platformVersion, '42');
  });
}
