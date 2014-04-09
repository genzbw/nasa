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


- (void)doMessageError:(BeeMessage*)message{
    
}


- (void)buildData:(BeeMessage*)message{

}

- (void)doResponse:(BeeMessage*)message{
    if (!message.sending) {
        NSLog(@"#########receive data#############");
        if (message.succeed) {
            NSDictionary *data=message.responseJSONDictionary;
            if (![[[data objectForKey:@"stat"]description] isEqualToString:@"fail"]) {
               [self buildData:message];
            }else{
                message.errorCode=[data objectForKey:@"code"];
                message.errorDesc=[data objectForKey:@"message"];
                message.errorDomain=ErrorDomainServer;
                message.failed=true;
                [self doMessageError:message];
            }
        }else{
            [self doMessageError:message];
        }
    }
}


@end
