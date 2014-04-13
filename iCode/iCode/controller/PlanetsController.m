//
//  PlanetsController.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PlanetsController.h"
#import "BasePlanet.h"
#import "PlanetModel.h"
#import "BasePlanetDistance.h"
#import "NSString+URLEscapingAdditions.h"

@implementation PlanetsController

DEF_MESSAGE(PLANTS_LIST)

DEF_MESSAGE(PLANTS_DISTANCE_INFO)

- (void)load{
    self.model=[[PlanetModel new] autorelease];
}


- (void)unload{
    [_model release];
}


- (void)loadFromCache:(BeeMessage *)message{
    if ([message is:self.PLANTS_LIST]) {
        NSArray *planets=[self.model getPlanets];
        message.OUTPUT(@"result",planets);
    }
}

- (void) PLANTS_LIST:(BeeMessage*)msg{
    if (msg.sending) {
        msg.GET([NSString stringWithFormat:@"%@asteroid",iCodeRoot]);
    }else{
        [self doResponse:msg];
    }
}

-(NSString *)getUTCFormateDate:(NSDate *)localDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd%20HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    [dateFormatter release];
    return dateString;
}

/**
 *  date time formatter 2014-Apr-13 12:00
 *
 *  @param msg
 */
- (void) PLANTS_DISTANCE_INFO:(BeeMessage*)msg{
    if (msg.sending) {
        NSString *date=[self getUTCFormateDate:[NSDate date]];
        [msg GET:[NSString stringWithFormat:@"%@current?utc=%@&lat=20&lon=20",iCodeRoot,date]];
    }else{
        [self doResponse:msg];
    }
}

- (void)buildData:(BeeMessage *)message{
    if ([message is:self.PLANTS_LIST]) {
        NSMutableArray *returnDatas=[NSMutableArray array];
        NSDictionary *dict=message.responseJSONDictionary;
        //NSLog(@"%@",dict);
        NSArray *items= [dict objectForKey:@"_items"];
        for (NSDictionary *item in items) {
            [returnDatas addObject:[BasePlanet objectFromDictionary:item]];
        }
        message.OUTPUT(@"result",[self.model savePlanets:returnDatas]);
    }else if([message is:self.PLANTS_DISTANCE_INFO]){
        NSArray *datas=message.responseJSONArray;
        NSMutableArray *returnDatas=[NSMutableArray array];
        for (NSDictionary *dict in datas) {
            [returnDatas addObject:[BasePlanetDistance objectFromDictionary:dict]];
        }
        message.OUTPUT(@"result",returnDatas);
    }
}

@end
