//
//  PlanetDetailBoard.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PlanetDetailBoard.h"
#import "BasePlanet.h"

@interface PlanetDetailBoard ()

@property (nonatomic,strong) BasePlanet *planet;

@end

@implementation PlanetDetailBoard

- (void)dealloc{
    [_planet release];
    [super dealloc];
}

- (void)load{
    [super load];
    self.needBack=YES;
}

- (id)initWithPlanet:(BasePlanet*)planet{
    if (self=[super init]) {
        self.planet=planet;
    }
    return self;
}


- (void)finishRead{
    [self.delegate modalViewControllerShouldClose:self];
}

- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=self.planet.target_body_name;
        [self.view setBackgroundColor:[UIColor blackColor]];
        
        NSDictionary *dict=[self.planet JSON];
        CGFloat x=20.0;
        CGFloat y=65.0;
        CGFloat width=self.width-2*20;
        CGFloat height=30;
        for (NSString *key in dict.allKeys) {
            NSString *value=[dict objectForKey:key];
            UILabel *keyLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, width/2, height)];
            keyLabel.font=[UIFont systemFontOfSize:16];
            keyLabel.textColor=RGB(118, 118, 118);
            [keyLabel setTextAlignment:NSTextAlignmentLeft];
            [keyLabel setText:[NSString stringWithFormat:@"%@:",key]];
            [self.view addSubview:keyLabel];
            [keyLabel release];
            UILabel *valueLabel=[[UILabel alloc] initWithFrame:CGRectMake(x+width/2, y, width/2, height)];
            valueLabel.font=[UIFont systemFontOfSize:16];
            valueLabel.textColor=RGB(118, 118, 118);
            [valueLabel setTextAlignment:NSTextAlignmentRight];
            [valueLabel setText:[NSString stringWithFormat:@"%@:",value]];
            [self.view addSubview:valueLabel];
            [valueLabel release];
            y+=height;
        }
        
        UILabel *helloLabel=[[UILabel alloc] initWithFrame:self.viewBound];
        helloLabel.top=44;
        [self.view addSubview:helloLabel];
        [helloLabel setFont:[UIFont systemFontOfSize:12]];
        [helloLabel setTextColor:[UIColor blackColor]];
        [helloLabel setText:[self.planet JSONString]];
        [helloLabel sizeToFit];
        [helloLabel release];
    }
}


- (void)back:(id)navi{
    [[[BeeUIRouter sharedInstance]  currentStack] popBoardAnimated:YES];
}

@end
