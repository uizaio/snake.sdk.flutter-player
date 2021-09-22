#import "SnakePlayerFlutterPlugin.h"
#if __has_include(<snake_player_flutter/snake_player_flutter-Swift.h>)
#import <snake_player_flutter/snake_player_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "snake_player_flutter-Swift.h"
#endif

@implementation SnakePlayerFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSnakePlayerFlutterPlugin registerWithRegistrar:registrar];
}
@end
