//
//  GameObject.m
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize type;

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
