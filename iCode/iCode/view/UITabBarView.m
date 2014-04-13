//
//  UITabBar.m
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "UITabBarView.h"
#define buttonTag 1000

@implementation UITabBarView


- (void)loadView{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.bounds];
    [imageView setBackgroundImage:[UIImage imageNamed:@"bottom.png"]];
    [imageView setUserInteractionEnabled:YES];
    [self addSubview:imageView];
    
    NSArray *pics=[NSArray arrayWithObjects:@"button_asteroid.png",@"button_telescope.png",@"button_setting.png", nil];
    UIButton *actionButton=nil;
    CGFloat x=0;
    CGFloat width=self.width/3;
    CGFloat height=85;
    for (int i=0; i<[pics count]; i++) {
        actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.frame=CGRectMake(x, 39, width, height);
        actionButton.tag=buttonTag+i;
        x+=width;
        [actionButton setBackgroundImage:[UIImage imageNamed:[pics objectAtIndex:i]] forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:actionButton];
    }
    [imageView release];
}


- (void)buttonSelected:(UIButton*)button{
    if (_delegate&&[_delegate respondsToSelector:@selector(buttonSelected:)]) {
        [_delegate buttonSelected:button];
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadView];
    }
    return self;
}
@end
