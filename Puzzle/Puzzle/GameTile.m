//
//  GameTile.m
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 10/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameTile.h"

// -----------------------------------------------------------------

@implementation GameTile

// -----------------------------------------------------------------
@synthesize TileNumber;
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

// -----------------------------------------------------------------

@end





