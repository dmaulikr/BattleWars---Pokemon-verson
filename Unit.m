//
//  Unit.m
//  BattleWarsSpriteKit
//
//  Created by felix king on 5/06/2014.
//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import "Unit.h"

@implementation Unit

- (void)takeDamage:(NSInteger)damage {
    self.hitpoints -= damage;
}

+ (instancetype)makeUnitOfType:(UnitType)type {
    Unit *unit = [[Unit alloc] init];
    
    if (type == UnitTypeEvilGrenader) {
        unit.hitpoints = 10;
        unit.range = 5;
        unit.damage = 1;
        unit.armour = 2;
        unit.speed = 2;
        unit.imageFilename = @"grenade.jpg";
        unit.name = @"Grenader";
    }
    if (type == UnitTypeEvilPixy) {
        unit.hitpoints = 15;
        unit.range = 1;
        unit.damage = 3;
        unit.armour = 1;
        unit.speed = 4;
        unit.imageFilename = @"evilPixie";
        unit.name = @"Pixy";
    }
    if (type == UnitTypeEvilRunner) {
        unit.hitpoints = 5;
        unit.range = 1;
        unit.damage = 5;
        unit.armour = 1;
        unit.speed = 5;
        unit.imageFilename = @"evilRunningMan.jpg";
        unit.name = @"Runner";
    }
    if (type == UnitTypeEvilScareCrow) {
        unit.hitpoints = 10;
        unit.range = 1;
        unit.damage = 3;
        unit.armour = 4;
        unit.speed = 1;
        unit.imageFilename = @"scareCrow.jpg";
        unit.name = @"Scare";
    }
    if (type == UnitTypeEvilWarrior) {
        unit.hitpoints = 3;
        unit.range = 2;
        unit.damage = 2;
        unit.armour = 2;
        unit.speed = 2;
        unit.imageFilename = @"evilWarrior.jpg";
        unit.name = @"Bad Guy";
    }
    
    if (type == UnitTypeWarrior) {
        unit.hitpoints = 5;
        unit.range = 2;
        unit.damage = 2;
        unit.armour = 2;
        unit.speed = 2;
        unit.imageFilename = @"pociBlueOrangeDrag.png";
        unit.name = @"Warrior";
    }
    if (type == UnitTypeArcher) {
        unit.hitpoints = 10;
        unit.range = 5;
        unit.damage = 1;
        unit.armour = 2;
        unit.speed = 2;
        unit.imageFilename = @"pociBlueDrag.tiff";
        unit.name = @"Archer";
    }
    if (type == UnitTypeClayGiant) {
        unit.hitpoints = 5;
        unit.range = 1;
        unit.damage = 3;
        unit.armour = 5;
        unit.speed = 1;
        unit.imageFilename = @"pociRedDrag.png";
        unit.name = @"Giant";
    }
    if (type == UnitTypeKnight) {
        unit.hitpoints = 15;
        unit.range = 1;
        unit.damage = 4;
        unit.armour = 3;
        unit.speed = 5;
        unit.imageFilename = @"pociPurpleDrag.tiff";
        unit.name = @"Knight";
    }
    if (type == UnitTypeMage) {
        unit.hitpoints = 5;
        unit.range = 3;
        unit.damage = 6;
        unit.armour = 1;
        unit.speed = 1;
        unit.imageFilename = @"pociOrangeDrag.tiff";
        unit.name = @"Mage";
    }
    if (type == UnitTypeBerserker) {
        unit.hitpoints = 15;
        unit.range = 1;
        unit.damage = 5;
        unit.armour = 3;
        unit.speed = 3;
        unit.imageFilename = @"Yveltal.png";
        unit.name = @"Beserker";
    }
    return unit;
}

- (BOOL)isDead {
    if (self.hitpoints <= 0) {
        self.hitpoints = 0;
        return YES;
    } else {
        return NO;
    }
}

@end
