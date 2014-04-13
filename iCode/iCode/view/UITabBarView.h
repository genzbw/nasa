//
//  UITabBar.h
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITabBarViewDelegate <NSObject>

- (void)buttonSelected:(UIButton*)button;

@end


@interface UITabBarView : UIView


@property (nonatomic,assign) id<UITabBarViewDelegate> delegate;

@end
