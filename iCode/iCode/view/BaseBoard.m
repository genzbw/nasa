//
//  BaseBoard.m
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"

@interface BaseBoard ()

@end

@implementation BaseBoard


- (void)doMessageError:(NSError*)error{
    
}


- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        if (self.navigationController) {
            self.navigationBarShown=YES;
            [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
        }
    }
}

@end
