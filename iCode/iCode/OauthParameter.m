//
//  OauthParameter.m
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "OauthParameter.h"
#import "NSString+URLEscapingAdditions.h"

@implementation OauthParameter

- (void)dealloc{
    [_name release];
    [_value release];
    [super dealloc];
}

- (NSString *)parameterStr{
    return [NSString stringWithFormat:@"%@=%@", [self.name stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding], self.value ? [self.value stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding]:@""];
}



- (NSComparisonResult)compare:(id)inObject {
	NSComparisonResult result = [self.name compare:[(OauthParameter *)inObject name]];
	if (result == NSOrderedSame) {
		result = [self.value compare:[(OauthParameter *)inObject value]];
	}
	return result;
}


+ (id)OauthParameterWithName:(NSString*) name value:(NSString*)value{
    OauthParameter *parameter=[[self alloc] init];
    parameter.name=name;
    parameter.value=value;
    return [parameter autorelease];
}

+ (NSString *)parameterStringForParameters:(NSArray *)inParameters {
    NSMutableString *encodeString=[NSMutableString string];
    NSInteger i=0;
    for (OauthParameter *parameter in inParameters) {
        if (i>0) {
            [encodeString appendString:@"&"];
        }
        [encodeString appendString:[parameter parameterStr]];
        i++;
    }
    return encodeString;
}

+ (NSArray*)responseParameters:(NSString*)responseStr{
    NSMutableArray *foundParameters = [NSMutableArray arrayWithCapacity:10];
	if (responseStr) {
		NSScanner *parameterScanner = [[NSScanner alloc] initWithString:responseStr];
		NSString *name = nil;
		NSString *value = nil;
		while (![parameterScanner isAtEnd]) {
			name = nil;
			value = nil;
			[parameterScanner scanUpToString:@"=" intoString:&name];
			[parameterScanner scanString:@"=" intoString:NULL];
			[parameterScanner scanUpToString:@"&" intoString:&value];
			[parameterScanner scanString:@"&" intoString:NULL];
			if (name && value) {
				[foundParameters addObject:[OauthParameter OauthParameterWithName:name value:value]];
			}
		}
		[parameterScanner release];
	}
	return foundParameters;
}


+ (OauthParameter*)getParameter:(NSArray*)parameters byName:(NSString*)name{
    for (OauthParameter *param in parameters) {
        if([param.name isEqual:name]){
            return param;
        }
    }
    return nil;
}

@end
