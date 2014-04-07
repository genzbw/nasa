//
//  iCodeAppDelegate.m
//  iCode
//
//  Created by hjx on 2014-04-02.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "iCodeAppDelegate.h"
#import "AppBoard.h"
@implementation iCodeAppDelegate

- (void)load{
    bee.ui.config.ASR = YES;
	bee.ui.config.iOS7Mode = YES;
	bee.ui.config.cacheAsyncLoad = YES;
	bee.ui.config.cacheAsyncSave = YES;
    
	[BeeUITipsCenter setDefaultBubble:[UIImage imageNamed:@"alertBox.png"]];
	[BeeUITipsCenter setDefaultMessageIcon:[UIImage imageNamed:@"index-new-league-icon.png"]];
	[BeeUITipsCenter setDefaultSuccessIcon:[UIImage imageNamed:@"index-new-league-icon.png"]];
	[BeeUITipsCenter setDefaultFailureIcon:[UIImage imageNamed:@"index-new-league-icon.png"]];
	
	[BeeUINavigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar.png"]];
	[BeeUINavigationBar setTitleColor:[UIColor whiteColor]];
    self.window.rootViewController=[AppBoard sharedInstance];
    
    [BeeUITipsCenter setDefaultContainerView:self.window.rootViewController.view];
}
@end
