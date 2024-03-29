#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// import <PhotoLibrary/PLCameraControllerDelegate-Protocol.h>

#import "VideoInterface.h"

@interface CameraController : NSObject <VideoInterfaceDelegate, UIAlertViewDelegate>

// @property(nonatomic, assign) QSCameraDevice cameraDevice;
// @property(nonatomic, assign) QSFlashMode flashMode;
// @property(nonatomic, assign) BOOL enableHDR;

// Setting this property to yes causes the controller to wait for up to 5 seconds for focusing to complete before taking a photo
// @property(nonatomic, assign) BOOL waitForFocusCompletion;
// Automatically set every time the orientation changes, but you can force a different orientation, provided it doesn't change after you've forced it.
// @property(nonatomic, assign) UIDeviceOrientation currentOrientation;

@property(nonatomic, readonly, getter = isCapturingVideo) BOOL capturingVideo;
// @property(nonatomic, readonly, getter = isCapturingImage) BOOL capturingImage;

// video properties
@property(nonatomic, copy) NSString *videoCaptureQuality;
// @property(nonatomic, assign) QSFlashMode videoFlashMode;

+ (instancetype)sharedInstance;

// The completion handlers are copied. They are, however, destroyed after being called, so no need to worry about retain loops
// - (void)takePhotoWithCompletionHandler:(QSCompletionHandler)completionHandler;

// Pass in an interruption handler. Seriously. You don't want to never get a callback of this.
// All these methods will work if you pass in nil as the handler. Do you if you don't care what happens
- (void)startVideoCapture;
- (void)stopVideoCapture;

@end
