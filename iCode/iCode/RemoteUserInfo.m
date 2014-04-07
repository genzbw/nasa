//
//  RemoteUserInfo.m
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "RemoteUserInfo.h"

@implementation RemoteUserInfo


- (void)dealloc{
    [_userId release];
    [_fullName release];
    [_oauthToken release];
    [_oauthTokenSecret release];
    [_userName release];
    [super dealloc];
}

@end
