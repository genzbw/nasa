//
//  PlanetsBoard.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PlanetsBoard.h"
#import "PlanetBoardCell.h"

@interface PlanetsBoard ()

@property (nonatomic,strong) NSArray *datas;

@end

@implementation PlanetsBoard

- (void)dealloc{
    [_datas release];
    [super dealloc];
}

- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"Planets";
    }else if([signal is:BeeUIBoard.LOAD_DATAS]){
        self.datas=[NSArray arrayWithObjects:@"Planet 1",@"Planet 2",@"Planet 3", nil];
    }else if ([signal is:BeeUIBoard.LAYOUT_VIEWS]){
        self.tableView.top=44;
        self.tableView.height=self.tableView.height-44*2;
        NSLog(@"self:%@,tableView:%@",self,self.tableView);
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
        cell=[[[PlanetBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    }
    NSString *title= [self.datas objectAtIndex:indexPath.row];
    [cell.textLabel setText:title];
    return cell;
}

@end
