//
//  BackgroundLayer.m
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 10/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "BackgroundLayer.h"


// -----------------------------------------------------------------

@implementation BackgroundLayer

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    
  
    
    
    return self;
}
-(void)onEnter{
    [super onEnter];
    CGSize size = [CCDirector sharedDirector].viewSize;
    NSLog(@"OurSize W:%f H:%f", size.width, size.height);
    CCSprite *boardImage = [CCSprite spriteWithImageNamed:@"board.png"];
    boardImage.position = ccp(size.width/2-17,size.height/2+3);
    [self resizeSprite:boardImage toWidth:750 toHeight:792];
    
    [self addChild:boardImage];
    
    self.userInteractionEnabled = NO;
};
-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
    sprite.scaleX = width / sprite.contentSize.width;
    sprite.scaleY = height / sprite.contentSize.height;
}

// -----------------------------------------------------------------

@end





