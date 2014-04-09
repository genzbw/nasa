//
//  OauthCredentialStore.h
//  iCode
//
//  Created by hjx on 2014-04-05.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteUserInfo.h"

#define oauthBaseUrl @"https://www.flickr.com/services/"
#define oauthConsumerValue @"ec0a6bfdf924bb4a1af0a1f12f5261c9"
#define oauthConsumerSecret @"f4b11b5acce7c5dc"

#define oauthNonceKey @"oauth_nonce"
#define oauthTimestampKey @"oauth_timestamp"
#define oauthConsumerKey @"oauth_consumer_key"
#define oauthSignatureMethod @"oauth_signature_method"
#define oauthSignatureMethodValue @"HMAC-SHA1"
#define oauthSignatureKey @"oauth_signature"
#define oauthVersionValue @"1.0"
#define oauthVersionKey @"oauth_version"
#define oauthCallbackKey @"oauth_callback"

@interface OauthCredentialStore : NSObject


AS_SINGLETON(OauthCredentialStore)

@property (nonatomic,strong) RemoteUserInfo *userInfo;

/**
 *  oauth should get request token
 */
- (NSString*) getRequestTokenUrl;

/**
 *  use request token to change access token
 *
 *  @param verifier user authorized code
 *  @param token request token
 *  @param secret   request secret
 *
 *  @return accessUrl
 */
- (NSString*) requestAccessToken:(NSString*)verifier token:(NSString*)token secret:(NSString*)secret;


/**
 *  get rest api url
 *
 *  @param method request method
 *
 *  @return api url
 */
- (NSString*)getRestApiUrl:(NSArray*)params;

@end
