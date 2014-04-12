//
//  UserController.h
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "PhotoModel.h"

@interface UserController : BaseController

@property (nonatomic,strong) PhotoModel *model;

AS_MESSAGE(USER_LOGIN)

AS_MESSAGE(USER_FAVORITE)

@end
