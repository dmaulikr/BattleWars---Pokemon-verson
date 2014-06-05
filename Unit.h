//
//  Unit.h
//  BattleWarsSpriteKit
//
//  Created by felix king on 5/06/2014.
//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UnitType) {
    UnitTypeWarrior,    // standard
    UnitTypeArcher,     // long range low damage
    UnitTypeClayGiant,  // slow speed high armour low HP
    UnitTypeKnight,     // high speed medium armour low range
    UnitTypeBerserker,  // high damage
    UnitTypeMage,       // very high damage
  /*
    UnitTypeEvilWarrior,    //standard evil soldier
    UnitTypeEvilPixy,      //very fast low armour low health low range and medium hitpoints
    UnitTypeEvilScareCrow,  //very slow, high armour, low speed, medium attack
    UnitTypeEvilRunner,     //very fast low everything except for extremly high damage
    UnitTypeEvilGrenader,   //long range low damage*/
};

@interface Unit : NSObject

@property NSInteger hitpoints;
@property NSInteger range;
@property NSInteger damage;
@property NSInteger armour;
@property NSInteger speed;
@property NSString *imageFilename;
@property NSString *name;

+ (instancetype) makeUnitOfType:(UnitType)type;

- (void) takeDamage:(NSInteger)damage;

- (BOOL) isDead;

@end
