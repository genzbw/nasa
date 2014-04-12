//
//  UserController.m
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "UserController.h"
#import "Photo.h"
#import "PhotoModel.h"
@implementation UserController

DEF_MESSAGE(USER_LOGIN)

DEF_MESSAGE(USER_FAVORITE)

- (void)load{
    self.model=[[PhotoModel new] autorelease];
}


- (void)unload{
    [_model release];
}


- (void)loadFromCache:(BeeMessage *)message{
    if ([message is:self.USER_FAVORITE]) {
        [self.model totalCounts];
        NSArray *photos=[self.model getPhotos];
        message.succeed=true;
        message.OUTPUT(@"result",photos);
    }
}



- (void) USER_LOGIN:(BeeMessage*)msg{
    if (msg.sending) {
        NSArray *params=[NSArray arrayWithObject:[OauthParameter OauthParameterWithName:@"method" value:@"flickr.test.login"]];
        [msg GET:[self.store getRestApiUrl:params]];
    }else{
        [self doResponse:msg];
    }
}


- (void) USER_FAVORITE:(BeeMessage*)msg{
    if (msg.sending) {
        NSMutableArray *params=[NSMutableArray array];
        [params addObject:[OauthParameter OauthParameterWithName:@"user_id" value:[OauthCredentialStore sharedInstance].userInfo.userId]];
        [params addObject:[OauthParameter OauthParameterWithName:@"method" value:@"flickr.favorites.getList"]];
        [msg setUseCache:YES];
        [msg GET:[self.store getRestApiUrl:params]];
    }else{
        [self doResponse:msg];
    }
}


- (void)buildData:(BeeMessage *)message{
    if ([message is:UserController.USER_LOGIN]) {
        
    }else if([message is:UserController.USER_FAVORITE]){
        NSMutableArray *returnDatas=[NSMutableArray array];
        NSDictionary *data=message.responseJSONDictionary;
        NSArray *photos=[[data objectForKey:@"photos"] objectForKey:@"photo"];
        for (NSDictionary *photo in photos) {
            [returnDatas addObject:[Photo recordFromDictionary:photo]];
        }
        [self.model savePhotos:returnDatas];
        message.OUTPUT(@"result",[self.model savePhotos:returnDatas]);
    }
}

@end
