//
//  TrackView.h
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackView : UIView


@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UILabel *gpsLabel;

@property (nonatomic,strong) UILabel *accessLabel;

- (void)setText:(NSString *)text;

- (void)setGpsText:(NSString*)gpsText;

- (void)setAccText:(NSString*)accText;


@end
