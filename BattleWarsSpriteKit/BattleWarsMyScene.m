//
//  BattleWarsMyScene.m
//  BattleWarsSpriteKit
//
//  Created by felix king on 5/06/2014.
//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import "BattleWarsMyScene.h"
#import "GameOverScene.h"
#import "Unit.h"

@interface BattleWarsMyScene () <SKPhysicsContactDelegate>
@property (nonatomic) Army* army;

@property (nonatomic) int monstersDestroyed;

@property (nonatomic) SKSpriteNode *player1;
@property (nonatomic) SKSpriteNode *player2;
@property (nonatomic) SKSpriteNode *player3;
@property (nonatomic) SKSpriteNode *player4;
@property (nonatomic) SKSpriteNode *player5;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@end

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

// Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t monsterCategory        =  0x1 << 1;

@implementation BattleWarsMyScene

- (Army *)goodArmy {
    if (!_goodArmy) _goodArmy = [[Army alloc] init];
    return _goodArmy;
}

- (Army *)evilArmy {
    if (!_evilArmy)_evilArmy = [[Army alloc] init];
    return _evilArmy;
}
 

-(id)initWithSize:(CGSize)size {
    NSMutableArray *goodUnits = [self.goodArmy activeGoodUnits];
    
    Unit *firstGoodUnit = [goodUnits objectAtIndex:0];
    Unit *secondGoodUnit = [goodUnits objectAtIndex:1];
    Unit *thirdGoodUnit = [goodUnits objectAtIndex:2];
    Unit *fourthGoodUnit = [goodUnits objectAtIndex:3];
    Unit *fifthGoodUnit = [goodUnits objectAtIndex:4];

    
    if (self = [super initWithSize:size]) {
        
        // 2
        NSLog(@"Size: %@", NSStringFromCGSize(size));
        
        // 3
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        // 4
        if (goodUnits.count > 0) {
        self.player1 = [SKSpriteNode spriteNodeWithImageNamed:firstGoodUnit.imageFilename];
        self.player1.position = CGPointMake(self.player1.size.width/2, self.frame.size.height * 0.2);
        [self addChild:self.player1];
        }
        if (goodUnits.count > 1) {
        self.player2 = [SKSpriteNode spriteNodeWithImageNamed:secondGoodUnit.imageFilename];
        self.player2.position = CGPointMake(self.player2.size.width/2, self.frame.size.height * 0.4);
        [self addChild:self.player2];
        }
        if (goodUnits.count > 2) {
        self.player3 = [SKSpriteNode spriteNodeWithImageNamed:thirdGoodUnit.imageFilename];
        self.player3.position = CGPointMake(self.player3.size.width/2, self.frame.size.height * 0.6);
        [self addChild:self.player3];
        }
        if (goodUnits.count > 3) {
        self.player4 = [SKSpriteNode spriteNodeWithImageNamed:fourthGoodUnit.imageFilename];
        self.player4.position = CGPointMake(self.player3.size.width/2, self.frame.size.height * 0.8);
        [self addChild:self.player4];
        }
        if (goodUnits.count > 4) {
        self.player5 = [SKSpriteNode spriteNodeWithImageNamed:fifthGoodUnit.imageFilename];
        self.player5.position = CGPointMake(self.player3.size.width/2, self.frame.size.height);
        [self addChild:self.player5];
        }
    }
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    return self;
}
- (void)addMonster {
    
    // Create sprite
    NSInteger randNum = arc4random_uniform(6);
    
    SKSpriteNode * monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    if (randNum == 0) {
        monster = [SKSpriteNode spriteNodeWithImageNamed:@"pociBone.tiff"];
    }
    if (randNum == 1) {
        monster = [SKSpriteNode spriteNodeWithImageNamed:@"pociDrag.tiff"];
    }
    if (randNum == 2) {
        monster = [SKSpriteNode spriteNodeWithImageNamed:@"pociBone.tiff"];
    }
    if (randNum == 3) {
        monster = [SKSpriteNode spriteNodeWithImageNamed:@"200_s.gif"];
    }
    if (randNum == 4) {
        monster = [SKSpriteNode spriteNodeWithImageNamed:@"200_s-1.gif"];
    }
    if (randNum == 5) {
        monster = [SKSpriteNode spriteNodeWithImageNamed:@"pociBlueDrag.tiff"];
    }
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size]; // 1
    monster.physicsBody.dynamic = YES; // 2
    monster.physicsBody.categoryBitMask = monsterCategory; // 3
    monster.physicsBody.contactTestBitMask = projectileCategory; // 4
    monster.physicsBody.collisionBitMask = 0; // 5
    
    // Determine where to spawn the monster along the Y axis
    int minY = monster.size.height / 2;
    int maxY = self.frame.size.height - monster.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPointMake(self.frame.size.width + monster.size.width/2, actualY);
    [self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 10.0;
    int maxDuration = 20.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(-monster.size.width/2, actualY) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    SKAction * loseAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
        [self.view presentScene:gameOverScene transition: reveal];
    }];
    [monster runAction:[SKAction sequence:@[actionMove, loseAction, actionMoveDone]]];
    
}
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 1) {
        self.lastSpawnTimeInterval = 0;
        [self addMonster];
    }
}
- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
    
    
    // 1 - Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    // 2 - Set up initial location of projectile
    SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"pociBall.gif"];
    projectile.position = self.player1.position;
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    projectile.physicsBody.contactTestBitMask = monsterCategory;
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    // 3- Determine offset of location to projectile
    CGPoint offset = rwSub(location, projectile.position);
    
    // 4 - Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;
    
    // 5 - OK to add now - we've double checked position
    [self addChild:projectile];
    
    // 6 - Get the direction of where to shoot
    CGPoint direction = rwNormalize(offset);
    
    // 7 - Make it shoot far enough to be guaranteed off screen
    CGPoint shootAmount = rwMult(direction, 1000);
    
    // 8 - Add the shoot amount to the current position
    CGPoint realDest = rwAdd(shootAmount, projectile.position);
    
    // 9 - Create the actions
    float velocity = 480.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    NSLog(@"Hit");
    [projectile removeFromParent];
    [monster removeFromParent];
    self.totalKills++;
    self.monstersDestroyed++;
    NSLog([NSString stringWithFormat:@"totalKills = %@", @(self.totalKills)]);
    // Adjusting the mount of kills it requires to win
    if (self.monstersDestroyed > 30) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:YES];
        [self.view presentScene:gameOverScene transition: reveal];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}

@end
