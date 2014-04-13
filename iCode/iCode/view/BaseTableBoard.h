//
//  BaseTableBoard.h
//  iCode
//
//  Created by hjx on 2014-04-11.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"
#import "EGORefreshTableHeaderView.h"

@interface BaseTableBoard : BaseBoard<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) BOOL needRefeshHeaderView;


- (UITableViewCell*)getCellWithData:(id)data;


- (EGORefreshTableHeaderView*)getRefreshHeaderView;


- (void)reloadTableViewDataSource;


- (void)doneLoadingTableViewData;


@end
