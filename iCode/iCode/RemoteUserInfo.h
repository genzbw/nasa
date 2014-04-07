//
//  RemoteUserInfo.h
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteUserInfo : NSObject

@property (nonatomic,copy) NSString *fullName;

@property (nonatomic,copy) NSString *oauthToken;

@property (nonatomic,copy) NSString *oauthTokenSecret;

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *userName;

@end
