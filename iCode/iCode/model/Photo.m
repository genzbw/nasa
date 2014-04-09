//
//  Photo.m
//  iCode
//
//  Created by hjx on 2014-04-08.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "Photo.h"
@implementation Photo

- (void)dealloc{
    [_id release];
    [_owner release];
    [_secret release];
    [_server release];
    [_title release];
    [super dealloc];
}


- (NSString*)url{
    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@.jpg",self.farm,self.server,self.id,self.secret];
}


+ (Photo*)photoWithDict:(NSDictionary*)dict{
    Photo *photo=[Photo new];
    photo.id=[dict objectForKey:@"id"];
    photo.dateFaved=[[dict objectForKey:@"date_faved"] longLongValue];
    photo.farm=[[dict objectForKey:@"farm"] integerValue];
    photo.isFamily=[[dict objectForKey:@"isfamily"] boolValue];
    photo.isFriend=[[dict objectForKey:@"isfriend"] boolValue];
    photo.isPublic=[[dict objectForKey:@"ispublic"] boolValue];
    photo.owner=[dict objectForKey:@"owner"];
    photo.secret=[dict objectForKey:@"secret"];
    photo.server=[dict objectForKey:@"server"];
    photo.title=[dict objectForKey:@"title"];
    return [photo autorelease];
}

@end
