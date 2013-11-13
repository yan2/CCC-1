//
//  IconDrawer.m
//  CCC_physics
//
//  Created by Ann Niou on 11/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "IconDrawer.h"


@implementation IconDrawer

-(id)init {
//
//    if (self = [super initWithSpriteFrameName:@"Lat Capt Human-Standing0001.png"]){
//        //if ((self = [super initWithSpriteFrameName:@"Lat Capt Human-Standing0001.png"])) {
//        CCLOG(@"init superpower icon drawer");
//        
//        
//        self.superPowerAction = [CCSequence actions:[CCAnimate actionWithAnimation: [self SuperpowerAnimation]], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
//        //
//        //Set some initial values for the hero’s attributes, including the measurements from the center of the sprite to the sides and bottom
//        self.centerToBottom = 39.0;
//        self.centerToSides = 29.0;
//        self.hitPoints = 100.0;
//        self.damage = 20.0;
//        self.walkSpeed = 80;
//        
//        
//        // }
//    }
//    NSLog(@"captain init but without frame");
    return self;
}

-(void)showMyCocos2DDrawer
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    self.position = ccp(-s.width,0.0f);  //do this in ur init method :)
    
    CGPoint pos =ccp(0.0f, 0.0f );
    
    id moveTo = [CCMoveTo actionWithDuration:0.5f position:pos];
    id calFun = [CCCallFunc actionWithTarget:self selector:@selector(animDone)];
    id seq    = [CCSequence actions:moveTo, calFun, nil];
    
    [self runAction:seq];
}



-(void)hideCocos2DDrawer
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    CGPoint pos =ccp(-s.width, 0.0f);
    
    id moveTo = [CCMoveTo actionWithDuration:0.3f position:pos];
    id calFun = [CCCallFunc actionWithTarget:self selector:@selector(goBack)];
    id seq    = [CCSequence actions:moveTo, calFun, nil];
    
    [self runAction:seq];
}

-(void) animDone
{
    //write in code here..
}

-(void)goBack
{
    //write out code here..
}
@end
