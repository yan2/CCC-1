//
//  MainMenu.m
//

#import "MainMenu.h"
#import "GameData.h"
#import "GameDataParser.h"

@implementation MainMenu
@synthesize iPad;

- (void)onPlay: (id) sender {
    [SceneManager goLevelSelect];
}

- (void)onOptions: (id) sender {
    [SceneManager goOptionsMenu];
}

- (void)onLearningModules: (id) sender {
    //    [SceneManager goLearningModulesMenu];
    [SceneManager goLearningModulesMenu];
}

- (void)addBackButton {
    
    if (self.iPad) {
        // Create a menu image button for iPad
        CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:@"Arrow-Normal-iPad.png"
                                                         selectedImage:@"Arrow-Selected-iPad.png"
                                                                target:self
                                                              selector:@selector(onBack:)];
        // Add menu image to menu
        CCMenu *back = [CCMenu menuWithItems: goBack, nil];
        
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        back.position = ccp(64, 64);
        
        // Add menu to this scene
        [self addChild: back];
    }
    else {
        // Create a menu image button for iPhone / iPod Touch
        CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:@"Back Arrow.png"
                                                         selectedImage:@"Back Arrow.png"
                                                                target:self
                                                              selector:@selector(onBack:)];
        goBack.scale = .5;
        // Add menu image to menu
        CCMenu *back = [CCMenu menuWithItems: goBack, nil];
        
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        back.position = ccp(32, 32);
        
        // Add menu to this scene
        [self addChild: back];
    }
}

- (id)init {
    
    if( (self=[super init])) {
        
        // Determine Device
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        // Calculate Large Font Size
        int smallFont = screenSize.height / kFontScaleSmall;
        
        // Set font settings
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:smallFont];
        
        // Create font based items ready for CCMenu
        
        //        CCSprite *explore = [CCSprite spriteWithFile:@"explore.png"];
        //        CCMenuItemImage *ex = [CCMenuItemImage itemFromNormalSprite:explore selectedSprite:explore target:self selector:@selector(onPlay:)];
        //        ex.scale = .5;
        //        CCMenu *menu = [CCMenu menuWithItems:ex, nil];
        //        [self addChild:menu];
        CCMenuItemImage *learn = [CCMenuItemImage itemFromNormalImage:@"learn.png"
                                                        selectedImage:@"learn.png"
                                                               target:self
                                                             selector:@selector(onLearningModules:)];
        learn.scale = .5;
        //        learn.position = ccp(screenSize.width/2, screenSize.height/2);
        
        learn.zOrder = -50;
        CCMenu *learnMenu = [CCMenu menuWithItems: learn, nil];
        [self addChild:learnMenu];
        
        CCMenuItemImage *explore = [CCMenuItemImage itemFromNormalImage:@"explore.png"
                                                          selectedImage:@"explore.png"
                                                                 target:self
                                                               selector:@selector(onPlay:)];
        //        explore.position = ccp(screenSize.width/2, screenSize.height/2);
        
        explore.zOrder = -50;
        CCMenu *exploreMenu = [CCMenu menuWithItems: explore, nil];
        [self addChild:exploreMenu];
        
        explore.scale = .5;
        //        CCSprite *learn = [CCSprite spriteWithFile:@"learn.png"];
        //        CCMenuItemImage *LM = [CCMenuItemImage itemFromNormalSprite:learn selectedSprite:learn target:self selector:@selector(onLearningModules:)];
        //        LM.scale = .5;
        //        CCMenu *LMMenu = [CCMenu menuWithItems:LM, nil];
        //        [self addChild:LMMenu];
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"mainBackground.jpg"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        background.scale = .5;
        background.zOrder = -100;
        [self addChild:background];
        
        // Testing GameData
        
        GameData *gameData = [GameDataParser loadData];
        
        CCLOG(@"Read from XML 'Selected Chapter' = %i", gameData.selectedChapter);
        CCLOG(@"Read from XML 'Selected Level' = %i", gameData.selectedLevel);
        
        
        gameData.selectedChapter = 7;
        gameData.selectedLevel = 4;
        //        gameData.music = 0;
        //        gameData.sound = 0;
        
        [GameDataParser saveData:gameData];
        
        
        
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
    }
    return self;
}

@end
