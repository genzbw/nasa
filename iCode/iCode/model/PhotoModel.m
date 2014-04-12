//
//  PhotoModel.m
//  iCode
//
//  Created by hjx on 2014-04-09.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PhotoModel.h"
#import "Photo.h"
@implementation PhotoModel

- (NSInteger)totalCounts{
    return Photo.DB.total;
}


- (NSArray*)savePhotos:(NSArray*)photos{
   return Photo.DB.SAVE_ARRAY(photos);
}


- (NSArray*)getPhotos{
    return Photo.DB.GET_RECORDS();
}


@end
