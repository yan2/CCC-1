

#import "Captain.h"


@implementation Captain





-(id)init {
    NSLog(@"CAPTAIN: INIT");
    if (self = [super init]){
            NSLog(@"init human");
        
        //Set idle action
            self.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[self HumanIdleAnimation]]];
        
        //Set walk action
            self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: [self HumanWalkAnimation]]];
        
        //Def superpower
        //        Superpower *testSuperpower = [Superpower alloc];
        //        testSuperpower = [testSuperpower init];
        self.crawlAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: [self HumanCrawlAnimation]]];

        
            self.superPowerAction = [CCSequence actions:[CCAnimate actionWithAnimation: [self SuperpowerAnimation]], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        //
        //Set some initial values for the hero’s attributes, including the measurements from the center of the sprite to the sides and bottom
            self.centerToBottom = 39.0;
            self.centerToSides = 29.0;
            self.hitPoints = 100.0;
            self.damage = 20.0;
            self.walkSpeed = 80;

    }
    NSLog(@"captain init but without frame");
    return self;
}


#define JUMP_TAG 1001

-(void)idle {
    NSLog(@"IDLING");
    
    NSLog(@"old position is %f", self.position.x);
    
    if (_actionState == kActionStateSuperPower){
        NSLog(@"JUMP EXECUTING");
        
//        CCJumpTo* jumpAct = [CCJumpTo actionWithDuration:1.0f position:ccp(self.position.x   150.0, self.position.y) height:80 jumps:1 ];
//        jumpAct.tag = JUMP_TAG;
//        NSLog(@"JUMPing");
//        [self runAction:jumpAct];
//        
//        CCAction *action = [self getActionByTag: JUMP_TAG];
//        if (!action){
//            [self runAction:_idleAction];
//            _actionState = kActionStateIdle;
//        }
        [super kangarooJump];
    }
    
    else {//(_actionState != kActionStateIdle){
        NSLog(@"STATE IS NOT IDLE");
        [self stopAllActions];
        [self runAction:_idleAction];
        _actionState = kActionStateIdle;
        _velocity = CGPointZero;
    }
}

-(void)superPower {
    if (_actionState == kActionStateIdle || _actionState == kActionStateSuperPower){ //|| _actionState == kActionStateWalk) {
        [self stopAllActions];
        [self runAction:_superPowerAction];
        _actionState = kActionStateSuperPower;
        NSLog(@"state changed to superpower");
        
    }
    //_actionState = kActionStateIdle;
    
}


-(void)walk {
    if (_actionState == kActionStateIdle|| _actionState == kActionStateSuperPower || _actionState == kActionStateCrawl) {
        [self stopAllActions];
        [self runAction:_walkAction];
        _actionState = kActionStateWalk;
    }
    
    if (_actionState == kActionStateWalk) {
       // _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
//        if (_velocity.x >= 0) self.scaleX = 1.0;
//        else self.scaleX = -1.0;
        _velocity = ccp(2.0, 0);
        [super moveRight];
    }
    
}

-(void)crawl {
    if (_actionState == kActionStateIdle|| _actionState == kActionStateSuperPower ||_actionState == kActionStateWalk) {
                 [self stopAllActions];
                 [self runAction:_crawlAction];
                 _actionState = kActionStateCrawl;
        self.position = ccp(self.position.x, self.position.y);
             }
     
         if (_actionState == kActionStateCrawl) {
                 // _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
                 //        if (_velocity.x >= 0) self.scaleX = 1.0;
                 //        else self.scaleX = -1.0;
                 _velocity = ccp(2.0, 0);
                 [super moveRight];
             }
         
     }


- (CCAnimation *) HumanWalkAnimation {
    
    CCArray *walkFrames = [CCArray arrayWithCapacity:8];
    for (int i = 1; i < 9; i++  ) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt Human-Walking000%d.png", i]];
        [walkFrames addObject:frame];
    }
    
    CCAnimation *walk = [CCAnimation animationWithFrames:[walkFrames getNSArray] delay:1.0/12.0];
    
    return walk;
    
}

- (CCAnimation *) HumanIdleAnimation {
    
    CCArray *idleFrames = [CCArray arrayWithCapacity:2];
    for (int i = 1; i < 3; i++  ) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt Human-Standing000%d.png", i]];
        [idleFrames addObject:frame];
    }
    
    CCAnimation *idleAnimation = [CCAnimation animationWithFrames:[idleFrames getNSArray] delay:1.0/12.0];
    
    return idleAnimation;
}


  - (CCAnimation *) HumanCrawlAnimation {
    
       CCArray *crawlFrames = [CCArray arrayWithCapacity:8];
      for (int i = 1; i < 9; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt Human-Crawling000%d.png", i]];
        [crawlFrames addObject:frame];
           }

       CCAnimation *crawl = [CCAnimation animationWithFrames:[crawlFrames getNSArray] delay:1.0/12.0];

      return crawl;
    
    }

- (CCAnimation *) SuperpowerAnimation {
    //action animation - runs once and then returns to idle
    CCArray *superPowerActionFrames = [CCArray arrayWithCapacity:85];
    for (int i = 1; i <= 25; i++  ) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Ant Capt Transistion-From KL00%d.png", i]];
        [superPowerActionFrames addObject:frame];
    }
    for (int j = 1; j <= 29; j++  ) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Ant Capt Trainsition-KL00%d.png", j]];
        [superPowerActionFrames addObject:frame];
    }
    for (int k = 1; k <= 31; k++  ) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt KL-Jumping00%d.png", k]];
        [superPowerActionFrames addObject:frame];
    }
    CCAnimation *actionAnimation = [CCAnimation animationWithFrames:[superPowerActionFrames getNSArray] delay:1.0/24.0];
    
    return actionAnimation;
}




-(void)update:(ccTime)dt {
    NSLog(@"captain updating");
    if (_actionState == kActionStateWalk | _actionState == kActionStateSuperPower) {
        _desiredPosition = ccpAdd(position_, ccpMult(_velocity, dt));
    }
}
@end
