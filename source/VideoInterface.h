#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoInterfaceDelegate;

@interface VideoInterface : NSObject <AVCaptureFileOutputRecordingDelegate>
/*
	The value of this property is an NSString (one of AVCaptureSessionPreset*).
	If the given preset cannot be set, AVCaptureSessionPresetMedium will be set
 */
@property(nonatomic, copy) NSString *videoQuality;

@property(nonatomic, assign) AVCaptureDevicePosition devicePosition;
@property(nonatomic, assign) AVCaptureTorchMode torchMode;
@property(nonatomic, assign) id<VideoInterfaceDelegate> delegate;

@property(nonatomic, readonly) BOOL videoCaptureSessionRunning;


- (void)startVideoCapture;
- (void)stopVideoCapture;

@end

@protocol VideoInterfaceDelegate <NSObject>
@optional
/*
*	These callbacks aren't guaranteed to be on the main queue
*	It is up to the object that implements these to make sure the current queue/thread is used.
*	If UI shit is done, make sure it is on the main thread.
*/
- (void)videoInterfaceStartedVideoCapture:(VideoInterface *)interface;
- (void)videoInterfaceStoppedVideoCapture:(VideoInterface *)interface;
- (void)videoInterface:(VideoInterface *)videoInterface didFinishRecordingToURL:(NSURL *)filePathURL withError:(NSError *)error;
- (void)videoInterfaceCaptureDeviceErrorOccurred:(VideoInterface *)interface;
- (void)videoInterfaceCaptureInputErrorOccurred:(VideoInterface *)interface;
- (void)videoInterfaceFileOutputErrorOccurred:(VideoInterface *)interface;
@end
