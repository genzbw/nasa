//
//  ImageDetailBoard.m
//  iCode
//
//  Created by hjx on 2014-04-09.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "ImageDetailBoard.h"

@interface ImageDetailBoard ()

@property (nonatomic,strong) Photo *photo;

@property (nonatomic,strong) BeeUIImageView *imageView;

@end

@implementation ImageDetailBoard


- (void)dealloc{
    [_photo release];
    [super dealloc];
}


- (id)initWithPhoto:(Photo*)photo{
    if (self=[super init]) {
        self.photo=photo;
        self.title=self.photo.title;
    }
    return self;
}



- (void)handleUISignal:(BeeUISignal *)signal{
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        _imageView=[[BeeUIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_imageView setUrl:self.photo.url];
        [self.view addSubview:_imageView];
    }
}

@end
