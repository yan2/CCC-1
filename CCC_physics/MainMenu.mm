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
        CCMenuItemFont *item1 = [CCMenuItemFont itemFromString:@"Play" target:self selector:@selector(onPlay:)];
        CCMenuItemFont *item2 = [CCMenuItemFont itemFromString:@"Learning Modules" target:self selector:@selector(onLearningModules:)];
        CCMenuItemFont *item3 = [CCMenuItemFont itemFromString:@"Options" target:self selector:@selector(onOptions:)];

        // Add font based items to CCMenu
        CCMenu *menu = [CCMenu menuWithItems:item1, item2, item3, nil];

        // Align the menu 
        [menu alignItemsVertically];

        // Add the menu to the scene
        [self addChild:menu];
        
        // Testing GameData
        
        GameData *gameData = [GameDataParser loadData];

        CCLOG(@"Read from XML 'Selected Chapter' = %i", gameData.selectedChapter);
        CCLOG(@"Read from XML 'Selected Level' = %i", gameData.selectedLevel);
        CCLOG(@"Read from XML 'Music' = %i", gameData.music);
        CCLOG(@"Read from XML 'Sound' = %i", gameData.sound);
        
        gameData.selectedChapter = 7;
        gameData.selectedLevel = 4;
        gameData.music = 0;
        gameData.sound = 0;
        
        [GameDataParser saveData:gameData];
        
        
        
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;

    }
    return self;
}

@end
