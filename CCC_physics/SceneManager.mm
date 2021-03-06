//
//  SceneManager.m
// 

#import "SceneManager.h"

@interface SceneManager ()

+(void) go: (CCLayer *) layer;
+(CCScene *) wrap: (CCLayer *) layer;

@end

@implementation SceneManager



+(void) goLevelComplete {
    [SceneManager go:[LevelCompleteScene node]];
}
+(void) goMainMenu {
    [SceneManager go:[MainMenu node]];
}

+(void) goOptionsMenu {
    [SceneManager go:[OptionsMenu node]];
}

+(void) goChapterSelect {
    [SceneManager go:[ChapterSelect node]];
}
//
+(void) goLevelSelect {
    [SceneManager go:[LevelSelect node]];
}

+(void) goGameScene {
    [SceneManager go:[GameScene node]];
}

+(void) goGameOverLayer {
    [SceneManager go:[GameOverLayer node]];
}

+(void) goLearningModulesMenu {
    [SceneManager go:[LearningModulesMenu node]];
}

+(void) go: (CCLayer *) layer {
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [SceneManager wrap:layer];
    if ([director runningScene]) {
        
        [director replaceScene:newScene];
    }
    else {
        [director runWithScene:newScene];
    }
}

+(CCScene *) wrap: (CCLayer *) layer {
    CCScene *newScene = [CCScene node];
    [newScene addChild: layer];
    return newScene;
}

@end
