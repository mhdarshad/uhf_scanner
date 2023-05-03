#import "Uhf2newPlugin.h"
#if __has_include(<uhf2new/uhf2new-Swift.h>)
#import <uhf2new/uhf2new-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uhf2new-Swift.h"
#endif

@implementation Uhf2newPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUhf2newPlugin registerWithRegistrar:registrar];
}
@end
