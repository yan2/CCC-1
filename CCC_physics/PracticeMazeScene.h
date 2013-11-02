//
//  PracticeMazeScene.h
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HudLayer.h"
#import "MazeLayer.h"

@interface PracticeMazeScene : CCNode {
    
    
}

@property (nonatomic,weak)MazeLayer *mazeLayer;
@property(nonatomic,weak)HudLayer *hudLayer;
@end
