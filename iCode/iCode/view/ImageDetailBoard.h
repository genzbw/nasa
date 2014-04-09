//
//  ImageDetailBoard.h
//  iCode
//
//  Created by hjx on 2014-04-09.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"
#import "Photo.h"

@interface ImageDetailBoard : BaseBoard

/**
 *  init photo
 *  and display photo
 *  @param photo
 *  @return
 */
- (id)initWithPhoto:(Photo*)photo;

@end
