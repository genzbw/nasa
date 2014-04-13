//
//  PlanetsController.h
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseController.h"
#import "PlanetModel.h"

@interface PlanetsController : BaseController

@property (nonatomic,strong) PlanetModel *model;

AS_MESSAGE(PLANTS_LIST)

AS_MESSAGE(PLANTS_DISTANCE_INFO)

@end
