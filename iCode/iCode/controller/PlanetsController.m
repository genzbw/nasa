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
        msg.GET([NSString stringWithFormat:@"%@full_list_query",iCodeRoot]);
    }else{
        [self doResponse:msg];
    }
}


- (void) PLANTS_DISTANCE_INFO:(BeeMessage*)msg{
    if (msg.sending) {
        NSArray *datas=msg.GET_INPUT(@"distanceDatas");
        NSString *result=[datas JSONString];
        NSLog(@"%@",result);
        msg.OUTPUT(@"result",datas);
        //msg.POST([NSString stringWithFormat:@"%@attr_query?jsonData=%@",iCodeRoot,result]);
    }else{
        [self doResponse:msg];
    }
}

- (void)buildData:(BeeMessage *)message{
    if ([message is:self.PLANTS_LIST]) {
        NSMutableArray *returnDatas=[NSMutableArray array];
        NSArray *data=message.responseJSONArray;
        for (NSDictionary *dict in data) {
           [returnDatas addObject:[BasePlanet recordFromDictionary:dict]];
        }
        message.OUTPUT(@"result",[self.model savePlanets:returnDatas]);
    }
}

@end
