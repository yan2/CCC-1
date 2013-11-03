//
//  GameScene.m
//  

#import "GameScene.h" 
#import "GameData.h"
#import "GameDataParser.h"
#import "LevelParser.h"
#import "Levels.h"
#import "Level.h"


@implementation GameScene  
@synthesize iPad, device;

//- (void) setupPhysicsWorld {
//    
//    b2Vec2 gravity = b2Vec2(kHorizontalGravity, kVerticalGravity); // Set in TRBox2DConstants.h
////    bool doSleep = true;
//
//    world = new b2World(gravity);
//    
//}
//- (void) limitWorldToScreen {
//    
//    CGSize screenSize = [CCDirector sharedDirector].winSize;
//    TRBox2D *limits = [[[TRBox2D alloc] init] autorelease];
//    [limits createEdgesForWorld:world fromScreenSize:screenSize];
//    [self addChild:limits];
//}
- (void)tick: (ccTime) dt {
    
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
    
//	int32 velocityIterations = 8;
//	int32 positionIterations = 1;
//    
//	// Instruct the world to perform a single step of simulation. It is
//	// generally best to keep the time step and iterations fixed.
//	world->Step(dt, velocityIterations, positionIterations);
//    
//	//Iterate over the bodies in the physics world
//	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
//	{
//		if (b->GetUserData() != NULL) {
//			//Synchronize the AtlasSprites position and rotation with the corresponding body
//			CCSprite *myActor = (CCSprite*)b->GetUserData();
//			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
//			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
//		}
//	}
}



- (void)onBack: (id) sender {
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
        
//        int selectedChapter = gameData.selectedChapter;
        int selectedLevel = gameData.selectedLevel;
        
        Levels *levels = [LevelParser loadLevelsForChapter:1];
        
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

        [self createScene];
//        [self setupPhysicsWorld];
//        [self limitWorldToScreen];
        
        // schedule Box2D updates
//        [self schedule: @selector(tick:)];

    }
    return self;
}


-(void) createScene {
    
    _mazeLayer = [MazeLayer node];
    [self addChild:_mazeLayer z:0];
    _hudLayer = [HudLayer node];
    [self addChild:_hudLayer z:1];
    
    _hudLayer.dPad.delegate = _mazeLayer;
    _mazeLayer.hud = _hudLayer;
    
}
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


@end
