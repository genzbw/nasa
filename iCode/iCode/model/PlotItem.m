//
//  PlotItem.m
//  CorePlotGallery
//
//  Created by Jeff Buck on 9/4/10.
//  Copyright 2010 Jeff Buck. All rights reserved.
//

#import "PlotItem.h"
@interface PlotItem ()

@end

@implementation PlotItem


- (id)init{
    if (self=[super init]) {
        self.graphs=[NSMutableArray array];
    }
    return self;
}

- (void)dealloc{
    [_graphs release];
    [_defaultLayerHostingView release];
    [super dealloc];
}


-(void)killGraph{
    [[CPTAnimation sharedInstance] removeAllAnimationOperations];
    // Remove the CPTLayerHostingView
    if ( _defaultLayerHostingView ) {
        [_defaultLayerHostingView removeFromSuperview];
        _defaultLayerHostingView.hostedGraph = nil;
        [_defaultLayerHostingView release];
        _defaultLayerHostingView = nil;
    }
    [self.graphs removeAllObjects];
}

// override to generate data for the plot if needed
-(void)generateData{

}



-(void)applyTheme:(CPTTheme *)theme toGraph:(CPTGraph *)graph withDefault:(CPTTheme *)defaultTheme{
    if ( theme == nil ) {
        [graph applyTheme:defaultTheme];
    }else if ( ![theme isKindOfClass:[NSNull class]] ) {
        [graph applyTheme:theme];
    }
}


-(void)renderInView:(UIView *)hostingView withTheme:(CPTTheme *)theme animated:(BOOL)animated{
    _defaultLayerHostingView = [[CPTGraphHostingView alloc] initWithFrame:hostingView.bounds];
    _defaultLayerHostingView.collapsesLayers = NO;
    [_defaultLayerHostingView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_defaultLayerHostingView setAutoresizesSubviews:YES];

    [hostingView addSubview:_defaultLayerHostingView];
    [self generateData];
    [self renderInLayer:_defaultLayerHostingView withTheme:theme animated:animated];
}


-(void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme animated:(BOOL)animated{
    NSLog(@"PlotItem:renderInLayer: Override me");
}


-(void)reloadData{
   
}


-(void)addGraph:(CPTGraph *)graph{
    
}


-(void)addGraph:(CPTGraph *)graph toHostingView:(CPTGraphHostingView *)layerHostingView{
    [self.graphs addObject:graph];
    if (layerHostingView){
        layerHostingView.hostedGraph = graph;
    }
}

@end
