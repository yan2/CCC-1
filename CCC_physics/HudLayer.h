//
//  HudLayer.h
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DirectionPad.h"
//#import "GameScene.h"

#define MAX_HEALTH_TOKENS 10
#define MAX_DIGITS 5

@interface HudLayer : CCLayer {
    CCSprite *healthTokens[MAX_HEALTH_TOKENS]; // weak references
    
    CCSprite *energyBar;
    int currentHealth;
    CCSprite *digits[MAX_DIGITS];  // weak references
    CCSpriteFrame *digitFrame[10]; // weak references
    
    
    
    
}
-(id) init;
-(void) setHealth:(int) health;


-(void) setScore:(float) score;



@end
