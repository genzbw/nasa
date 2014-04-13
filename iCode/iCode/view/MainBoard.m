//
//  MainBoard.m
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "MainBoard.h"
#import "PlanetsBoard.h"
#import "AppBoard.h"
#import "TelescopeBoard.h"
#import "ConfigBoard.h"
#import "NSString+URLEscapingAdditions.h"
@interface MainBoard ()

@property (nonatomic,strong) BeeUITabBar *tabBar;

@end

@implementation MainBoard

DEF_SINGLETON(MainBoard)

DEF_SIGNAL(PLANETLIST)

DEF_SIGNAL(TELESCOPE)

DEF_SIGNAL(CONFIG)

- (void)dealloc{
    [_tabBar release];
    [super dealloc];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.width, self.height-20)];
    [self.view addSubview:contentView];
    self.router=[BeeUIRouter sharedInstance];
    self.router.parentBoard=self;
    BeeUIStack *st1=[BeeUIStack stackWithFirstBoardClass:[PlanetsBoard class]];
    [self.router map:@"icode://planets" toStack:st1];
    [self.router map:@"icode://telescope" toBoard:[[TelescopeBoard new] autorelease]];
    [self.router map:@"icode://config" toBoard:[[ConfigBoard new] autorelease]];
    self.router.view.autoresizingMask=UIViewAutoresizingNone;
    self.router.view.frame=CGRectMake(0,0,contentView.width,contentView.height-44);
    [contentView addSubview:self.router.view];
    UITabBarView *tabBar=[[UITabBarView alloc] initWithFrame:CGRectMake(0,contentView.height-130, contentView.width, 130)];
    tabBar.delegate=self;
    [contentView addSubview:tabBar];
    [tabBar release];
    [contentView release];
    [self sendUISignal:MainBoard.PLANETLIST];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


/**
 *  deal pic touch
 */
ON_SIGNAL2(MainBoard,signal){
    if ([signal is:MainBoard.PLANETLIST]) {
        [self.router open:@"icode://planets" animated:NO];
    }else if([signal is:MainBoard.TELESCOPE]){
        [self.router open:@"icode://telescope" animated:NO];
    }else if([signal is:MainBoard.CONFIG]){
        [self.router open:@"icode://config" animated:NO];
    }
}


- (void)buttonSelected:(UIButton*)button{
    int index=button.tag-1000;
    switch (index) {
        case 0:
            [self sendUISignal:MainBoard.PLANETLIST];
            break;
        case 1:
            [self sendUISignal:MainBoard.TELESCOPE];
            break;
        case 2:
            [self sendUISignal:MainBoard.CONFIG];
            break;
        default:
            break;
    }
}

@end
