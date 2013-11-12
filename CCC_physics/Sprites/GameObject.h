//
//  GameObject.h
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"

@interface GameObject : CCSprite {
    GameObjectType  type;
    GameObjectStatus dl;
}

@property (nonatomic, readwrite) GameObjectType type;
@property (nonatomic, readwrite) GameObjectStatus dl;
@end
@interface ConsumableObject : GameObject
{
@protected
    bool consumed;
}
-(void)consume;
@end

@interface Apple : ConsumableObject
{
}
@end
