//
//  OauthController.m
//  iCode
//
//  Created by hjx on 2014-04-02.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "OauthController.h"

@implementation OauthController

DEF_MESSAGE(GET_REQUEST_TOKEN)
DEF_MESSAGE(GET_ACCESS_TOKEN)

- (void) dealloc{
    [super dealloc];
}

- (void) load{
    [super load];
}

/**
 *  Get a request Token
 *  oauth_consumer_key
 *  oauth_nonce
 *  oauth_signature_method
 *  oauth_timestamp
 *  oauth_callback
 *  oauth_version(optional)
 */
- (void) GET_REQUEST_TOKEN:(BeeMessage*)msg{
    if (msg.sending) {
        [msg GET:[self.store getRequestTokenUrl]];
    }else if(msg.succeed){
        NSString *result=msg.responseString;
        if(nil==result){
            msg.failed=YES;
            return;
        }
        msg.OUTPUT(@"result",[OauthParameter responseParameters:result]);
    }else if(msg.failed){
        
    }
}


- (void) GET_ACCESS_TOKEN:(BeeMessage*)msg{
    if (msg.sending) {
        NSString *requestToken=msg.GET_INPUT(@"requestToken");
        NSString *requstTokenSecret=msg.GET_INPUT(@"requestTokenSecret");
        NSString *verifier=msg.GET_INPUT(@"verifier");
        [msg GET:[self.store requestAccessToken:verifier token:requestToken secret:requstTokenSecret]];
    }else if(msg.succeed){
        NSString *result=msg.responseString;
        if(nil==result){
            msg.failed=YES;
            return;
        }
        msg.OUTPUT(@"result",[OauthParameter responseParameters:result]);
    }else if(msg.failed){
        
    }
}
@end
