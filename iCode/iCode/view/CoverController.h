//
//  CoverController.h
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanetDetailBoard.h"
@class BasePlanet;
@interface CoverController : UIViewController<DetailControllerDelegate>


@property (nonatomic,assign) UIViewController *modalController;

+ (CoverController*)sharedCoverController;

-(void)showPlanetDetailController:(BasePlanet*)planet;

@end
