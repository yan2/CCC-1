//
//  GameOverLayer.m
//  CCC_physics
//
//  Created by guest user on 11/6/13.
//
//

#import "GameOverLayer.h"

@implementation GameOverLayer
@synthesize iPad;

- (void)onHome: (id) sender {
    [SceneManager goMainMenu];
}
//
//
//- (void)addBackButton {
//         // Create a menu image button for iPhone / iPod Touch
//        CCMenuItemImage *goHome = [CCMenuItemImage itemFromNormalImage:@"Home icon.png"
//                                                         selectedImage:@"Home icon.png"
//                                                                target:self
//                                                              selector:@selector(onHome:)];
//        // Add menu image to menu
//        CCMenu *home = [CCMenu menuWithItems: goHome, nil];
//        // Determine Screen Size
//        CGSize screenSize = [CCDirector sharedDirector].winSize;
//        // position menu in the bottom left of the screen (0,0 starts bottom left)
//        home.position = ccp(screenSize.width/2, screenSize.height/3);
//        
//        // Add menu to this scene
//        [self addChild: home];
//        
//    
//}
- (void)onReplay: (id) sender {
    [SceneManager goGameScene];
}
- (id)init {
    
    if( (self=[super init])) {
        
        // Determine Device
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        // Calculate Large Font Size
        int largeFont = screenSize.height / 12;
        
        // Create a label
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over!"
                                               fontName:@"Marker Felt"
                                               fontSize:largeFont];
		// Center label
		label.position = ccp( screenSize.width/2, screenSize.height/3*2);
        
        // Add label to this scene
		[self addChild:label z:0];
        
        // Set font settings
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:30];
        
        // Create font based items ready for CCMenu
        CCMenuItemFont *item1 = [CCMenuItemFont itemFromString:@"Replay" target:self selector:@selector(onReplay:)];
        CCMenuItemImage *goHome = [CCMenuItemImage itemFromNormalImage:@"Home icon.png"
                            selectedImage:@"Home icon.png"
                           target:self
                           selector:@selector(onHome:)];
        goHome.scale = .5;
                CCMenu *menu = [CCMenu menuWithItems:item1,goHome, nil];
        
        // Align the menu
        [menu alignItemsVertically];
        menu.position = ccp(screenSize.width/2,screenSize.height/2-20);
        // Add the menu to the scene
        [self addChild:menu];
        //  Put a 'back' button in the scene
//        [self addBackButton];
        
    }
    return self;
}

@end
