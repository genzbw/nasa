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
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _contentLabel=[[UILabel alloc] initWithFrame:self.bounds];
        [_contentLabel setFont:[UIFont systemFontOfSize:12]];
        [_contentLabel setTextAlignment:NSTextAlignmentJustified];
        [self addSubview:_contentLabel];
    }
    return self;
}

- (void)setText:(NSString *)text{
    [self.contentLabel setText:text];
}

@end
