//
//  RemoteUserInfo.m
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "RemoteUserInfo.h"

@implementation RemoteUserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder{
    if (self) {
        [aCoder encodeObject:_fullName forKey:fullNameKey];
        [aCoder encodeObject:_userId forKey:oauthUserIdKey];
        [aCoder encodeObject:_userName forKey:oauthUserNameKey];
        [aCoder encodeObject:_oauthToken forKey:accessTokenKey];
        [aCoder encodeObject:_oauthTokenSecret forKey:accessTokenSecretKey];
    }
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        _fullName=[[aDecoder decodeObjectForKey:fullNameKey] copy];
        _userName=[[aDecoder decodeObjectForKey:oauthUserNameKey] copy];
        _userId=[[aDecoder decodeObjectForKey:oauthUserIdKey] copy];
        _oauthToken=[[aDecoder decodeObjectForKey:accessTokenKey] copy];
        _oauthTokenSecret=[[aDecoder decodeObjectForKey:accessTokenSecretKey] copy];
    }
    return self;
}

- (void)dealloc{
    [_userId release];
    [_fullName release];
    [_oauthToken release];
    [_oauthTokenSecret release];
    [_userName release];
    [super dealloc];
}

@end
