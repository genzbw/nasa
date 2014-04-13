//
//  BaseBoard.m
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"

@interface BaseBoard ()

@property (nonatomic,strong)NavigationView *naviView;

@end

@implementation BaseBoard


- (void)dealloc{
    [_naviView release];
    [super dealloc];
}


- (void)load{
    self.allowedLandscape=NO;
}




- (void)doMessageError:(NSError*)error{
    
}


- (void)back:(id)navi{
    
}

- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.navigationBarShown=NO;
        NavigationView *view=nil;
        if (self.navigationController||self.needBack) {
            if (self.needBack) {
                view=[[NavigationView alloc] initWithBack];
                view.delegate=self;
            }else{
                view=[[NavigationView alloc] initWithTitle:self.title];
            }
            self.naviView=view;
            [self.view addSubview:self.naviView];
            [view release];
        }
    }
}



- (void)setTitle:(NSString *)title{
    [self.naviView setTitle:title];
}
@end
