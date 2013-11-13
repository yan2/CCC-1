//
//  Superpower.h
//  CCC_physics
//
//  Created by Xu Rui on 13/11/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Superpower : NSObject

@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) CCAnimation* transformAnimation;
@property(strong, nonatomic) CCAnimation* actionAnimation;
@property(strong, nonatomic) UIImage* icon;


- (void*) useSuperpower;

@end
