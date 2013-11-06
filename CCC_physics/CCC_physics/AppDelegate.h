//
//  AppDelegate.h
//  CCC_physics
//
//  Created by Ann Niou on 11/1/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneManager.h"
@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;



@property (nonatomic, assign) BOOL iPad;



@end
