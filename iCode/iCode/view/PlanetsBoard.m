//
//  PlanetsBoard.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PlanetsBoard.h"
#import "PlanetBoardCell.h"
#import "PlanetsController.h"
#import "BasePlanet.h"
#import "PlanetDetailBoard.h"
#import "BasePlanetDistance.h"
#import "CoverController.h"
@interface PlanetsBoard ()

@property (nonatomic,strong) NSArray *datas;

@property (nonatomic,assign) NSTimer *timer;

@property (nonatomic,assign) NSInteger times;

@end

@implementation PlanetsBoard

- (void)load{
    [super load];
}

- (void)dealloc{
    [self stopTimer];
    [_datas release];
    [super dealloc];
}


#pragma mark--
#pragma mark distance timer
-(void)stopTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)startTimer{
    [self stopTimer];
    _timer= [NSTimer scheduledTimerWithTimeInterval:PlanetFetchIdle target:self selector:@selector(refreshDistance) userInfo:nil repeats:YES];
}


/**
 *  refresh planet distance
 */
- (void)refreshDistance{
    NSMutableArray *sendDatas=[NSMutableArray array];
    for (BasePlanet *planet in self.datas) {
        BasePlanetDistance *distance=[BasePlanetDistance ObjectWithBasePlanet:planet];
        [sendDatas addObject:distance];
    }
    self.MSG(PlanetsController.PLANTS_DISTANCE_INFO).INPUT(@"distanceDatas",sendDatas);
}


- (void)reloadTableViewDataSource{
	[super reloadTableViewDataSource];
    self.MSG(PlanetsController.PLANTS_LIST);
}


- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"Planets";
        [self.tableView setSeparatorColor:RGB(150, 150, 150)];
    }else if([signal is:BeeUIBoard.LOAD_DATAS]){
        self.MSG(PlanetsController.PLANTS_LIST);
    }else if ([signal is:BeeUIBoard.LAYOUT_VIEWS]){
        self.tableView.top=44;
        self.tableView.height=self.tableView.height-44*2;
        self.tableView.backgroundColor=[UIColor blackColor];
    }else if([signal is:BeeUIBoard.WILL_APPEAR]){
        [self startTimer];
    }else if([signal is:BeeUIBoard.DID_DISAPPEAR]){
        [self stopTimer];
    }
}


#pragma mark -- table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"ImageViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[[PlanetBoardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.textLabel setTextColor:RGB(89, 121, 121)];
        [cell.detailTextLabel setTextColor:RGB(89, 121, 121)];
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    }
    BasePlanet *basePlanet= [self.datas objectAtIndex:indexPath.row];
    [cell.textLabel setText:basePlanet.target_body_name];
    [cell.detailTextLabel setText:@"22"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.datas count]>indexPath.row) {
        BasePlanet *planet=[self.datas objectAtIndex:indexPath.row];
        PlanetDetailBoard *board=[[PlanetDetailBoard alloc] initWithPlanet:planet];
        [[[BeeUIRouter sharedInstance] currentStack] pushBoard:board animated:NO];
        //[[CoverController sharedCoverController] showPlanetDetailController:planet];
        [board release];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


- (void)syncPlanetDistance:(NSArray*)datas{
    for (BasePlanetDistance *distance in datas) {
        int index=0;
        for (BasePlanet *planet in self.datas) {
            if ([distance.target_body_code isEqualToString:planet.target_body_code]) {
                planet.distance_time=distance.distance_time;
                distance.current_distance=[NSString stringWithFormat:@"%d",self.times*2+index];
                planet.current_distance=distance.current_distance;
                break;
            }
            index++;
        }
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"distance:%@",distance.current_distance]];
        if ([distance.current_distance intValue]<AlarmDistance) {
            [cell setBackgroundColor:[UIColor redColor]];
        }else{
            [cell setBackgroundColor:[UIColor clearColor]];
        }
    }
}


#pragma mark --
#pragma mark Message handle
- (void)handleMessage:(BeeMessage *)msg{
    [super handleMessage:msg];
    if ([msg is:PlanetsController.PLANTS_LIST]) {
        if (msg.state!=msg.STATE_SENDING) {
            NSArray *datas= msg.GET_OUTPUT(@"result");
            self.datas=datas;
            if ([self.datas count]>0) {
                [self.tableView reloadData];
            }
        }
    }else if([msg is:PlanetsController.PLANTS_DISTANCE_INFO]){
        //if (msg.state==msg.STATE_SUCCEED) {
            NSArray *datas= msg.GET_OUTPUT(@"result");
            if ([self.datas count]>0) {
                self.times++;
                [self syncPlanetDistance:datas];
            }
        //}
    }
}


@end
