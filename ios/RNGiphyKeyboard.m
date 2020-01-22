#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNGiphyKeyboard, RCTEventEmitter)

RCT_EXTERN_METHOD(openGiphy: (NSDictionary*)options)
RCT_EXTERN_METHOD(dismissGiphy)

@end
