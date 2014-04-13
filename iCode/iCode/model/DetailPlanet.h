//
//  DetailPlanet.h
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BasePlanet.h"

@interface DetailPlanet : BasePlanet

@property (nonatomic,copy) NSString *center_geoetic;

@property (nonatomic,copy) NSString *center_radii;

@property (nonatomic,copy) NSString *center_body_name;

@property (nonatomic,copy) NSString *target_primary;

@property (nonatomic,copy) NSString *target_radii;

@end
