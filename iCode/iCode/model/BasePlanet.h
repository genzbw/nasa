//
//  BasePlanet.h
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

@interface BasePlanet :BeeActiveRecord

/**
 *  asteroid name
 */
@property (nonatomic,copy) NSString *name;

/**
 *  primary
 */
@property (nonatomic,copy) NSString *primary;


/**
 *  raddii
 */
@property (nonatomic,copy) NSString *radii;


/**
 *  aid
 */
@property (nonatomic,copy) NSString *aid;

/**
 *  from earth to distance_time
 */
@property (nonatomic,copy) NSString *distance_time;


/**
 *  current_distance
 */
@property (nonatomic,copy) NSString *current_distance;

@end
