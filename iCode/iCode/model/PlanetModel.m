//
//  PlanetModel.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PlanetModel.h"
#import "BasePlanet.h"

@implementation PlanetModel

- (NSArray*)getPlanets{
    return BasePlanet.DB.GET_RECORDS();
}


- (NSArray*)savePlanets:(NSArray*)plantes{
    return BasePlanet.DB.SAVE_ARRAY(plantes);
}

@end
