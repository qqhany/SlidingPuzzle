//
//  BackgroundLayer.m
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 9/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "BackgroundLayer.h"

// -----------------------------------------------------------------

@implementation BackgroundLayer

// -----------------------------------------------------------------
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    BackgroundLayer *layer = [BackgroundLayer node];
    [scene addChild:layer];
    return scene;
}

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    if(self != nil){
        CGSize size = [CCDirector sharedDirector].viewSize;
        NSLog(@"OurSize W:%f H:%f", size.width, size.height);
        CCSprite *boardImage = [CCSprite spriteWithImageNamed:@"board.jpg"];
        boardImage.position = ccp(size.width/2,size.height/2);
        [self addChild:boardImage z:0];
    }
    
    
    
    return self;
}

// -----------------------------------------------------------------
-(void)onEnter{
    [super onEnter];
}

@end





