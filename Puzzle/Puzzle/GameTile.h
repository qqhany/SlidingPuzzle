//
//  GameTile.h
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 10/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface GameTile : CCSprite

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods
@property(nonatomic)int TileNumber;

+ (instancetype)node;
- (instancetype)init;

// -----------------------------------------------------------------

@end




