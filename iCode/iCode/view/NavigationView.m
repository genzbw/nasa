//
//  NavigationView.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView


- (void)dealloc{
    [_titleLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel=[[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.numberOfLines=1;
        [_titleLabel setTextColor:[UIColor blackColor]];
        _titleLabel.backgroundColor=[UIColor clearColor];
        self.backgroundColor=RGB(63, 63, 63);
        _titleLabel.lineBreakMode=UILineBreakModeTailTruncation;
        _titleLabel.font=[UIFont boldSystemFontOfSize:25];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title{
    if (self=[self initWithFrame:CGRectMake(0, 0,320,44)]) {
        [self.titleLabel setText:title];
    }
    return self;
}


- (id)initWithBack{
    if (self=[self initWithFrame:CGRectMake(0, 0,320,44)]) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeInfoDark];
        button.frame=CGRectMake(8.5, 8.5, 30, 30);
        [self addSubview:button];
        [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)back:(UIButton*)button{
    if (_delegate&&[_delegate respondsToSelector:@selector(back:)]) {
        [_delegate back:self];
    }
}



- (void)setTitle:(NSString*)title{
    [self.titleLabel setText:title];
}

@end
