//
//  BasePlanet.h
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

@interface BasePlanet :BeeActiveRecord

@property (nonatomic,copy) NSString *target_body_code;

@property (nonatomic,copy) NSString *target_body_name;

@property (nonatomic,copy) NSString *center_geoetic;

@property (nonatomic,copy) NSString *center_radii;

@property (nonatomic,copy) NSString *center_body_name;

@property (nonatomic,copy) NSString *target_primary;

@property (nonatomic,copy) NSString *target_radii;

@property (nonatomic,copy) NSString *distance_time;

@property (nonatomic,copy) NSString *current_distance;

@end
