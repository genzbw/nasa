//
//  BaseTableViewCell.h
//  iCode
//
//  Created by hjx on 2014-04-11.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TableViewCellRowHeight 44;

@interface BaseTableViewCell : UITableViewCell


@property (nonatomic,strong) id data;//cell data



/**
 *  dynamic load view
 */
- (void)loadView;

/**
 *  caculate table cell row Height
 *  @param rowData
 */
+(CGFloat)CaculateBaseTableViewCellRowHeight:(id)rowData;

@end
