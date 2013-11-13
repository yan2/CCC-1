//
//  MainMenu.h  
//  

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"
#import "SceneManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CCVideoPlayer.h"
@interface MainMenu : CCLayer <CCVideoPlayerDelegate>{
    
}

@property (nonatomic, assign) BOOL iPad;

@end
