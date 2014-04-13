//
//  BasePlanetDistance.h
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BasePlanet.h"

@interface BasePlanetDistance : BeeActiveObject

@property (nonatomic,copy) NSString *target_body_code;

@property (nonatomic,copy) NSString *distance_time;

@property (nonatomic,copy) NSString *current_distance;


+ (id)ObjectWithBasePlanet:(BasePlanet*)basePlanet;

@end
