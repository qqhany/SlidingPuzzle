//
//  GameplayLayer.h
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 9/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameTile.h"



// -----------------------------------------------------------------

@interface GameplayLayer : CCNode
{
    
    GameTile *spriteBoard[24];
    bool dragCancelled;
    int DragStartSq;
    int boardOcc[25];
    bool isAnimating;
    bool inGame;
    
    
    CCSprite *shuffleButton;
    CCSprite *resetButton;
    CCSprite *camerarollButton;
    
    CCSprite *winner;
    
   
}



// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

// -----------------------------------------------------------------

@end




