//
//  GameplayLayer.m
//
//  Created by : Qian Zhao
//  Project    : Puzzle
//  Date       : 9/10/2015
//
//  Copyright (c) 2015 Z&D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameplayLayer.h"
#import "OALSimpleAudio.h"




#define kBOARDCORNERX 115
#define kBOARDCORNERY 12
#define kTILEBOARDER 25
#define kTILECAP 2
#define kTILEWIDTH 140

#define kEmpty 24

#define UpperLimitY kBOARDCORNERY + kTILEBOARDER + kTILEWIDTH * 5 + kTILECAP * 4
#define UpperLimitX kBOARDCORNERX + kTILEBOARDER + kTILEWIDTH * 5 + kTILECAP * 4
#define LowerLimitY kBOARDCORNERY + kTILEBOARDER
#define LowerLimitX kBOARDCORNERX + kTILEBOARDER

const int Cols[25] = {
    0,1,2,3,4,
    0,1,2,3,4,
    0,1,2,3,4,
    0,1,2,3,4,
    0,1,2,3,4,
};

const int Rows[25] = {
    0,0,0,0,0,
    1,1,1,1,1,
    2,2,2,2,2,
    3,3,3,3,3,
    4,4,4,4,4
};
// -----------------------------------------------------------------

@implementation GameplayLayer
// -----------------------------------------------------------------
-(int)GetXFromTileCol:(int)Col {
    return kBOARDCORNERX + kTILEBOARDER + ((kTILEWIDTH + kTILECAP) * Col);
}

-(int)GetYFromTileRow:(int)Row {
    return kBOARDCORNERY + kTILEBOARDER + ((kTILEWIDTH + kTILECAP) * Row);
}

-(void)PrintBoard{
    NSLog(@"Board:");
    for (int rank=4; rank>=0; rank--){
        NSLog(@"%d %d %d %d %d",
              boardOcc[rank*5],
              boardOcc[rank*5+1],
              boardOcc[rank*5+2],
              boardOcc[rank*5+3],
              boardOcc[rank*5+4]);
    }
}

-(BOOL)OutOfBoard: (CGPoint)touchPoint{
    if (touchPoint.y > UpperLimitY) return YES;
    else if (touchPoint.y < LowerLimitY) return YES;
    else if (touchPoint.x > UpperLimitX) return YES;
    else if (touchPoint.x < LowerLimitX) return YES;
    
    return NO;
}

-(BOOL)CanMoveToSq:(int)sq fromSq:(int)sqf{
    if (boardOcc[sq]!=kEmpty) return NO;
    int  diff = sqf -sq;
    if (diff < 0) diff *= -1;
    if (diff != 5 && diff != 1){
        return NO;
    }
    
    return YES;
}

-(int)GetBoardSquareFromPoint:(CGPoint)point{
    if ([self OutOfBoard:point]) {
        return -1;
    }
    int x = point.x - kTILEBOARDER - kBOARDCORNERX;
    int y = point.y - kTILEBOARDER - kBOARDCORNERY;
    
    int totalTileWidth = kTILEWIDTH + kTILECAP;
    
    int row = y / totalTileWidth;
    int col = x / totalTileWidth;
    
    int sq = row * 5 + col;
    NSLog(@"GetBoardSquareFromPoint:%d",sq);
    
    return sq;

}

-(int)GetTileSquareFromPoint:(CGPoint)point{
    
    
    for (int sq = 0; sq<24; ++sq){
        if(CGRectContainsPoint([spriteBoard[sq] boundingBox],point)){
            for(int currIndex = 0; currIndex<25; ++currIndex){
                if(boardOcc[currIndex]==spriteBoard[sq].TileNumber){

                NSLog(@"Found Tile On sq %d", currIndex);
                return currIndex;

                }
            }
        }
    }
    return -1;
}

-(void)MakeRandomMove{
    int count = 0;
    int MoveArray[5];
    int sq;
    int EmptySq;
    
    for (sq=0; sq<25; ++sq){
        if(boardOcc[sq]==kEmpty){
            EmptySq = sq;
            break;
        }
    }
    int rowEmpty = Rows[sq];
    int colEmpty = Cols[sq];
    
    if (rowEmpty < 4)  MoveArray[count++] = (sq + 5);
    if (rowEmpty > 0)  MoveArray[count++] = (sq - 5);
    if (colEmpty < 4)  MoveArray[count++] = (sq + 1);
    if (colEmpty > 0)  MoveArray[count++] = (sq - 1);
    
    int randomIndex = arc4random() % count;
    int randomFrom = MoveArray[randomIndex];
    
    boardOcc[EmptySq] = boardOcc[randomFrom];
    boardOcc[randomFrom] = kEmpty;
}


