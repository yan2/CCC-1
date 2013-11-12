//
//  Player.h
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GameObject.h"
#define MAX_HEALTH 5


@interface Player : GameObject {
    b2Body          *body;
    BOOL            contactingGameOver;
    int health;

}


@property (readonly) int health;
@property (readonly) bool isDead;
-(void) createBox2dObject:(b2World*)world;
-(void) kangarooJump;
-(void) moveRight;
-(void) updateHealth;
@property (nonatomic, readwrite) b2Body *body;
@property bool contactingGameOver;


-(void)restoreHealth:(float)amount;



@end
