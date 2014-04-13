//
//  BasePlanetDistance.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BasePlanetDistance.h"

@implementation BasePlanetDistance

- (void)dealloc{
    [_aid release];
    [_lt release];
    [_alt release];
    [_azi release];
    [super dealloc];
}

@end
