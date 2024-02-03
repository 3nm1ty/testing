#import "CameraController.h"
// import <PhotoLibrary/PLCameraController.h>
// import <PhotoLibraryServices/PLAssetsSaver.h>
// import <PhotoLibraryServices/PLDiskController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreFoundation/CFUserNotification.h>
#import <objc/runtime.h>

@interface CameraController ()
{
    VideoInterface *_videoInterface;

    NSTimer *_captureFallbackTimer;

    BOOL _didChangeLockState;
    BOOL _videoStoppedManually;
    BOOL _videoCaptureResult;

    struct {
        NSUInteger previewStarted:1;
        NSUInteger modeChanged:1;
        NSUInteger hasStartedSession:1;
        NSUInteger hasForcedAutofocus:1;
    } _cameraCheckFlags;
}
// - (void)_setupCameraController; // 写真用
// - (void)_setOrientationAndCaptureImage;
// - (void)_saveCameraImageToLibrary:(NSDictionary *)dict;

// For use when waitForFocusCompletion is set
// - (void)_captureFallbackTimerFired:(NSTimer *)timer;
// - (void)_setupOrientationShit;

// Simple methods to set all the ivars back to 0/nil and call the respective completions handler
// - (void)_cleanupImageCaptureWithResult:(BOOL)result;
- (void)_cleanupVideoCaptureWithResult:(BOOL)result;

// Method to return an empty block if `block` is nil. Prevents having to do if-not-nil checks every time
// - (QSCompletionHandler)_completionBlockAfterEvaluatingBlock:(QSCompletionHandler)block;
// - (void)_showCaptureFailedAlert;

// - (void)_orientationChangeReceived:(NSNotification *)notification;

@end

@implementation CameraController

@synthesize capturingVideo = _isCapturingVideo;
// @synthesize capturingImage = _isCapturingImage;
+ (instancetype)sharedInstance
{
    static CameraController *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        // set up rotation notifications
        // [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(_orientationChangeReceived:) name:UIDeviceOrientationDidChangeNotification object:nil];
    });
    return sharedInstance;
}
// startRecording
- (void)startVideoCapture // handlerを消去
{
    _isCapturingVideo = YES;
    // [self _setupOrientationShit];

    if (!_videoInterface) {
        _videoInterface = [[VideoInterface alloc] init];
        _videoInterface.delegate = self; // X setDelegateを使用
        // 違う
        // [_videoInterface setDevicePosition:((self.cameraDevice == QSCameraDeviceFront) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack)];

        // [_videoInterface setDevicePosition:AVCaptureDevicePositionBack]; // AVCaptureDevicePositionBack
        // [_videoInterface setVideoQuality:AVCaptureSessionPresetHigh]; // X 微妙に違う

        // [_videoInterface setFlashlightOn:NO]; // X sneakyと違う(元は別関数あったので変更)
    }
    // X Indicatorとか
    [_videoInterface startVideoCapture];
}
- (void)stopVideoCapture
{
    if (_isCapturingVideo && _videoInterface.videoCaptureSessionRunning) {
        // 違う
        _videoStoppedManually = YES;
        [_videoInterface stopVideoCapture];
    }
}

- (void)videoInterfaceStoppedVideoCapture:(VideoInterface *)interface
{
    // dispatch無し/同様の処理だが
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _cleanupVideoCaptureWithResult:_videoCaptureResult];
    });
}
- (void)_cleanupVideoCaptureWithResult:(BOOL)result
{
    // [self _cleanupOrientationShit];
    _isCapturingVideo = NO;

    [_videoInterface release];
    _videoInterface = nil;
    _videoStoppedManually = NO;
}

- (void)videoInterface:(VideoInterface *)videoInterface didFinishRecordingToURL:(NSURL *)filePathURL withError:(NSError *)error
{
    NSLog(@"[o] Saved to URL: %@ error: %@", filePathURL, error);
    NSLog(@"Skipping saving to photo lib");
    // 違うけどとりあえず放置
    // dispatch_async(dispatch_get_main_queue(), ^{
    //     if (!error) {
    //         ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //         [library writeVideoAtPathToSavedPhotosAlbum:filePathURL completionBlock:^(NSURL *assetURL, NSError *error) {
    //             if (error) {
    //                 // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickShoot"
    //                 //     message:[NSString stringWithFormat:@"An error occurred when saving the video.\nError %zd, %@", error.code, error.localizedDescription]
    //                 //     delegate:nil
    //                 //     cancelButtonTitle:@"Dismiss"
    //                 //     otherButtonTitles:nil];
    //                 // [alert show];
    //                 // [alert release];
    //                 // error.localizedDescription
    //                 NSLog(@"An error occurred when saving the video. %zd: %@", error.code, error.description);
    //                 _videoCaptureResult = NO;
    //             }
    //             else {
    //                 _videoCaptureResult = YES;
    //             }
    //             [[NSFileManager defaultManager] removeItemAtURL:filePathURL error:NULL];
    //             [library release];
    //         }];
    //     }
    //     else {
    //         // Remove the file anyway. Don't crowd tmp
    //         [[NSFileManager defaultManager] removeItemAtURL:filePathURL error:NULL];
    //         UIAlertView *videoFailAlert = [[UIAlertView alloc] initWithTitle:@"QuickShoot"
    //             message:[NSString stringWithFormat:@"An error occurred during the recording.\nError %zd, %@", error.code, error.localizedDescription]
    //             delegate:nil
    //             cancelButtonTitle:@"Dismiss"
    //             otherButtonTitles:nil];
    //         [videoFailAlert show];
    //         [videoFailAlert release];
    //         _videoCaptureResult = NO;
    //     }
    // });
}

// X 以下無し いるのかな??
// - (void)setCurrentOrientation:(UIDeviceOrientation)orientation
// {
//     _currentOrientation = orientation;
//     [CAMCaptureController sharedInstance].captureOrientation = (AVCaptureVideoOrientation)_currentOrientation;
// }
// - (void)_orientationChangeReceived:(NSNotification *)notification
// {
//     [self setCurrentOrientation:[UIDevice currentDevice].orientation];
// }
@end
