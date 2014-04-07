//
//  HMAC.m
//  iCode
//
//  Created by hjx on 2014-04-03.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "HMAC.h"
#import "Base64Transcoder.h"
@implementation HMAC

+ (NSString*)SHA1:(NSString*)data usingSecret:(NSString *)inSecret{
    NSData *secretData = [inSecret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *textData = [data dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
    
	CCHmacContext hmacContext;
	bzero(&hmacContext, sizeof(CCHmacContext));
    CCHmacInit(&hmacContext, kCCHmacAlgSHA1, secretData.bytes, secretData.length);
    CCHmacUpdate(&hmacContext, textData.bytes, textData.length);
    CCHmacFinal(&hmacContext, result);
	
	//Base64 Encoding
	char base64Result[32];
	size_t theResultLength = 32;
	Base64EncodeData(result, 20, base64Result, &theResultLength);
	NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
	NSString *base64EncodedResult = [[[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding] autorelease];
	
	return base64EncodedResult;
}

@end
