//
//  BasePlanet.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BasePlanet.h"

@implementation BasePlanet

- (NSString*)activePrimaryKey{
    return @"target_body_code";
}



- (void)dealloc{
    [_target_body_code release];
    [_target_body_name release];
    [_center_body_name release];
    [_center_radii release];
    [_center_geoetic release];
    [_target_primary release];
    [_target_radii release];
    [_distance_time release];
    [_current_distance release];
    [super dealloc];
}
@end
