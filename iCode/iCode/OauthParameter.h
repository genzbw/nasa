//
//  OauthParameter.h
//  iCode
//
//  Created by hjx on 2014-04-06.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Oauth Parameter should be coded before send
 *  and sorted by dictionary regular
 */
@interface OauthParameter : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *value;


- (NSString *)parameterStr;

+ (id)OauthParameterWithName:(NSString*) name value:(NSString*)value;

+ (NSString *)parameterStringForParameters:(NSArray *)inParameters;

/**
 *  this method charge for parse return str
 *  @param responseStr accept request return str
 *  @return parameters
 */
+ (NSArray*)responseParameters:(NSString*)responseStr;


/**
 *  get parameter from parameters list
 *  @param parameters
 *  @param name
 *  @return
 */
+ (OauthParameter*)getParameter:(NSArray*)parameters byName:(NSString*)name;


@end
