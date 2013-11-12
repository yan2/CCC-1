//
//  GameObject.m
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "GameObject.h"
#import "Player.h"


@implementation GameObject
@synthesize type;
@synthesize dl;


- (id)init
{
    self = [super init];
    if (self) {
        type = kGameObjectNone;
    }
    
    return self;
}

-(id)initWithSpriteFrameName:(NSString*)spriteFrameName
{
    if ( self = [super init] ){
        if ((self = [super initWithSpriteFrameName:spriteFrameName])) {
            NSLog(@"Super initing with sprite frame");
            NSAssert(spriteFrameName!=nil, @"Invalid spriteFrameName for sprite");
            
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteFrameName];
            return [super initWithSpriteFrame:frame];
        }
        
    }

}

- (void)dealloc
{
    [super dealloc];
}

@end
@implementation ConsumableObject

-(void) consume
{
    if(!consumed)
    {
        // set consumed
        consumed = YES;
        
        // fade & shrink object
        // and delete after animation
        [self runAction:
         [CCSequence actions:
          [CCSpawn actions:
           [CCFadeOut actionWithDuration:0.1],
           [CCScaleTo actionWithDuration:0.2 scale:0.0],
           nil],
          [CCCallFunc actionWithTarget:self selector:@selector(deleteNow)],
          nil]
         ];
        
         }
}

@end

@implementation Apple

-(void)consumeApple:(Player *) p
{
    if(!consumed)
    {
        [p restoreHealth:1];
        [self consume];
    }
}
@end
