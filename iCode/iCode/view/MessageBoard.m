//
//  MessageBoard.m
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "MessageBoard.h"

@interface MessageBoard ()

@end

@implementation MessageBoard

- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"message";
    }else if([signal is:BeeUIBoard.LAYOUT_VIEWS]){
        
    }
}
@end
