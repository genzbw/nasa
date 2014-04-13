//
//  CoverController.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "CoverController.h"
#import "PlanetDetailBoard.h"
#import "BaseBoard.h"
@interface CoverController ()

@property (nonatomic,strong) UIWindow *window;

@end

@implementation CoverController


- (void)dealloc{
    [_window release];
    [super dealloc];
}

+ (CoverController*)sharedCoverController{
    static dispatch_once_t once=NULL;
    static id __singleton__;
    dispatch_once(&once,^{
            __singleton__ = [[self alloc] init];
    } );
    return __singleton__;
}


-(void)showWindow{
    self.window = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.window.backgroundColor =[UIColor blackColor];
    self.window.windowLevel = UIWindowLevelStatusBar;
    self.window.rootViewController = self.modalController;
    [self.window makeKeyAndVisible];
}


-(void)showPlanetDetailController:(BasePlanet*)planet{
    PlanetDetailBoard *planetDetailController = [[PlanetDetailBoard alloc]initWithPlanet:planet];
    planetDetailController.delegate = self;
    self.modalController = planetDetailController;
    [planetDetailController release];
    [self showWindow];
}

#pragma mark TSModalViewControllerDelegate
-(void)modalViewControllerShouldClose:(UIViewController *)viewController{
    self.modalController=nil;
    self.window=nil;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

@end
