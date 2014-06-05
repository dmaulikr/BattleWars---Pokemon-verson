//
//  Army.h
//  BattleWarsSpriteKit
//
//  Created by felix king on 5/06/2014.
//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Army : NSObject

- (NSInteger)numberOfActiveGoodUnits;
- (NSMutableArray *)activeGoodUnits;

- (NSInteger)numberOfActiveEvilUnits;
- (NSMutableArray *)activeEvilUnits;

@property (nonatomic)Army *goodArmy;
@property (nonatomic)Army *evilArmy;

@end
