//
//  PlanetDetailBoard.h
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"



@class BasePlanet;
@protocol DetailControllerDelegate;

@interface PlanetDetailBoard : BaseBoard

@property (nonatomic,assign) id<DetailControllerDelegate> delegate;

- (id)initWithPlanet:(BasePlanet*)planet;

@end

@protocol DetailControllerDelegate <NSObject>
-(void)modalViewControllerShouldClose:(PlanetDetailBoard *)viewController;
@end
