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
    return @"aid";
}



- (void)dealloc{
    [_name release];
    [_aid release];
    [_primary release];
    [_radii release];
    [_distance_time release];
    [_current_distance release];
    [super dealloc];
}
@end
