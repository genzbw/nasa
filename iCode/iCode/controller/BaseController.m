//
//  BaseController.m
//  iCode
//
//  Created by hjx on 2014-04-02.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseController.h"

@implementation BaseController

- (void)load{
    [super load];
    _store=[OauthCredentialStore sharedInstance];
}

@end
