//
//  Army.m
//  BattleWarsSpriteKit
//
//  Created by felix king on 5/06/2014.
//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import "Army.h"
#import "Unit.h"

@interface Army ()
@property (nonatomic) NSMutableArray *allGoodUnits;
@property (nonatomic) NSMutableArray *allEvilUnits;
@end

@implementation Army

- (Army *)goodArmy {
    if (!_goodArmy) _goodArmy = [[Army alloc] init];
    return _goodArmy;
}

- (Army *)evilArmy {
    if (!_evilArmy)_evilArmy = [[Army alloc] init];
    return _evilArmy;
}

- (NSMutableArray *)allEvilUnits {
    if (!_allEvilUnits) {
        _allEvilUnits = [[NSMutableArray alloc] init];
        
        [_allEvilUnits addObject:[Unit makeUnitOfType:UnitTypeEvilWarrior]];
        [_allEvilUnits addObject:[Unit makeUnitOfType:UnitTypeEvilScareCrow]];
        [_allEvilUnits addObject:[Unit makeUnitOfType:UnitTypeEvilRunner]];
        [_allEvilUnits addObject:[Unit makeUnitOfType:UnitTypeEvilPixy]];
        [_allEvilUnits addObject:[Unit makeUnitOfType:UnitTypeEvilGrenader]];
    }
    return _allEvilUnits;
}

- (NSMutableArray *)allGoodUnits {
    if (!_allGoodUnits) {
        _allGoodUnits = [[NSMutableArray alloc] init];
        
        [_allGoodUnits addObject:[Unit makeUnitOfType:UnitTypeWarrior]];
        [_allGoodUnits addObject:[Unit makeUnitOfType:UnitTypeMage]];
        [_allGoodUnits addObject:[Unit makeUnitOfType:UnitTypeKnight]];
        [_allGoodUnits addObject:[Unit makeUnitOfType:UnitTypeBerserker]];
        [_allGoodUnits addObject:[Unit makeUnitOfType:UnitTypeArcher]];
        [_allGoodUnits addObject:[Unit makeUnitOfType:UnitTypeClayGiant]];
    }
    return _allGoodUnits;
}

- (NSArray *)activeEvilUnits {
    if (self.allEvilUnits.count == 1) {
        return @[[self.allEvilUnits objectAtIndex:0]];
    } else if (self.allEvilUnits.count == 2) {
        return @[[self.allEvilUnits objectAtIndex:0], [self.allEvilUnits objectAtIndex:1]];
    } else if (self.allEvilUnits.count == 3) {
        return @[[self.allEvilUnits objectAtIndex:0], [self.allEvilUnits objectAtIndex:1], [self.allEvilUnits objectAtIndex:2]];
    } else if (self.allEvilUnits.count == 4) {
        return @[[self.allEvilUnits objectAtIndex:0], [self.allEvilUnits objectAtIndex:1], [self.allEvilUnits objectAtIndex:2], [self.allEvilUnits objectAtIndex:3]];
    } else if (self.allEvilUnits.count >= 5) {
        return @[[self.allEvilUnits objectAtIndex:0], [self.allEvilUnits objectAtIndex:1], [self.allEvilUnits objectAtIndex:2], [self.allEvilUnits objectAtIndex:3], [self.allEvilUnits objectAtIndex:4]];
    } else {
        return nil;
    }
}

- (NSArray *)activeGoodUnits {
    if (self.allGoodUnits.count == 1) {
        return @[[self.allGoodUnits objectAtIndex:0]];
    } else if (self.allGoodUnits.count == 2) {
        return @[[self.allGoodUnits objectAtIndex:0], [self.allGoodUnits objectAtIndex:1]];
    } else if (self.allGoodUnits.count == 3) {
        return @[[self.allGoodUnits objectAtIndex:0], [self.allGoodUnits objectAtIndex:1], [self.allGoodUnits objectAtIndex:2]];
    } else if (self.allGoodUnits.count == 4) {
        return @[[self.allGoodUnits objectAtIndex:0], [self.allGoodUnits objectAtIndex:1], [self.allGoodUnits objectAtIndex:2], [self.allGoodUnits objectAtIndex:3]];
    } else if (self.allGoodUnits.count >= 5) {
        return @[[self.allGoodUnits objectAtIndex:0], [self.allGoodUnits objectAtIndex:1], [self.allGoodUnits objectAtIndex:2], [self.allGoodUnits objectAtIndex:3], [self.allGoodUnits objectAtIndex:4]];
    } else {
        return nil;
    }
}

- (NSInteger)numberOfActiveEvilUnits {
    NSInteger countOfAllEvilUnits = 0;
    if (self.allEvilUnits.count > 5) {
        countOfAllEvilUnits = 5;
    }
    if (self.allEvilUnits.count <= 5) {
        countOfAllEvilUnits = self.allEvilUnits.count;
    }
    return countOfAllEvilUnits;
}

- (NSInteger)numberOfActiveGoodUnits {
    NSInteger countOfAllGoodUnits = 0;
    if (self.allGoodUnits.count > 5) {
        countOfAllGoodUnits = 5;
    }
    if (self.allGoodUnits.count <= 5) {
        countOfAllGoodUnits = self.allGoodUnits.count;
    }
    return countOfAllGoodUnits;
}

@end
