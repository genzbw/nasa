//
//  BaseTableViewCell.m
//  iCode
//
//  Created by hjx on 2014-04-11.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadView];
    }
    return self;
}


- (void)loadView{
    
}



+(CGFloat)CaculateBaseTableViewCellRowHeight:(id)rowData{
    return TableViewCellRowHeight;
}


- (void)setData:(id)data{
    if (_data!=data) {
        [_data release];
        _data=[data retain];
        [self layoutSubviews];
    }
}


- (void)dealloc{
    [_data release];
    [super dealloc];
}



@end
