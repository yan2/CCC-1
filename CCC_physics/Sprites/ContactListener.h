//
//  ContactListener.h
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "Box2D.h"
#import <vector>
#import <algorithm>
#import "GameObject.h"
struct MyContact {
     b2Body *fixtureA;
    b2Body *fixtureB;
    bool operator==(const MyContact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
};


class ContactListener : public b2ContactListener {
public:
	ContactListener();
	~ContactListener();
    std::vector<MyContact>_contacts;

	
	virtual void BeginContact(b2Contact *contact);
	virtual void EndContact(b2Contact *contact);
	virtual void PreSolve(b2Contact *contact, const b2Manifold *oldManifold);
	virtual void PostSolve(b2Contact *contact, const b2ContactImpulse *impulse);
    bool collected;
    int collectibleID;
    b2Body *collectible;
};