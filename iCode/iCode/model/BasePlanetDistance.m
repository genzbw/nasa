//
//  BasePlanetDistance.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BasePlanetDistance.h"

@implementation BasePlanetDistance

+ (id)ObjectWithBasePlanet:(BasePlanet*)basePlanet{
    BasePlanetDistance *distance=[[self alloc] init];
    if (distance) {
        distance.target_body_code=basePlanet.target_body_code;
        distance.distance_time=basePlanet.distance_time;
    }
    return [distance autorelease];
}

- (void)dealloc{
    [_target_body_code release];
    [_distance_time release];
    [_current_distance release];
    [super dealloc];
}

@end
