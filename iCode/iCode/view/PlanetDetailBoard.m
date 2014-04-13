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
