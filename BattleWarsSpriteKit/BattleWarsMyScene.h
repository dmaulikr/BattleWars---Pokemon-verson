//
//  BattleWarsMyScene.h
//  BattleWarsSpriteKit
//

//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Army.h"

@interface BattleWarsMyScene : SKScene

@property (nonatomic)Army *goodArmy;
@property (nonatomic)Army *evilArmy;

@property (nonatomic) NSInteger totalKills;

@end
