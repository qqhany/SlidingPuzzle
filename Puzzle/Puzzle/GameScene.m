//
//  GameScene.m
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 9/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameScene.h"
#import "BackgroundLayer.h"
#import "GameplayLayer.h"

// -----------------------------------------------------------------




@implementation GameScene


- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    if(self !=nil){
        CGSize screenSize = [[CCDirector sharedDirector]viewSize];
        BackgroundLayer *bgLayer = [BackgroundLayer node];
        [self addChild:bgLayer z:-1];
        GameplayLayer *gpLayer = [GameplayLayer node];
        gpLayer.contentSize = screenSize;
        [self addChild:gpLayer z:0];
        
        
        
        self.userInteractionEnabled = YES;
    }
    
    
    return self;
}


// -----------------------------------------------------------------

@end





