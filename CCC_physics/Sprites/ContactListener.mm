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
#import "MazeLayer.h"


#define IS_PLAYER(x, y)         (x.type == kGameObjectPlayer || y.type == kGameObjectPlayer)
#define IS_PLATFORM(x, y)       (x.type == kGameObjectPlatform || y.type == kGameObjectPlatform)
#define IS_GAMEOVERTILE(x, y)   (x.type == kGameObjectGameOverTile || y.type == kGameObjectGameOverTile)
#define IS_ENDTILE(x, y)   (x.type == kGameObjectEndTile || y.type == kGameObjectEndTile)
#define IS_COLLECTIBLE(x,y)     (x.type == kGameObjectCollectible || y.type == kGameObjectCollectible)
const int32 k_maxNuke = 6;

b2Body* nuke[k_maxNuke];

int32 nukeCount = 0;


ContactListener::ContactListener() {
    collected = NO;
    collectibleID = nil;
    collectible = nil;
}

ContactListener::~ContactListener() {
}


void ContactListener::BeginContact(b2Contact *contact) {
    
    MyContact myContact = { (b2Body*)contact->GetFixtureA()->GetBody(), (b2Body*)contact->GetFixtureB()->GetBody()};
    _contacts.push_back(myContact);
    
    
    collected = NO;
	GameObject *o1 = (GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	GameObject *o2 = (GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
	if (IS_PLATFORM(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"-----> Player made contact with platform!");
    }
    if (IS_GAMEOVERTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"~!~!~!~ Player made contact with death tiles brah");
        [SceneManager goGameOverLayer];
    } if (IS_ENDTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"PLAYER REACHED END");
        [SceneManager goLevelComplete];
        
    } if (IS_COLLECTIBLE(o1, o2) && IS_PLAYER(o1, o2)) {
        if (o1.type == kGameObjectCollectible) {
            o1.visible = NO;
            CCLOG(@"o1");
//            o1.type == kGameObjectEaten;
            b2Body *b = (b2Body*)contact->GetFixtureA()->GetBody();
            collectible = b;
          
        }
        
        if (o2.type == kGameObjectCollectible) {
            o2.visible = NO;
            
             CCLOG(@"o2");
        }
        CCLOG(@"player collected item");
//        o1.visible = NO;
//        o2.visible = NO;
        collected = YES;
        CCLOG(@"collected = yes");
    }
}


void ContactListener::EndContact(b2Contact *contact) {
    
    MyContact myContact = { (b2Body*)contact->GetFixtureA()->GetBody(), (b2Body*)contact->GetFixtureB()->GetBody()};
    std::vector<MyContact>::iterator pos;
    pos = std::find(_contacts.begin(), _contacts.end(), myContact);
    if (pos != _contacts.end()) {
        _contacts.erase(pos);
    }

    
	GameObject *o1 = (GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	GameObject *o2 = (GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
	if (IS_PLATFORM(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"-----> Player lost contact with platform!");
    }
    if (IS_GAMEOVERTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"~!~!~!~ Player lost contact with death tiles brah");
    }if (IS_ENDTILE(o1, o2) && IS_PLAYER(o1, o2)) {
        CCLOG(@"PLAYER REACHED ENdD");
//        [SceneManager goLevelComplete];
        
    }
}

void ContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
}

void ContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
    
    
    
    
    
}