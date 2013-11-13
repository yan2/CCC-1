//
//  MainMenu.m
//

#import "MainMenu.h"
#import "GameData.h"
#import "GameDataParser.h"

@implementation MainMenu
@synthesize iPad;

- (void)onPlay: (id) sender {
    [SceneManager goLevelSelect];
}

- (void)onOptions: (id) sender {
    [SceneManager goOptionsMenu];
}

- (void)onLearningModules: (id) sender {
    //    [SceneManager goLearningModulesMenu];
    [SceneManager goLearningModulesMenu];
}

- (void)addBackButton {
    
    if (self.iPad) {
        // Create a menu image button for iPad
        CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:@"Arrow-Normal-iPad.png"
                                                         selectedImage:@"Arrow-Selected-iPad.png"
                                                                target:self
                                                              selector:@selector(onBack:)];
        // Add menu image to menu
        CCMenu *back = [CCMenu menuWithItems: goBack, nil];
        
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        back.position = ccp(64, 64);
        
        // Add menu to this scene
        [self addChild: back];
    }
    else {
        // Create a menu image button for iPhone / iPod Touch
        CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:@"Back Arrow.png"
                                                         selectedImage:@"Back Arrow.png"
                                                                target:self
                                                              selector:@selector(onBack:)];
        goBack.scale = .5;
        // Add menu image to menu
        CCMenu *back = [CCMenu menuWithItems: goBack, nil];
        
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        back.position = ccp(32, 32);
        
        // Add menu to this scene
        [self addChild: back];
    }
}

- (id)init {
    
    if( (self=[super init])) {
        
        // Determine Device
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        // Determine Screen Size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        // Calculate Large Font Size
        int smallFont = screenSize.height / kFontScaleSmall;
        
        // Set font settings
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:smallFont];
        

//        //CREATE MOVIE
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Opening Sequence" ofType:@"mov"];
//        NSURL *movieURL = [NSURL fileURLWithPath:path];
//        
//        MPMoviePlayerViewController *mp= [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
//        [[mp moviePlayer] setMovieControlMode:MPMovieControlModeHidden];
//        [[mp moviePlayer] controlStyle:MPMovieControlStyleFullscreen];
//        
//        
//        [[[[CCDirector sharedDirector] openGLView] window] addSubview:mp.view];
//        [[mp moviePlayer] play];
        
        

//        CCMenuItemImage *learn = [CCMenuItemImage itemFromNormalImage:@"learn.png"
//                                                        selectedImage:@"learn.png"
//                                                               target:self
//                                                             selector:@selector(onLearningModules:)];
//        learn.scale = .5;
//        learn.zOrder = -50;
//        
//        CCMenu *learnMenu = [CCMenu menuWithItems: learn, nil];
//        [self addChild:learnMenu];
//        learnMenu.position = ccp(0,0);
//        
//        CCMenuItemImage *explore = [CCMenuItemImage itemFromNormalImage:@"explore.png"
//                                                          selectedImage:@"explore.png"
//                                                                 target:self
//                                                               selector:@selector(onPlay:)];
//        
        
//        explore.zOrder = -50;
//        CCMenu *exploreMenu = [CCMenu menuWithItems: explore, nil];
//        [self addChild:exploreMenu];
//        explore.scale = .5;
//        exploreMenu.position = ccp(screenSize.width,screenSize.height/2);
//
//        
        CCSprite *background = [CCSprite spriteWithFile:@"Opening Page.png"];
        background.position = ccp(screenSize.width/2+70, screenSize.height/2-60);
        background.scale = .5;
        background.zOrder = -100;
        [self addChild:background];
        
        // Testing GameData
        
        GameData *gameData = [GameDataParser loadData];
        
        CCLOG(@"Read from XML 'Selected Chapter' = %i", gameData.selectedChapter);
        CCLOG(@"Read from XML 'Selected Level' = %i", gameData.selectedLevel);
        
        
        gameData.selectedChapter = 7;
        gameData.selectedLevel = 4;
        //        gameData.music = 0;
        //        gameData.sound = 0;
        
        [GameDataParser saveData:gameData];
        [CCVideoPlayer setDelegate: self];
        [CCVideoPlayer playMovieWithFile:@"Opening Sequence.m4v"];
        
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//        [self playInstructionsVideo];
    }
    return self;
}


//- (void)playInstructionsVideo
//{
//    MPMoviePlayerController * _moviePlayer;
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01 - Fit Test" ofType:@"mp4"]];
//    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackDidFinish)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:_moviePlayer];
//    
//    [_moviePlayer respondsToSelector:@selector(setFullscreen:animated:)];
//    _moviePlayer.controlStyle = MPMovieControlStyleNone;
//    _moviePlayer.shouldAutoplay = YES;
//    _moviePlayer.repeatMode = MPMovieRepeatModeOne;
////    _moviePlayer.view.frame = CGRectMake(0, 0, 300, 300);
//    
//    UIView* glView = [CCDirector sharedDirector].openGLView; // attention
//    [glView.superview insertSubview:_moviePlayer.view atIndex:0]; // attention
//    glView.opaque = NO; // attention
//    glClearColor(0.0f, 0.0f, 0.0f, 0.0f); // attention
//}

- (void) moviePlaybackFinished {
//    [[CCDirector sharedDirector] startAnimation];
    CCLOG(@"movieplaybackfinished");
}

-(void) movieStartsPlaying {
    [[CCDirector sharedDirector] stopAnimation];
     CCLOG(@"moviestarts");
}
//
//- (void)moviePlayBackDidFinish:(NSNotification *)notification
//{
//    MPMoviePlayerController *moviePlayer = [notification object];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:MPMoviePlayerPlaybackDidFinishNotification
//                                                  object:moviePlayer];
//    
//    // If the moviePlayer.view was added to the openGL view, it needs to be removed
//    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
//    {
//        [moviePlayer.view removeFromSuperview];
//    }
//    
//    [moviePlayer release];
//}
//

@end
