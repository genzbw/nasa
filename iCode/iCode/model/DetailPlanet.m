//
//  DetailPlanet.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "DetailPlanet.h"

@implementation DetailPlanet

- (void)dealloc{
    [_center_body_name release];
    [_center_radii release];
    [_center_geoetic release];
    [_target_primary release];
    [super dealloc];
}

@end
