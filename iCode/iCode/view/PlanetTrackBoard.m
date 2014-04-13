//
//  PlanetTrackBoard.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "PlanetTrackBoard.h"
#import "RealTimePlot.h"

@interface PlanetTrackBoard ()

@property (nonatomic,strong) PlotItem *plotItem;

@end

@implementation PlanetTrackBoard

- (void)dealloc{
    [_plotItem release];
    [super dealloc];
}

- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        RealTimePlot *plot=[RealTimePlot new];
        self.plotItem=plot;
        [plot renderInView:self.view withTheme:[CPTTheme themeNamed:@"kThemeTableViewControllerNoTheme"] animated:YES];
        [plot release];
    }
}

@end
