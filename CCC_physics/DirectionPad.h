//
//  DirectionPad.h
//  CaptainCC
//
//  Created by Ann Niou on 10/29/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class DirectionPad;

@protocol DirectionPadDelegate <NSObject>

-(void)DirectionPad:(DirectionPad *)DirectionPad didChangeDirectionTo:(CGPoint)direction;
-(void)DirectionPad:(DirectionPad *)DirectionPad isHoldingDirection:(CGPoint)direction;
-(void)DirectionPadTouchEnded:(DirectionPad *)DirectionPad;

@end
@interface DirectionPad : CCSprite <CCTargetedTouchDelegate>{
    float _radius;
    CGPoint _direction;
    
}


@property(nonatomic,weak)id <DirectionPadDelegate> delegate;
@property(nonatomic,assign)BOOL isHeld;

+(id)dPadWithFile:(NSString *)fileName radius:(float)radius;
-(id)initWithFile:(NSString *)filename radius:(float)radius;


@end
