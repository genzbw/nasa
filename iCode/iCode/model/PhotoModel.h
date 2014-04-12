//
//  PhotoModel.h
//  iCode
//
//  Created by hjx on 2014-04-09.
//  Copyright (c) 2014 gen. All rights reserved.
//

@interface PhotoModel : BeeModel

/**
 *  persistence datas
 *
 *  @param photos detached objects
 *
 *  @return persistence datas
 */
- (NSArray*)savePhotos:(NSArray*)photos;


/**
 *  get all datas which persistence in database
 *
 *  @return photos
 */
- (NSArray*)getPhotos;


/**
 *  the total counts of database
 *
 *  @return 
 */
- (NSInteger)totalCounts;

@end
