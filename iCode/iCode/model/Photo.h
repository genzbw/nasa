//
//  Photo.h
//  iCode
//
//  Created by hjx on 2014-04-08.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Photo : NSObject

@property (nonatomic,assign) long long dateFaved;

@property (nonatomic,assign) NSInteger farm;

@property (nonatomic,copy) NSString *id;

@property (nonatomic,assign) BOOL isFamily;

@property (nonatomic,assign) BOOL isFriend;

@property (nonatomic,assign) BOOL isPublic;

@property (nonatomic,copy) NSString *owner;

@property (nonatomic,copy) NSString *secret;

@property (nonatomic,copy) NSString *server;

@property (nonatomic,copy) NSString *title;


/**
 *  photo url
 *  @return
 */
- (NSString*)url;

/**
 *  static method use to constuct photo 
 *  object with dict
 *  @param dict response dict
 *  @return Photo
 */
+ (Photo*)photoWithDict:(NSDictionary*)dict;

@end
