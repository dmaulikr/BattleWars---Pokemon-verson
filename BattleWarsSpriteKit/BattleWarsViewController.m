//
//  BattleWarsViewController.m
//  BattleWarsSpriteKit
//
//  Created by felix king on 5/06/2014.
//  Copyright (c) 2014 Felix King. All rights reserved.
//

#import "BattleWarsViewController.h"
#import "BattleWarsMyScene.h"
@import AVFoundation;
@interface BattleWarsViewController ()
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@property (nonatomic) BattleWarsMyScene *MyScene;
@end

@implementation BattleWarsViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
  /*  NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"background-music-aac" withExtension:@"caf"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];*/
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
       // self.killsLable.text = [NSString stringWithFormat:@"kills = %@", @(self.MyScene.totalKills)];
       // skView.showsPhysics = YES;
        
        // Create and configure the scene.
        SKScene * scene = [BattleWarsMyScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end