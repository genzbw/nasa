//
//  MainBoard.h
//  iCode
//
//  Created by hjx on 2014-04-07.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "BaseBoard.h"

@interface MainBoard : BaseBoard<UITabBarDelegate>


@property (nonatomic,assign) BeeUIRouter *router;

AS_SINGLETON(MainBoard)

AS_SIGNAL(PIC)

AS_SIGNAL(MESSAGE)

AS_SIGNAL(FREEDOM)

AS_SIGNAL(CONFIG)


@end
