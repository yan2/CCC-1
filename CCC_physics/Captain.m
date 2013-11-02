//
//  Captain.m
//  CaptainCC
//
//  Created by Ann Niou on 10/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Captain.h"


@implementation Captain

@synthesize velocity = _velocity;
@synthesize desiredPosition = _desiredPosition;
@synthesize onGround = _onGround;
@synthesize forwardMarch = _forwardMarch, mightAsWellJump = _mightAsWellJump;


-(void)idle {
    if (_actionState != kActionStateIdle) {
        [self stopAllActions];
        [self runAction:_idleAction];
        _actionState = kActionStateIdle;
        _velocity = CGPointZero;
    }
}

-(BoundingBox)createBoundingBoxWithOrigin:(CGPoint)origin size:(CGSize)size
{
    BoundingBox boundingBox;
    boundingBox.original.origin = origin;
    boundingBox.original.size = size;
    boundingBox.actual.origin = ccpAdd(position_, ccp(boundingBox.original.origin.x, boundingBox.original.origin.y));
    boundingBox.actual.size = size;
    return boundingBox;
}

-(CGRect)boundingBoxActual:(BoundingBox)BB
{
    return BB.actual;
}

-(CGRect)boundingBoxOriginal:(BoundingBox)BB
{
    return BB.original;
}

-(id)initWithSpriteFrameName:(NSString*)spriteFrameName
{
	NSAssert(spriteFrameName!=nil, @"Invalid spriteFrameName for sprite");
    
	CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteFrameName];
    self.velocity = ccp(0.0, 0.0);
	return [super initWithSpriteFrame:frame];
}

-(void)superPower {
    if (_actionState == kActionStateIdle || _actionState == kActionStateSuperPower || _actionState == kActionStateWalk) {
        [self stopAllActions];
        [self runAction:_superPowerAction];
        _actionState = kActionStateSuperPower;
    }
}
-(void)transformBoxes
{
    _hitBox.actual.origin = ccpAdd(position_, ccp(_hitBox.original.origin.x * scaleX_, _hitBox.original.origin.y * scaleY_));
    _hitBox.actual.size = CGSizeMake(_hitBox.original.size.width * scaleX_, _hitBox.original.size.height * scaleY_);
    _attackBox.actual.origin = ccpAdd(position_, ccp(_attackBox.original.origin.x * scaleX_, _attackBox.original.origin.y * scaleY_));
    _attackBox.actual.size = CGSizeMake(_attackBox.original.size.width * scaleX_, _attackBox.original.size.height * scaleY_);
}

-(void)walkWithDirection:(CGPoint)direction {
    if (_actionState == kActionStateIdle) {
        [self stopAllActions];
        [self runAction:_walkAction];
        _actionState = kActionStateWalk;
    }
    if (_actionState == kActionStateWalk) {
        _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
        if (_velocity.x >= 0) self.scaleX = 1.0;
        else self.scaleX = -1.0;
    }
}

-(CGRect)collisionBoundingBox {
    
    CGRect collisionBox = CGRectInset(self.boundingBox, 3, 0);
    //collisionBox = CGRectOffset(collisionBox, 0, -2);
    CGPoint diff = ccpSub(self.desiredPosition, self.position);
    CGRect returnBoundingBox = CGRectOffset(collisionBox, diff.x, diff.y);
    return returnBoundingBox;
    
}


-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    [self transformBoxes];
}


-(void)update:(ccTime)dt {
    if (_actionState == kActionStateWalk) {
        _desiredPosition = ccpAdd(position_, ccpMult(_velocity, dt));
    }
    
//    CGPoint gravity = ccp(0.0, -450.0);
//    CGPoint gravityStep = ccpMult(gravity, dt);
//    
//    CGPoint forwardMove = ccp(800.0, 0.0);
//    CGPoint forwardStep = ccpMult(forwardMove, dt);
//    
//    _velocity = ccp(_velocity.x * 0.90, _velocity.y); //2
//    
//    if (self.forwardMarch) {
//        _velocity = ccpAdd(_velocity, forwardStep);
//    } //3
//    
//    CGPoint minMovement = ccp(0.0, -450.0);
//    CGPoint maxMovement = ccp(120.0, 250.0);
//    _velocity = ccpClamp(_velocity, minMovement, maxMovement);
//    
//    _velocity = ccpAdd(_velocity, gravityStep);
//    
//    CGPoint stepVelocity = ccpMult(_velocity, dt);
//    
//    _desiredPosition = ccpAdd(position_, stepVelocity);

}

//-(CGRect)collisionBoundingBox {
//    CGRect collisionBox = CGRectInset(self.boundingBox, 3, 0);
//    CGPoint diff = ccpSub(self.desiredPosition, self.position);
//    CGRect returnBoundingBox = CGRectOffset(collisionBox, diff.x, diff.y);
//    return returnBoundingBox;
//}


@end
