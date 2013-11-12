//
//  HudLayer.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"
#import "Captain.h"




@implementation HudLayer


-(id) init
{
    self = [super init];
    
    if(self)
    {
        // choose energy bar image
        energyBar = [CCSprite spriteWithFile:@"energyBar_05.png"];
        [self addChild:energyBar];
        CCLOG(@"added energy bar");
//        NSString* newSprite = [NSString stringWithFormat:@"energyBar_0%d.png", 5];
//        CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        [energyBar setDisplayFrame:[cache spriteFrameByName:newSprite]];
//        CCLOG(@"added energy bar initial");
        energyBar.zOrder = 10000;
//        energyBar.position = ccp(0,0);
        energyBar.position = ccp(50,300);
        energyBar.scale = .5;
//        // cache sprite frames for the digits
//        CCSpriteFrameCache *sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
//        for(int i=0; i<10; i++)
//        {
//            digitFrame[i] = [sfc spriteFrameByName:
//                             [NSString stringWithFormat:@"numbers/%d.png", i]];
//        }
//        
//        // init digit sprites
//        for(int i=0; i<MAX_DIGITS; i++)
//        {
//            digits[i] = [CCSprite spriteWithSpriteFrame:digitFrame[0]];
//            digits[i].position = ccp(345+i*25, 290);
//            [self addChild:digits[i]];
//        }
    }
    
    return self;
}

-(void) setHealth:(int) health
{
    // 1 - Change current health
    currentHealth = health;
    CCLOG(@"setHealth");
//    NSString* newSprite = [NSString stringWithFormat:@"energyBar_0%d.png", currentHealth];
    NSLog(@"%d", currentHealth);
//    CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
//    [energyBar setDisplayFrame:[cache spriteFrameByName:newSprite]];
}
@end
