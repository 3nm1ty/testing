#import <UIKit/UIKit.h>


@interface SBLockScreenManager : NSObject
+ (id)sharedInstance;
- (BOOL)isUILocked;
- (void)unlockUIFromSource:(NSInteger)source withOptions:(id)options;
- (void)_finishUIUnlockFromSource:(NSInteger)source withOptions:(id)options;
@end


// @interface LineServiceManager
// @property NSString* userAgent;
// @property NSString* applicationInfo;
// @end
//
// @interface UID : UIDevice
// @property NSString* hardwareModelName;
// @end
//
// @interface TypedBarItem : UITabBarItem
// @property UIView* skinnedTabBarItem;
// @end
//
// @interface SkinnedTabBarItem : UIView
// @property UIView* tabBarView;
// @end
