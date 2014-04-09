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
#define  ErrorDomainServer @"server"
#define  ErrorDomainClient @"client"
@interface BaseController : BeeController

@property (nonatomic,assign) OauthCredentialStore *store;
/**
 *  when message has errors,
 *  we need unify deal
 *  @param error
 */
- (void)doMessageError:(BeeMessage*)error;


/**
 *  when request response
 *  we need unify deal
 *  @param message
 */
- (void)doResponse:(BeeMessage*)message;



/**
 *  whatever request data from remote server or
 *  request data from local database
 *  we use build data to deal data
 *  @param message 
 */
- (void)buildData:(BeeMessage*)message;

@end
