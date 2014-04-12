//
//  ConfigBoard.m
//  iCode
//
//  Created by hjx on 2014-04-09.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "ConfigBoard.h"
#import "AppBoard.h"

@interface ConfigBoard ()

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *datas;

@end

@implementation ConfigBoard


- (void)dealloc{
    [_datas release];
    [_tableView release];
    [super dealloc];
}

- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"config";
        self.tableView=[[[BeeUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableView];
    }else if([signal is:BeeUIBoard.LOAD_DATAS]){
        self.datas=[NSArray arrayWithObjects:@"alert",nil];
    }else if([signal is:BeeUISwitch.ON]) {
        if ([Global sharedInstance].alertSwitchOn!=YES) {
            [Global sharedInstance].alertSwitchOn=YES;
            [BeeUserDefaults userDefaultsWrite:[NSNumber numberWithBool:YES] forKey:UserAlertSwitchKey];
        }
    }else if([signal is:BeeUISwitch.OFF]){
        if ([Global sharedInstance].alertSwitchOn!=NO) {
            [Global sharedInstance].alertSwitchOn=NO;
            [BeeUserDefaults userDefaultsWrite:[NSNumber numberWithBool:NO]
                                        forKey:UserAlertSwitchKey];
        }
    }
}


#pragma mark -- table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"System";
    }else{
        return @"Other";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"ImageViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
        BeeUISwitch *switchView=[[BeeUISwitch alloc] initWithFrame:CGRectMake(self.width-60, 7, 60, 20)];
        [switchView setOn:[Global sharedInstance].alertSwitchOn];
        [cell.contentView addSubview:switchView];
        [switchView release];
    }
    [[cell textLabel] setText:[self.datas objectAtIndex:indexPath.row]];
    return cell;
}

@end
