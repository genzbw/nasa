//
//  UserController.m
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "UserController.h"

@implementation UserController

DEF_MESSAGE(USER_LOGIN)

- (void) USER_LOGIN:(BeeMessage*)msg{
    if (msg.sending) {
        [msg GET:[self.store getRestApiUrl:@"flickr.test.login"]];
    }else if(msg.succeed){
        NSDictionary *result=msg.responseJSONDictionary;
        NSLog(@"%@",result);
        if(nil==result){
            msg.failed=YES;
            return;
        }
        msg.OUTPUT(@"result",result);
    }else if(msg.failed){
        
    }
}

@end
