//
//  MazeLayer.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MazeLayer.h"


@implementation MazeLayer



-(id)init {
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
        
        [self initTileMap];
        [self scheduleUpdate];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CCC_human.plist"];
        _actors = [CCSpriteBatchNode batchNodeWithFile:@"C.png"];
        [_actors.texture setAliasTexParameters];
        [self addChild:_actors z:-5];
        [self initHuman];
    }
    return self;
}
-(void)update:(ccTime)dt {
    [_human update:dt];
//    [self checkForAndResolveCollisions:_human];

    [self updatePositions];
    [self setViewpointCenter:_human.position];
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

-(void)updatePositions {
    float posX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - _human.centerToSides, MAX(_human.centerToSides, _human.desiredPosition.x));
    float posY = MIN(3 * _tileMap.tileSize.height + _human.centerToBottom, MAX(_human.centerToBottom, _human.desiredPosition.y));
    _human.position = ccp(posX, posY);
}

//- (CGPoint)tileCoordForPosition:(CGPoint)position {
//    float x = floor(position.x / _tileMap.tileSize.width);
//    float levelHeightInPixels = _tileMap.mapSize.height * _tileMap.tileSize.height;
//    float y = floor((levelHeightInPixels - position.y) / _tileMap.tileSize.height);
//    return ccp(x, y);
//}
//
//-(CGRect)tileRectFromTileCoords:(CGPoint)tileCoords {
//    float levelHeightInPixels = _tileMap.mapSize.height * _tileMap.tileSize.height;
//    CGPoint origin = ccp(tileCoords.x * _tileMap.tileSize.width, levelHeightInPixels - ((tileCoords.y + 1) * _tileMap.tileSize.height));
//    return CGRectMake(origin.x, origin.y, _tileMap.tileSize.width, _tileMap.tileSize.height);
//}
//
//- (BOOL)isValidTileCoord:(CGPoint)tileCoord {
//    if (tileCoord.x < 0 || tileCoord.y < 0 ||
//        tileCoord.x >= _tileMap.mapSize.width ||
//        tileCoord.y >= _tileMap.mapSize.height) {
//        return FALSE;
//    } else {
//        return TRUE;
//    }
//}
//
////- (CGPoint)tileCoordForPosition:(CGPoint)position {
//    NSLog(@"get tiles");
//    int x = position.x / _tileMap.tileSize.width;
//    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
//    return ccp(x, y);
//}
//
//- (CGPoint)positionForTileCoord:(CGPoint)tileCoord {
//    int x = (tileCoord.x * _tileMap.tileSize.width) + _tileMap.tileSize.width/2;
//    int y = (_tileMap.mapSize.height * _tileMap.tileSize.height) - (tileCoord.y * _tileMap.tileSize.height) - _tileMap.tileSize.height/2;
//    return ccp(x, y);
//}
//
//-(NSArray *)getSurroundingTilesAtPosition:(CGPoint)position forLayer:(CCTMXLayer *)layer {
//    NSLog(@"get surrounding");
//    CGPoint plPos = [self tileCoordForPosition:position]; //1
//    
//    NSMutableArray *gids = [NSMutableArray array]; //2
//    
//    for (int i = 0; i < 9; i++) { //3
//        int c = i % 3;
//        int r = (int)(i / 3);
//        CGPoint tilePos = ccp(plPos.x + (c - 1), plPos.y + (r - 1));
//        
//        if (tilePos.y < (_tileMap.mapSize.height - 1)) {
//            NSLog(@"fallen in hole");
//        } else {
//            NSLog(@"here");
//        int tgid = [layer tileGIDAt:tilePos]; //4
//        
//        CGRect tileRect = [self tileRectFromTileCoords:tilePos]; //5
//        
//        NSDictionary *tileDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                  [NSNumber numberWithInt:tgid], @"gid",
//                                  [NSNumber numberWithFloat:tileRect.origin.x], @"x",
//                                  [NSNumber numberWithFloat:tileRect.origin.y], @"y",
//                                  [NSValue valueWithCGPoint:tilePos],@"tilePos",
//                                  nil];
//        [gids addObject:tileDict]; //6
////            [gids removeObjectAtIndex:4]; //7
////            [gids insertObject:[gids objectAtIndex:2] atIndex:6];
////            [gids removeObjectAtIndex:2];
////            [gids exchangeObjectAtIndex:4 withObjectAtIndex:6];
////            [gids exchangeObjectAtIndex:0 withObjectAtIndex:4];
//        
//    }
//    
//   
//    }
//    return (NSArray *)gids;
//    
//}