-(void)RandomiseBoardForMoves:(int)numMoves{
    [self ResetGame];
    for (int move = 0; move < numMoves; ++move) {
        [self MakeRandomMove];
    }
    
    float x,y;
    int tileNum;
    for (int sq = 0; sq < 25; ++sq) {
        tileNum = boardOcc[sq];
        if (tileNum == kEmpty) continue;
        
        x=(float)[self GetXFromTileCol:Cols[sq]];
        y=(float)[self GetYFromTileRow:Rows[sq]];

        spriteBoard[tileNum].position = ccp(x,y);
        
    }
}

-(BOOL)PlayerWins {
    int correct = 0;
    for(int i=0; i<24; ++i){
        if(boardOcc[i] == i){
            correct ++;
        }
        
    }
    if (correct == 24) return YES;
    return NO;
}

//-(void)pickFromCameraroll{
//    CameraLayer *Cameraroll = [[Cameraroll alloc] init];
//    [Cameraroll pickCameraPhoto];
//    
//}

-(BOOL)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    NSLog(@"ccTouchBegan() touchLocation (%0.f,%0.f)", touchLocation.x, touchLocation.y);
    
    if (isAnimating) return NO;
    
    if (CGRectContainsPoint(resetButton.boundingBox, touchLocation)) {
        NSLog(@"reset pressed");
        [self ResetGame];
        inGame = NO;
        return NO;
        
        
    }
    
    if (CGRectContainsPoint(shuffleButton.boundingBox, touchLocation)) {
        NSLog(@"shuffle pressed");
        [self RandomiseBoardForMoves:30];
        inGame = YES;
        return NO;
    }
    
    if (CGRectContainsPoint(camerarollButton.boundingBox, touchLocation)) {
         NSLog(@"cameraroll pressed");
        //[self pickFromCameraroll];
        return NO;
    }
    
    if ([self OutOfBoard:touchLocation]){
        NSLog(@"ccTouchBegan() out of Board");
        return NO;
    }
    
    DragStartSq = [self GetTileSquareFromPoint:touchLocation];
    
    if(DragStartSq == -1){
        NSLog(@"ccTouchBegan() no DragStartSq");
        return NO;
    }
    
    dragCancelled = NO;
    return YES;
}

-(void)ResetGame{
    NSLog(@"intro reset...");
    [self PrintBoard];
    
    float x, y;
    int i=0;
    
    for (i=0; i<24; ++i) {
        x=(float)[self GetXFromTileCol:Cols[i]];
        y=(float)[self GetYFromTileRow:Rows[i]];
        
        spriteBoard[i].position = ccp(x,y);
    }
    
    for (i=0; i<25; ++i) {
        
        boardOcc[i] = i;
    }
    
    NSLog(@"after reset...");
    [self PrintBoard];

}
-(void)newGame{
    inGame = NO;
    isAnimating = NO;
    CGSize size = [[CCDirector sharedDirector]viewSize];
    winner.position = ccp(-size.width, -size.height);
    
}

-(void)wonGame{
    [[OALSimpleAudio sharedInstance] playEffect:@"cheer.wav"];
    CGSize size = [[CCDirector sharedDirector]viewSize];
    winner.position = ccp(size.width/2, size.height/2);
    
    id fadeInAction = [CCActionFadeIn actionWithDuration:1.5f];
    id delayAction = [CCActionDelay actionWithDuration:3.0f];
    id fadeOutAction = [CCActionFadeOut actionWithDuration:1.0f];
    id calResetFunctions = [CCActionCallFunc actionWithTarget:self selector:@selector(newGame)];
    
    [winner runAction:[CCActionSequence actions:fadeInAction,delayAction,fadeOutAction, nil]];
}

-(void)dragIsFinished{
    if (inGame == YES && [self PlayerWins]==YES) {
        NSLog(@"wins!");
        [self wonGame];
        
    }
    isAnimating = NO;
}

