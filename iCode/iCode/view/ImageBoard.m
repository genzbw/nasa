//
//  ImageBoard.m
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "ImageBoard.h"
#import "ImageFavCell.h"
#import "UserController.h"
#import "ImageDetailBoard.h"
#import "Photo.h"
#import "MainBoard.h"
@interface ImageBoard ()
@property (nonatomic,strong) NSArray *datas;

@end

@implementation ImageBoard
- (void)load{
    self.needRefeshHeaderView=NO;
}

- (void)dealloc{
    [_datas release];
    [super dealloc];
}


- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"image";
        self.datas=[NSArray array];
    }else if([signal is:BeeUIBoard.LOAD_DATAS]){
        self.MSG(UserController.USER_FAVORITE);
    }else if ([signal is:BeeUIBoard.LAYOUT_VIEWS]){
        self.tableView.top=44;
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
        cell=[[[ImageFavCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    }
    Photo *photo=[self.datas objectAtIndex:indexPath.row];
    [[cell textLabel] setText:photo.title];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Photo *photo=[self.datas objectAtIndex:indexPath.row];
    ImageDetailBoard *board=[[ImageDetailBoard alloc] initWithPhoto:photo];
    [[[BeeUIRouter sharedInstance] currentStack] pushBoard:board animated:YES];
    [board release];
}


#pragma mark -- message handle

- (void)handleMessage:(BeeMessage *)msg{
    [super handleMessage:msg];
    if ([msg is:UserController.USER_FAVORITE]) {
        NSArray *datas= msg.GET_OUTPUT(@"result");
        self.datas=datas;
        if ([self.datas count]>0) {
            [self.tableView reloadData];
        }
    }
}


@end
