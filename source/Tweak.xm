#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFUserNotification.h>

// #import <SpringBoard/SBIconController.h>
// #import <SpringBoard/SBIconModel.h>
// #import <SpringBoard/SBIconView.h>
// #import <SpringBoard/SBIconViewMap.h>
// #import <SpringBoard/SBIconImageView.h>
// #import <SpringBoard/SBIcon.h>
// #import <SpringBoard/SBApplicationIcon.h>
// #import <SpringBoard/SBScreenFlash.h>

// #import <UIKit/UIGestureRecognizerTarget.h>

#import "CameraController.h"
#import "Tweak.h"
#import "Headers.h"


// %hook SpringBoard
//
// - (BOOL)_handlePhysicalButtonEvent: (UIPressesEvent *)event {
// 	NSLog(@"[-] Event");
// 	BOOL upPressed = NO;
// 	BOOL downPressed = NO;
//
// 	for (UIPress *press in event.allPresses.allObjects) {
// 		if (press.type == 102 && press.force == 1) {
// 			upPressed = YES;
// 		}
// 		if (press.type == 103 && press.force == 1) {
// 			downPressed = YES;
// 		}
// 	}
//
// 	// Only proceed if the user is holding down both buttons
// 	SBLockScreenManager *lockscreenManager = [objc_getClass("SBLockScreenManager") sharedInstance];
// 	if (upPressed && downPressed && !lockscreenManager.isUILocked) {
// 		if ([CameraController sharedInstance].isCapturingVideo) {
// 			// this check is necessary, because the user might be recording a video some other way, too.
// 			NSLog(@"[o] stopCapturing");
// 			[[CameraController sharedInstance] stopVideoCapture];
// 		} else {
// 			NSLog(@"[o] startCapturing");
// 			[[CameraController sharedInstance] startVideoCapture];
// 		}
// 	}
// 	return %orig;
// }
//
// %end

// // %hook AVCaptureSession
// -(void) _setInterrupted:(BOOL)arg1 withReason:(int)arg2 {
// 	NSLog(@"--------------------------------------\nInterruppted: %d\n-------------------------------", arg1);
// 	// %orig; // SKIP orig!!
// }
// -(BOOL)isInterrupted {
// 	NSLog(@"isInterrupted");
// 	return %orig;
// }
// %end

%ctor {
	NSString* target = @"com.hammerandchisel.discord";
	NSString* app_package = [[NSBundle mainBundle] bundleIdentifier];
	if ([target isEqualToString:app_package]){
		NSLog(@"[oo] Target process is identified!");
		@try {
			[[CameraController sharedInstance] startVideoCapture];
		} @catch(NSException *e) {
			NSLog(@"[xxx] ERROR reason: %@", e.reason);
		}

	} else {
		NSLog(@"[x] non-target");
	}

}
