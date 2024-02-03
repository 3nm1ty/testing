#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

#define NSLog(fmt, ... ) NSLog((@"K2gecamen | " fmt), ## __VA_ARGS__);

static UIViewController *  _topMostController(UIViewController * cont) {
	UIViewController *topController = cont;
	while (topController.presentedViewController) {
		topController = topController.presentedViewController;
	}
	if ([topController isKindOfClass:[UINavigationController class]]) {
		UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
		if (visible) {
			topController = visible;
		}
	}
	return (topController != cont ? topController : nil);
}

static UIViewController *  topMostController() {
	UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
	UIViewController *next = nil;
	while ((next = _topMostController(topController)) != nil) {
		topController = next;
	}
	return topController;
}

static void alert(NSString* title, NSString *message) {
	UIAlertController *alertView = [UIAlertController
	                                alertControllerWithTitle:title
	                                message:message
	                                preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmButton = [UIAlertAction
	                                actionWithTitle:@"OK"
	                                style:UIAlertActionStyleDefault
	                                handler:nil];

	[alertView addAction:confirmButton];

	// UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
	[topMostController() presentViewController:alertView animated:YES completion:nil];
}

static void alertWithCompletion(NSString* title, NSString *message, void (^completion)(UIAlertAction *action)) {
	UIAlertController *alertView = [UIAlertController
	                                alertControllerWithTitle:title
	                                message:message
	                                preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmButton = [UIAlertAction
	                                actionWithTitle:@"OK"
	                                style:UIAlertActionStyleDefault
	                                handler:completion];

	[alertView addAction:confirmButton];

	// UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
	[topMostController() presentViewController:alertView animated:YES completion:nil];
}

static void confirm(NSString* title, NSString *message, void (^origFunc)(UIAlertAction *action)) {
	UIAlertController *alertView = [UIAlertController
	                                alertControllerWithTitle:title
	                                message:message
	                                preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *okButton = [UIAlertAction
	                           actionWithTitle:@"OK"
	                           style:UIAlertActionStyleDefault
	                           handler:origFunc];
	UIAlertAction *cancelButton = [UIAlertAction
	                               actionWithTitle:@"Cancel"
	                               style:UIAlertActionStyleDefault
	                               handler:nil];

	[alertView addAction:okButton];
	[alertView addAction:cancelButton];

	// UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
	[topMostController() presentViewController:alertView animated:YES completion:nil];
}


#include <objc/message.h>
// #include <substrate.h>
// @import ObjectiveC.message;

#define objcInvokeT(a, b, t) ((t (*)(id, SEL)) objc_msgSend)(a, NSSelectorFromString(b))
#define objcInvoke(a, b) objcInvokeT(a, b, id)
#define objcInvoke_1(a, b, c) ((id (*)(id, SEL, typeof(c))) objc_msgSend)(a, NSSelectorFromString(b), c)
#define objcInvoke_2(a, b, c, d) ((id (*)(id, SEL, typeof(c), typeof(d))) objc_msgSend)(a, NSSelectorFromString(b), c, d)
#define objcInvoke_3(a, b, c, d, e) ((id (*)(id, SEL, typeof(c), typeof(d), typeof(e))) objc_msgSend)(a, NSSelectorFromString(b), c, d, e)
#define objcInvoke_5(a, b, c, d, e, f, g) ((id (*)(id, SEL, typeof(c), typeof(d), typeof(e),typeof(f),typeof(g))) objc_msgSend)(a, NSSelectorFromString(b), c, d, e,f,g)

@interface MFSwitch: UISwitch
{
	NSString* key;
}
@property (nonatomic, readwrite, retain) NSString* key;
@end

#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^
