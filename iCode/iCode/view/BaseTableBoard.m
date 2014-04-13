//
//  BaseTableBoard.m
//  iCode
//
//  Created by hjx on 2014-04-11.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseTableBoard.h"

@interface BaseTableBoard (){
    BOOL _reloading;
}


@property (nonatomic,strong) EGORefreshTableHeaderView *refreshHeaderView;

@end

@implementation BaseTableBoard

- (void)load{
    _needRefeshHeaderView=YES;
}



- (UITableViewCell*)getCellWithData:(id)data{
    return nil;
}


- (EGORefreshTableHeaderView*)getRefreshHeaderView{
    return _refreshHeaderView;
}


- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.view.backgroundColor=[UIColor clearColor];
        UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectZero];
        tableView.backgroundColor=[UIColor blackColor];
        self.tableView=tableView;
        [tableView release];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableView];
        if (_needRefeshHeaderView) {
            EGORefreshTableHeaderView* view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectZero];
            view.delegate = self;
            [self.tableView addSubview:view];
            _refreshHeaderView=view;
            _refreshHeaderView.hidden=YES;
            [view release];
        }
    }else if ([signal is:BeeUIBoard.LAYOUT_VIEWS]){
        //NSLog(@"self:%@,tableView:%@",self,self.tableView);
        if (self.navigationBarShown) {
            self.tableView.frame=CGRectMake(self.view.origin.x, self.view.origin.y+self.navigationController.navigationBar.height, self.view.width, self.view.height-self.navigationController.navigationBar.height);
        }else{
            self.tableView.frame=self.view.bounds;
        }
    }
}



#pragma mark -- 
#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

- (void)dealloc{
    [_tableView release];
    [_refreshHeaderView release];
    [super dealloc];
}

@end
