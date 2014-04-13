//
//  MainBoard.h
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"
#import "UITabBarView.h"

@interface MainBoard : BaseBoard<UITabBarViewDelegate>


@property (nonatomic,assign) BeeUIRouter *router;

AS_SINGLETON(MainBoard)

AS_SIGNAL(PLANETLIST)

AS_SIGNAL(TELESCOPE)

AS_SIGNAL(CONFIG)


@end
