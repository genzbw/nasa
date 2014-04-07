//
//  BaseController.h
//  iCode
//
//  Created by hjx on 2014-04-02.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OauthCredentialStore.h"
#import "OauthParameter.h"
@interface BaseController : BeeController

@property (nonatomic,assign) OauthCredentialStore *store;

@end
