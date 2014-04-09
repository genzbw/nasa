//
//  OauthCredentialStore.m
//  iCode
//
//  Created by hjx on 2014-04-05.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "OauthCredentialStore.h"
#import "HMAC.h"
#import "NSString+URLEscapingAdditions.h"

#define requestTokenUrl @"oauth/request_token"
#define accessTokenUrl @"oauth/access_token"
#define apiUrl @"rest"
#import "OauthParameter.h"
@implementation OauthCredentialStore

DEF_SINGLETON(OauthCredentialStore)

- (void) dealloc{
    [_userInfo release];
    [super dealloc];
}


/**
 *  request parameter
 *  @return oauth_timestamp
 */
- (NSString *)timestamp {
	return [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
}


/**
 *  request parameter
 *  @return oauth_nonce
 */
- (NSString *)oauthNonce {
	CFUUIDRef generatedUUID = CFUUIDCreate(kCFAllocatorDefault);
	NSString *oauthNonce=[NSString stringWithFormat:@"%@",(NSString *)CFUUIDCreateString(kCFAllocatorDefault, generatedUUID)];
	CFRelease(generatedUUID);
    return oauthNonce;
}

/**
 *  signature url
 *
 *  @param url a string want to be signature
 *
 *  @return real request url
 */
- (NSString*)signature:(NSString*)url parameters:(NSString*)parameters method:(NSString*)method secret:(NSString*)secret{
    NSString *result= [NSString stringWithFormat:@"%@&%@&%@",[method stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding],
    [url stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding],
    [parameters stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [HMAC SHA1:result usingSecret:[NSString stringWithFormat:@"%@&%@",oauthConsumerSecret,secret]];
}

- (NSURL *)callbackURLForCompletedUserAuthorization {
	return [NSURL URLWithString:@"x-com-icode-oauth://success"];
}

- (NSString*) getRequestTokenUrl{
    NSMutableString *str=[NSMutableString stringWithString:oauthBaseUrl];
    [str appendString:requestTokenUrl];
    NSMutableArray *parameters=[NSMutableArray arrayWithCapacity:7];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthCallbackKey value:[[self callbackURLForCompletedUserAuthorization] absoluteString]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthConsumerKey value:oauthConsumerValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthNonceKey value:[self oauthNonce]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthSignatureMethod value:oauthSignatureMethodValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthTimestampKey value:[self timestamp]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthVersionKey value:oauthVersionValue]];
    NSMutableString *parameterStr=[NSMutableString stringWithString:[OauthParameter parameterStringForParameters:parameters]];
    OauthParameter *signatureP=[OauthParameter OauthParameterWithName:oauthSignatureKey value:[self signature:str parameters:parameterStr method:@"GET" secret:@""]];
    [parameterStr appendFormat:@"&%@",[signatureP parameterStr]];
    [str appendFormat:@"?%@",parameterStr];
    return str;
}


- (NSString*) requestAccessToken:(NSString*)verifier token:(NSString*)token secret:(NSString*)secret{
    NSMutableString *str=[NSMutableString stringWithString:oauthBaseUrl];
    [str appendString:accessTokenUrl];
    NSMutableArray *parameters=[NSMutableArray arrayWithCapacity:7];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthConsumerKey value:oauthConsumerValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthNonceKey value:[self oauthNonce]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthSignatureMethod value:oauthSignatureMethodValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthTimestampKey value:[self timestamp]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthVersionKey value:oauthVersionValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:@"oauth_token" value:token]];
    [parameters addObject:[OauthParameter OauthParameterWithName:@"oauth_verifier" value:verifier]];
    [parameters sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *parameterStr=[NSMutableString stringWithString:[OauthParameter parameterStringForParameters:parameters]];
    OauthParameter *signatureP=[OauthParameter OauthParameterWithName:oauthSignatureKey value:[self signature:str parameters:parameterStr method:@"GET" secret:secret]];
    [parameterStr appendFormat:@"&%@",[signatureP parameterStr]];
    [str appendFormat:@"?%@",parameterStr];
    return str;
}


- (NSString*)getRestApiUrl:(NSArray*)params{
    NSMutableString *str=[NSMutableString stringWithString:oauthBaseUrl];
    [str appendString:apiUrl];
    NSMutableArray *parameters=[NSMutableArray arrayWithCapacity:7];
    [parameters addObject:[OauthParameter OauthParameterWithName:@"nojsoncallback" value:@"1"]];
    [parameters addObject:[OauthParameter OauthParameterWithName:@"format" value:@"json"]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthConsumerKey value:oauthConsumerValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthNonceKey value:[self oauthNonce]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthSignatureMethod value:oauthSignatureMethodValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthTimestampKey value:[self timestamp]]];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthVersionKey value:oauthVersionValue]];
    [parameters addObject:[OauthParameter OauthParameterWithName:@"oauth_token" value:self.userInfo.oauthToken]];
    [parameters addObjectsFromArray:params];
    [parameters sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *parameterStr=[NSMutableString stringWithString:[OauthParameter parameterStringForParameters:parameters]];
    OauthParameter *signatureP=[OauthParameter OauthParameterWithName:oauthSignatureKey value:[self signature:str parameters:parameterStr method:@"GET" secret:self.userInfo.oauthTokenSecret]];
    [parameterStr appendFormat:@"&%@",[signatureP parameterStr]];
    [str appendFormat:@"?%@",parameterStr];
    return str;
}

@end
