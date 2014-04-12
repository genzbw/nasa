//
//  Photo.h
//  iCode
//
//  Created by hjx on 2014-04-08.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Photo : BeeActiveRecord

@property (nonatomic,copy) NSString* id;

@property (nonatomic,retain) NSNumber* date_faved;

@property (nonatomic,retain) NSNumber* farm;

@property (nonatomic,strong) NSNumber* isfamily;

@property (nonatomic,strong) NSNumber* isfriend;

@property (nonatomic,strong) NSNumber* ispublic;

@property (nonatomic,copy) NSString* owner;

@property (nonatomic,copy) NSString* secret;

@property (nonatomic,copy) NSString* server;

@property (nonatomic,copy) NSString* title;


/**
 *  photo url
 *  @return
 */
- (NSString*)url;

@end
