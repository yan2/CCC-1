//
//  MazeLayer.h
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "HumanC.h"
//#import "DirectionPad.h"
#import "HudLayer.h"
//#import "Obstacles.h"


@interface MazeLayer : CCLayer <DirectionPadDelegate>{
    CCTMXTiledMap *_tileMap;
    CCSpriteBatchNode *_actors;
//    HumanC *_human;
    CCTMXLayer *_obstacles;
    NSMutableDictionary    *_objects;
    NSMutableArray *_collisionArray;
}

-(CGRect)collisionBoundingBox;

@property(nonatomic)HudLayer *hud;
@property(nonatomic)CCArray *collisions;



@end