-(void)ExecuteTileDrag:(int)TileIndex SquareFrom:(int)sqf SquareTo:(int)sqto{
    NSLog(@"Drag from %d to %d tileIndex: %d", sqf, sqto, TileIndex);
    
    float XposTo = (float)[self GetXFromTileCol:Cols[sqto]];
    float YposTo = (float)[self GetYFromTileRow:Rows[sqto]];
    
    CGPoint toPoint = ccp(XposTo, YposTo);
    
    NSLog(@"Action Goes tp %0.f, %0.f", toPoint.x, toPoint.y);
    
    float duration = 0.2f;
    isAnimating =YES;
    
    [[OALSimpleAudio sharedInstance]playEffect:@"tilemove.wav" ];
    
    id moveAction = [CCActionMoveTo actionWithDuration:duration position:toPoint];
    id callDragDone = [CCActionCallFunc actionWithTarget:self selector:@selector(dragIsFinished)];
    
    CCSprite *selectedTile = spriteBoard[TileIndex];
    [selectedTile runAction:[CCActionSequence actions:moveAction,callDragDone, nil]];
    
    boardOcc[sqto] = boardOcc[sqf];
    boardOcc[sqf] = kEmpty;
    
    [self PrintBoard];
    
  
}


-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if (dragCancelled) {
        NSLog(@"ccTouchmove() no sq, -1");
        return;
    }
    
    if (isAnimating) return;
    
    CGPoint touchLocation = [touch locationInNode:self];
    NSLog(@"ccTouchMoved() touchLocation (%0.f,%0.f)", touchLocation.x, touchLocation.y);
    
    if ([self OutOfBoard:touchLocation]) {
        dragCancelled = YES;
        NSLog(@"ccTouchMove() out of Board");
    }
    
    int sqt = [self GetBoardSquareFromPoint:touchLocation];
    NSLog(@"Drag from sq %d to %d", DragStartSq, sqt);
    
    if (DragStartSq != sqt) {
        if ([self CanMoveToSq:sqt fromSq:DragStartSq]) {
            NSLog(@"Legal!");
            [self ExecuteTileDrag:boardOcc[DragStartSq] SquareFrom:DragStartSq SquareTo:sqt];
        }else{
            NSLog(@"ILegal!");

        }
        
    }
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
    
    if (self != nil){
        [[OALSimpleAudio sharedInstance]preloadEffect:@"tilemove.wav"];
        [[OALSimpleAudio sharedInstance]preloadEffect:@"cheer.wav"];
        
      
        
        NSString *fileName;
        float x,y;
        for(int i=0; i < 24; ++i){
            
            fileName = [NSString stringWithFormat:@"tile%d.png",i+1];
            NSLog(@"Filename: %@",fileName);
            spriteBoard[i] = [GameTile spriteWithImageNamed:fileName];
            x=(float)[self GetXFromTileCol:Cols[i]];
            y=(float)[self GetYFromTileRow:Rows[i]];
            NSLog(@"Tile index %i position (%0.f, %0.f) filename %@", i,x,y,fileName);
            spriteBoard[i].anchorPoint = ccp(0,0);
            spriteBoard[i].position = ccp(x,y);
            spriteBoard[i].TileNumber = i;
            [self addChild:spriteBoard[i] z:0];
            
            
            boardOcc[i] = i;
        }
        boardOcc[24] = kEmpty;
        
        resetButton = [CCSprite spriteWithImageNamed:@"reset.png"];
        resetButton.anchorPoint = ccp(0,0);
        resetButton.position = ccp(900,50);
        
        
        shuffleButton = [CCSprite spriteWithImageNamed:@"start.png"];
        shuffleButton.anchorPoint = ccp(0,0);
        shuffleButton.position = ccp(895,150);
        
        camerarollButton = [CCSprite spriteWithImageNamed:@"cameraroll.png"];
        camerarollButton.anchorPoint = ccp(0,0);
        camerarollButton.position = ccp(900,700);
        
        [self addChild:resetButton z:0];
        [self addChild:shuffleButton z:0];
        [self addChild:camerarollButton z:0];
        
        CGSize size = [[CCDirector sharedDirector]viewSize];
        winner = [CCSprite spriteWithImageNamed:@"winner.png"];
        winner.position = ccp(-size.width, -size.height);
        [self addChild:winner z:1];
        
    }
    
   
    return self;
}
-(void)onEnter{
    
    [super onEnter];
    self.userInteractionEnabled = YES;



}



// -----------------------------------------------------------------

@end