//-(void)checkForAndResolveCollisions:(HumanC *)p {
//    
//    NSArray *tiles = [self getSurroundingTilesAtPosition:p.position forLayer:_obstacles ]; //1
////    if (gameOver) {
////        return;
////    }
//    p.onGround = NO;
//    
//    for (NSDictionary *dic in tiles) {
//        CGRect pRect = p.boundingBox;
//        
//        
//        int gid = [[dic objectForKey:@"gid"] intValue]; //4
//        
//        if (gid) {
//            CGRect tileRect = CGRectMake([[dic objectForKey:@"x"] floatValue], [[dic objectForKey:@"y"] floatValue], _tileMap.tileSize.width, _tileMap.tileSize.height); //5
//            if (CGRectIntersectsRect(pRect, tileRect)) {
//                CGRect intersection = CGRectIntersection(pRect, tileRect);
//                int tileIndx = [tiles indexOfObject:dic];
//                
//                if (tileIndx == 0) {
//                    //tile is directly below player
//                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y + intersection.size.height);
//                    p.velocity = ccp(p.velocity.x, 0.0);
//                    p.onGround = YES;
//                } else if (tileIndx == 1) {
//                    //tile is directly above player
//                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y - intersection.size.height);
//                    p.velocity = ccp(p.velocity.x, 0.0);
//                } else if (tileIndx == 2) {
//                    //tile is left of player
//                    p.desiredPosition = ccp(p.desiredPosition.x + intersection.size.width, p.desiredPosition.y);
//                } else if (tileIndx == 3) {
//                    //tile is right of player
//                    p.desiredPosition = ccp(p.desiredPosition.x - intersection.size.width, p.desiredPosition.y);
//                } else {
//                    if (intersection.size.width > intersection.size.height) {
//                        //tile is diagonal, but resolving collision vertially
//                        p.velocity = ccp(p.velocity.x, 0.0);
//                        float resolutionHeight;
//                        if (tileIndx > 5) {
//                            resolutionHeight = -intersection.size.height;
//                            p.onGround = YES;
//                        } else {
//                            resolutionHeight = intersection.size.height;
//                        }
//                        
//                        p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y + resolutionHeight );
//                        
//                    } else {
//                        float resolutionWidth;
//                        if (tileIndx == 6 || tileIndx == 4) {
//                            resolutionWidth = intersection.size.width;
//                        } else {
//                            resolutionWidth = -intersection.size.width;
//                        }
//                        p.desiredPosition = ccp(p.desiredPosition.x + resolutionWidth , p.desiredPosition.y);
//                        
//                    }
//                }
//            }
//        }
//    }
//    p.position = p.desiredPosition; //8
//}


-(void)dealloc {
    [self unscheduleUpdate];
}

-(void)initHuman {
    _human = [HumanC node];
    [_actors addChild:_human];
    _human.position = ccp(_human.centerToSides+100, 500);
    _human.desiredPosition = _human.position;
    [_human idle];
}

//-(void)initObstacles
//{
//    int ObstacleCount = _collisionArray.count;
//    self.collisions = [[CCArray alloc] initWithCapacity:ObstacleCount];
//    
//    for (int i = 0; i < ObstacleCount; i++)
//    {
//        Obstacles *collision = [Obstacles node];
//        
//        
//        [_actors addChild:collision];
//        [_collisions addObject:collision];
//        
//        
//        collision.position = ;
//        collision.desiredPosition = robot.position;
//        [robot idle];
//    }
//}

-(void)initObstacles
{
//    <object x="1120" y="449" width="193" height="95"/>
//    <object x="863" y="447" width="192" height="97"/>
    
    Obstacles *collision = [Obstacles node];
    Obstacles *collision2 = [Obstacles node];
    
    
    collision.position = ccp(1120, 449);
    
    collision2.position = ccp(863, 447);
    [_collisions addObject:collision2];
    [_collisions addObject:collision];
}

-(void)initTileMap {
    _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"prac_map.tmx"];
    for (CCTMXLayer *child in [_tileMap children]) {
        [[child texture] setAliasTexParameters];
    }
    _obstacles = [_tileMap layerNamed:@"back"];
    CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"collisions"];
    _collisionArray = [objects objects];
    
    
    
    [self addChild:_tileMap z:-6];
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_human superPower];
    
    if (_human.actionState == kActionStateWalk)
    {
        Obstacles *robot;
        CCARRAY_FOREACH(_collisions, robot)
        {
                if (fabsf(_human.position.y - robot.position.y) < 10)
                {
                    if (CGRectIntersectsRect(_human.attackBox.actual, robot.hitBox.actual))
                    {
                        [robot hurtWithDamage:_hero.damage];
                    }
                }
            }
        }
    }
}


-(void)DirectionPad:(DirectionPad *)DirectionPad didChangeDirectionTo:(CGPoint)direction {
    [_human walkWithDirection:direction];
}
-(void)DirectionPadTouchEnded:(DirectionPad *)DirectionPad {
    if (_human.actionState ==kActionStateWalk) {
        [_human idle];
    }
}

-(void)DirectionPad:(DirectionPad *)DirectionPad isHoldingDirection:(CGPoint)direction {
    [_human walkWithDirection:direction];
}
@end
