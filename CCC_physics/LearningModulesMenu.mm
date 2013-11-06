//
//  LearningModulesMenu.m
//  CCC_physics
//
//  Created by Ann Niou on 11/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LearningModulesMenu.h"


@implementation LearningModulesMenu
@synthesize iPad;

- (void)onHome: (id) sender {
    [SceneManager goMainMenu];
}

- (void)addBackButton {
    
    if (self.iPad) {
        // Create a menu image button for iPad
        CCMenuItemImage *goHome = [CCMenuItemImage itemFromNormalImage:@"Home icon.png"
                                                         selectedImage:@"Home icon.png"
                                                                target:self
                                                              selector:@selector(onHome:)];
        // Add menu image to menu
        CCMenu *home = [CCMenu menuWithItems: goHome, nil];
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        home.position = ccp(screenSize.width/2, screenSize.height/3);
        
        // Add menu to this scene
        [self addChild: home];
    }
    else {
        // Create a menu image button for iPhone / iPod Touch
        CCMenuItemImage *goHome = [CCMenuItemImage itemFromNormalImage:@"Home icon.png"
                                                         selectedImage:@"Home icon.png"
                                                                target:self
                                                              selector:@selector(onHome:)];
        goHome.scale = .6;
        // Add menu image to menu
        CCMenu *home = [CCMenu menuWithItems: goHome, nil];
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        home.position = ccp(screenSize.width/2, screenSize.height/3);
        
        // Add menu to this scene
        [self addChild: home];
        
    }
}

- (id)init {
    
    if( (self=[super init])) {
        
        // Determine Device
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        // Calculate Large Font Size
        int largeFont = screenSize.height / kFontScaleLarge;
        
        // Create a label
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Learning Modules"
                                               fontName:@"Marker Felt"
                                               fontSize:largeFont];
		// Center label
		label.position = ccp( screenSize.width/2, screenSize.height/2);
        
        // Add label to this scene
		[self addChild:label z:0];
        
        //  Put a 'back' button in the scene
        [self addBackButton];
        
    }
    return self;
}
@end