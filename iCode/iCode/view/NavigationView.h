//
//  NavigationView.h
//  iCode
//
//  Created by hjx on 2014-04-13.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NavigationViewProtocol <NSObject>

- (void)back:(id)navi;

@end

@interface NavigationView : UIView

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,assign) id<NavigationViewProtocol> delegate;


- (id)initWithTitle:(NSString*)title;


- (void)setTitle:(NSString*)title;


- (id)initWithBack;

@end
