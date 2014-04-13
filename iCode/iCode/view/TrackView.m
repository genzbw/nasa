//
//  TrackView.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "TrackView.h"

@implementation TrackView

- (void)dealloc{
    [_contentLabel release];
    [_gpsLabel release];
    [_accessLabel release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat height=60;
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.width, height)];
        _contentLabel.numberOfLines=4;
        [_contentLabel setFont:[UIFont systemFontOfSize:20]];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        [_contentLabel setTextAlignment:NSTextAlignmentNatural];
        [self addSubview:_contentLabel];
        
        _gpsLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, _contentLabel.bottom+height, self.width, 90)];
        _gpsLabel.numberOfLines=4;
        [_gpsLabel setFont:[UIFont systemFontOfSize:15]];
        [_gpsLabel setTextColor:[UIColor whiteColor]];
        [_gpsLabel setTextAlignment:NSTextAlignmentNatural];
        [self addSubview:_gpsLabel];
        
        _accessLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, _gpsLabel.bottom+height, self.width, height)];
        _accessLabel.numberOfLines=4;
        [_accessLabel setFont:[UIFont systemFontOfSize:20]];
        [_accessLabel setTextColor:[UIColor whiteColor]];
        [_accessLabel setTextAlignment:NSTextAlignmentNatural];
        [self addSubview:_accessLabel];
    }
    return self;
}

- (void)setText:(NSString *)text{
    [self.contentLabel setText:text];
}


- (void)setGpsText:(NSString*)gpsText{
    [self.gpsLabel setText:gpsText];
}

- (void)setAccText:(NSString*)accText{
    [self.accessLabel setText:accText];
}

@end
