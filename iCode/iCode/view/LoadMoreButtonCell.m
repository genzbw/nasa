//
//  LoadMoreButtonCell.m
//  iCode
//
//  Created by hjx on 2014-04-11.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "LoadMoreButtonCell.h"

@implementation LoadMoreButtonCell

- (void)dealloc{
    [_message release];
    [super dealloc];
}

- (void)loadView{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(callMessage) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:button];
    BeeUIActivityIndicatorView *indicatorView=[[BeeUIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [button addSubview:indicatorView];
    [indicatorView release];
}


- (void)callMessage{
    self.MSG(self.message);
}


@end
