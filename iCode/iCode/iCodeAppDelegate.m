//
//  iCodeAppDelegate.m
//  iCode
//
//  Created by hjx on 2014-04-02.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "iCodeAppDelegate.h"
#import "MainBoard.h"
#import "RemoteUserInfo.h"
#import "OauthCredentialStore.h"
@implementation iCodeAppDelegate

- (void)load{
    bee.ui.config.ASR = YES;
	bee.ui.config.iOS7Mode = YES;
	bee.ui.config.cacheAsyncLoad = YES;
	bee.ui.config.cacheAsyncSave = YES;
    [self observeNotification:BeeUIApplication.LAUNCHED];
    self.window.rootViewController=[MainBoard sharedInstance];
}


- (void)handleNotification:(NSNotification *)notification{
    if ([notification is:BeeUIApplication.LAUNCHED]) {
        NSData *remoteUserInfo=[BeeUserDefaults userDefaultsRead:UserOauthInfoKey];
        RemoteUserInfo *userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:remoteUserInfo];
        if (userInfo) {
            [OauthCredentialStore sharedInstance].userInfo=userInfo;
        }
    }
}
@end
