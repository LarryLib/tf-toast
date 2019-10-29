#import "TfToastPlugin.h"
#import <tf_toast/tf_toast-Swift.h>

@implementation TfToastPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTfToastPlugin registerWithRegistrar:registrar];
}
@end
