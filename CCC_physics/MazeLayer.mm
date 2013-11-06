

#import "MazeLayer.h"
#import "SimpleAudioEngine.h"

@interface MazeLayer(Private)
-(void) setupPhysicsWorld;
@end

@implementation MazeLayer



+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	MazeLayer *layer = [MazeLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}


- (void) makeBox2dObjAt:(CGPoint)p
			   withSize:(CGPoint)size
				dynamic:(BOOL)d
			   rotation:(long)r
			   friction:(long)f
				density:(long)dens
			restitution:(long)rest
				  boxId:(int)boxId
               uniqueID:(int)uniqueID                  {
    
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
    //	bodyDef.angle = r;
    
	if(d)
		bodyDef.type = b2_dynamicBody;
    
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    if (uniqueID == 1) {
        GameObject *platform = [[GameObject alloc] init];
        [platform setType:kGameObjectPlatform];
        bodyDef.userData = platform;
    }
    if (uniqueID == 2) {
        GameObject *gameOverTile= [[GameObject alloc] init];
        [gameOverTile setType:kGameObjectGameOverTile];
        bodyDef.userData = gameOverTile;
        NSLog(@"done creating game over tile");
    }
    if (uniqueID == 3) {
        GameObject *endTile= [[GameObject alloc] init];
        [endTile setType:kGameObjectEndTile];
        bodyDef.userData = endTile;
        NSLog(@"done creating game over tile");
    }
    
	b2Body *body = world->CreateBody(&bodyDef);
    
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(size.x/2/PTM_RATIO, size.y/2/PTM_RATIO);
    
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = dens;
	fixtureDef.friction = f;
	fixtureDef.restitution = rest;
	body->CreateFixture(&fixtureDef);
}



- (void) drawCollisionTiles {
	CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"collisions"];
	NSMutableDictionary * objPoint;
    
	int x, y, w, h;
	for (objPoint in [objects objects]) {
        NSLog(@"collision objects detected");
		x = [[objPoint valueForKey:@"x"] intValue]/2;
		y = [[objPoint valueForKey:@"y"] intValue]/2;
		w = [[objPoint valueForKey:@"width"] intValue]/2;
		h = [[objPoint valueForKey:@"height"] intValue]/2;
        
		CGPoint _point=ccp(x+w/2,y+h);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:false
					rotation:0
					friction:1.5f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    uniqueID:1];
	}
}

- (void) drawGameOverTiles {
	CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"gameOverLayer"];
	NSMutableDictionary * objPoint;
    
	int x, y, w, h;
	for (objPoint in [objects objects]) {
        NSLog(@"game over objects detected");
		x = [[objPoint valueForKey:@"x"] intValue]/2;
		y = [[objPoint valueForKey:@"y"] intValue]/2;
		w = [[objPoint valueForKey:@"width"] intValue]/2;
		h = [[objPoint valueForKey:@"height"] intValue]/2;
        
		CGPoint _point=ccp(x+w/2,y+h);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:false
					rotation:0
					friction:1.5f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    uniqueID:2];
	}
}
- (void) drawEndTiles {
	CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"end"];
	NSMutableDictionary * objPoint;
    
	int x, y, w, h;
	for (objPoint in [objects objects]) {
        NSLog(@"end objects detected");
		x = [[objPoint valueForKey:@"x"] intValue]/2;
		y = [[objPoint valueForKey:@"y"] intValue]/2;
		w = [[objPoint valueForKey:@"width"] intValue]/2;
		h = [[objPoint valueForKey:@"height"] intValue]/2;
        
		CGPoint _point=ccp(x+w/2,y+h);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:false
					rotation:0
					friction:1.5f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    uniqueID:3];
	}
}


-(void) setupPhysicsWorld {
    
    b2Vec2 gravity = b2Vec2(0.0f, -9.8f);
    world = new b2World(gravity);

    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
}


-(void)initTileMap {
   
    _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"test_map.tmx"];
    _tileMap.scale = .5;
	_tileMap.anchorPoint = ccp(0, 0);
	[self addChild:_tileMap];
}


-(void)initCaptain {
    
    NSLog(@"initizaling captain");
    player = [Captain spriteWithSpriteFrameName:@"Lat Capt Human-Standing0001.png"];
    
    NSLog(@"init human");
    [humanSpriteSheet addChild:player];

    player.scale = 0.7;
    player.position = ccp(100, 400);
    [player createBox2dObject:world];
    //[self addChild:player];
    [player idle];

}


//-(void) initMenu {
//    CCMenuItem *kangarooItem = [CCMenuItemImage
//                                itemFromNormalImage:@"KangarooIcon.png"
//                                selectedImage:@"KangarooIcon.png"
//                                target:self selector:@selector(kangarooButtonTapped:)];
//    CCMenu *menu= [CCMenu menuWithItems:kangarooItem, nil];
//    menu.position = ccp(500, 300);
//    [self addChild: menu z:100];
//}
//
//-(void)kangarooButtonTapped:(id) sender{
//    NSLog(@"kangaroo selected");
//    //Superpower *power = [Superpower init];
//    //    _human.superPowerAction = power.superpowerAction;
//    [player superPower];
//}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;

    
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    firstTouch = location;
    if (location.x <=screenSize.width && location.y >= 150) {
        [player walk];
    }
    if (location.x <= screenSize.width && location.y < 150) {
        //player.position = ccp(player.position.x, player.position.y-50);
        [player crawl];
        ;

    }
    // [player jump];
    
	return TRUE;
}



-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (player.actionState ==kActionStateWalk) {
        [player idle];
    }
    NSSet *allTouches = [event allTouches];
        UITouch * currentTouch = [[allTouches allObjects] objectAtIndex:0];
        CGPoint location = [currentTouch locationInView: [currentTouch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
    
        //Swipe Detection Part 2
        lastTouch = location;
    
        //Minimum length of the swipe
        float swipeLength = ccpDistance(firstTouch, lastTouch);
    
        //Check if the swipe is a left swipe and long enough
        if (firstTouch.x > lastTouch.x && swipeLength > 60) {
        [player crawl];
        }
}



-(id)init {
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

        [self setupPhysicsWorld];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"sbm.mp3"];
        [self initTileMap];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CCC_first.plist"];
        
        humanSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"CCC_first.png"];
        [humanSpriteSheet.texture setAliasTexParameters];
        [self addChild:humanSpriteSheet];
        [self drawCollisionTiles];
        [self initCaptain];
//        [self initMenu];
        // just added this in here brah
        [self drawGameOverTiles];
        [self drawEndTiles];
        [self scheduleUpdate];

    }
    return self;
}
-(void)update:(ccTime)dt {
//    [player update:dt];
//    float posX = MAX(_tileMap.mapSize.width * _tileMap.tileSize.width - player.centerToSides, MAX(player.centerToSides, player.desiredPosition.x));
//    float posY = MAX(3 * _tileMap.tileSize.height + player.centerToBottom, MAX(player.centerToBottom, player.desiredPosition.y));
//    player.position = ccp(posX, posY);
//

    
    int32 velocityIterations = 8;
	int32 positionIterations = 1;
    
    
	
    
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext()) {
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO,
										   b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}
	}
	
	b2Vec2 pos = [player body]->GetPosition();
  
	CGPoint newPos = ccp(-1* pos.x * PTM_RATIO + 50, self.position.y * PTM_RATIO);
	[self setPosition:newPos];
   // [self setViewpointCenter:player.position];

}


- (Captain*) getPlayer{
    return player;
}


-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width)
            - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height)
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
}



-(void)dealloc {
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    [self unscheduleUpdate];
}

@end
