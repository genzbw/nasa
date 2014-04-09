//
//  FreedomBoard.m
//  iCode
//
//  Created by hjx on 2014-04-09.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "FreedomBoard.h"

@interface FreedomBoard ()

@end

@implementation FreedomBoard
- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"freedom";
    }else if([signal is:BeeUIBoard.LAYOUT_VIEWS]){
        
    }
}

@end
