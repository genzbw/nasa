//
//  BaseBoard.h
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "NavigationView.h"

@interface BaseBoard : BeeUIBoard<NavigationViewProtocol>

@property (nonatomic,assign) BOOL needBack;

/**
 *  when message has errors,
 *  we need unify deal
 *  @param error
 */
- (void)doMessageError:(NSError*)error;

@end
