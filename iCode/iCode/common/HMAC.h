//
//  HMAC.h
//  iCode
//
//  Created by hjx on 2014-04-03.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
@interface HMAC : NSObject

/**
 *  SHA1 algorithm
 *
 *  @param data orgin
 *  @param inSecret use to signature
 *
 *  @return degist
 */
+ (NSString*)SHA1:(NSString*)data usingSecret:(NSString *)inSecret;

@end
