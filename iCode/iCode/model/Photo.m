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


- (NSString*)activePrimaryKey{
    return @"id";
}


- (NSString*)url{
    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@.jpg",[self.farm integerValue],self.server,self.id,self.secret];
}
@end
