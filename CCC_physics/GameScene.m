//
//  GameScene.m
//  

#import "GameScene.h" 
#import "GameData.h"
#import "GameDataParser.h"
#import "LevelParser.h"
#import "Levels.h"
#import "Level.h"
#import "Box2D.h"

@implementation GameScene  
@synthesize iPad, device;


- (void)createCircleAtPoint:(CGPoint)point
                 spriteFile:(NSString*)spriteFile
                   bodyType:(b2BodyType)bodyType {
    
    TRBox2D *circle = [TRBox2D spriteWithFile:spriteFile];
    
    [circle setPosition:point];
    
    [circle createCircleInWorld:world
                         radius:1.0
                       friction:1.0
                    restitution:1.0
                        density:1.0
                     allowSleep:YES
                  fixedRotation:NO
                         bullet:NO
                       isSensor:NO
                     b2bodyType:bodyType
                     objectType:kObjectNone];
    
    [self addChild:circle];
}
- (void)onBack: (id) sender {
    /* 
     This is where you choose where clicking 'back' sends you.
     */
    [SceneManager goLevelSelect];
}

- (void)addBackButton {
    
    NSString *normal = [NSString stringWithFormat:@"Arrow-Normal-%@.png", self.device];
    NSString *selected = [NSString stringWithFormat:@"Arrow-Selected-%@.png", self.device];        
    CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:normal 
                                                     selectedImage:selected
                                                            target:self 
                                                          selector:@selector(onBack:)];
    CCMenu *back = [CCMenu menuWithItems: goBack, nil];
    
    if (self.iPad) {
        back.position = ccp(64, 64);
        
    }
    else {
        back.position = ccp(32, 32);
    }
    
    [self addChild:back];        
}

- (id)init {
    
    if( (self=[super init])) {

        // Determine Device
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        if (self.iPad) {
            self.device = @"iPad";
        }
        else {
            self.device = @"iPhone";
        }
        
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;  
        
        // Calculate Large Font Size
        int largeFont = screenSize.height / kFontScaleLarge; 
        
        
        GameData *gameData = [GameDataParser loadData];
        
        int selectedChapter = gameData.selectedChapter;
        int selectedLevel = gameData.selectedLevel;
        
        Levels *levels = [LevelParser loadLevelsForChapter:selectedChapter];
        
        for (Level *level in levels.levels) {
            if (level.number == selectedLevel) {
                
                NSString *data = [NSString stringWithFormat:@"%@",level.data];
                
                CCLabelTTF *label = [CCLabelTTF labelWithString:data
                                                       fontName:@"Marker Felt" 
                                                       fontSize:largeFont]; 
                label.position = ccp( screenSize.width/2, screenSize.height/2);  
                
                // Add label to this scene
                [self addChild:label z:0]; 
            }
        }
        
        //  Put a 'back' button in the scene
        [self addBackButton];   

    }
    return self;
}

@end
