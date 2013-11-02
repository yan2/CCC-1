//
//  GameScene.h
//  

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"
#import "SceneManager.h"
#import "Box2D.h"
#import "TRBox2D.h"


@interface GameScene : CCLayer {
    b2World *world;
    GLESDebugDraw *debugDraw;

}

@property (nonatomic, assign) BOOL iPad;
@property (nonatomic, assign) NSString *device;




@end
