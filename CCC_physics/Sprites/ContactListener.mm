//
//  ContactListener.mm
//  Scroller
//
//  Created by min on 1/16/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "ContactListener.h"
#import "Constants.h"
#import "GameObject.h"
#import "SceneManager.h"
#define IS_PLAYER(x, y)         (x.type == kGameObjectPlayer || y.type == kGameObjectPlayer)
#define IS_PLATFORM(x, y)       (x.type == kGameObjectPlatform || y.type == kGameObjectPlatform)
#define IS_GAMEOVERTILE(x, y)   (x.type == kGameObjectGameOverTile || y.type == kGameObjectGameOverTile)
#define IS_ENDTILE(x, y)   (x.type == kGameObjectEndTile || y.type == kGameObjectEndTile)

ContactListener::ContactListener() {
}

ContactListener::~ContactListener() {
}

void ContactListener::BeginContact(b2Contact *contact) {
	GameObject *o1 = (GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	GameObject *o2 = (GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
	if (IS_PLATFORM(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"-----> Player made contact with platform!");
    }
    if (IS_GAMEOVERTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"~!~!~!~ Player made contact with death tiles brah");
    } if (IS_ENDTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"PLAYER REACHED END");
        [SceneManager goLevelComplete];
        
    }
}

void ContactListener::EndContact(b2Contact *contact) {
	GameObject *o1 = (GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	GameObject *o2 = (GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
	if (IS_PLATFORM(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"-----> Player lost contact with platform!");
    }
    if (IS_GAMEOVERTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"~!~!~!~ Player lost contact with death tiles brah");
    }if (IS_ENDTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"PLAYER REACHED ENdD");
        [SceneManager goLevelComplete];
        
    }
}

void ContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
}

void ContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
}