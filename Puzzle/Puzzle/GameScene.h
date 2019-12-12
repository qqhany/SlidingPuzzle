//
//  GameScene.h
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 9/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// ---------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameTile.h"
// -----------------------------------------------------------------

@interface GameScene : CCScene
{
    
    GameTile *spriteBoard[24];
    
    
    int boardOcc[25];
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

// -----------------------------------------------------------------

@end




