//
//  TelescopeBoard.m
//  iCode
//
//  Created by hjx on 2014-04-12.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "TelescopeBoard.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ConfigBoard.h"
#import <CoreMotion/CoreMotion.h>
#import "TrackView.h"
#import "ServiceLocation.h"
#import "PlanetTrackBoard.h"
@interface TelescopeBoard ()

@property (nonatomic,strong) NSMutableArray *capturedImages;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;

@property (nonatomic,strong) TrackView *overlayView;

@property (nonatomic,strong) CMMotionManager *motionManager;

@property (nonatomic,strong) ServiceLocation *serviceLocation;

@property (nonatomic,strong) PlanetTrackBoard *trackBoard;

@end

@implementation TelescopeBoard


- (void)dealloc{
    [_capturedImages release];
    [_overlayView release];
    [_imagePickerController release];
    [_motionManager release];
    [_serviceLocation release];
    [_trackBoard release];
    [super dealloc];
}


- (void)showMessage:(NSString*)message{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Info" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}



/**
 *  add Track view
 *
 *  @param frame camara frame
 */
- (void)loadOverlayViewWithFrame:(CGRect)frame{
    self.overlayView=[[[TrackView alloc] initWithFrame:frame] autorelease];
    self.overlayView.alpha=0.5;
}



/**
 *  open track direction
 */
- (void)startTrackDirection{
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        [self.overlayView setText:[NSString stringWithFormat:@"旋转角度:X:%.3f,Y:%.3f,X:%.3f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z]];
    }];
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [self.overlayView setAccText:[NSString stringWithFormat:@"加速计:X:%.3f,Y:%.3f,Z:%.3f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z]];
    }];
}


/**
 *  stop track direction
 */
- (void)stopTrackDirection{
    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopGyroUpdates];
}



- (void)initMotionManager{
    CMMotionManager *manager=[[CMMotionManager alloc]init];
    self.motionManager=manager;
    self.motionManager.gyroUpdateInterval=0.1;
    self.motionManager.accelerometerUpdateInterval=0.1;
    [manager release];
}



- (void)showCamara:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle=UIModalPresentationCurrentContext;
    imagePickerController.sourceType =sourceType;
    imagePickerController.delegate = self;
    if (sourceType == UIImagePickerControllerSourceTypeCamera){
        imagePickerController.showsCameraControls = NO;
        [self loadOverlayViewWithFrame:imagePickerController.cameraOverlayView.frame];
        imagePickerController.cameraOverlayView = self.overlayView;
    }
    self.imagePickerController = imagePickerController;
    [imagePickerController release];
    [self.view addSubview:self.imagePickerController.view];
}


- (void)handleUISignal:(BeeUISignal *)signal{
    [super handleUISignal:signal];
    if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
        self.title=@"Telescope";
        self.capturedImages = [[NSMutableArray alloc] init];
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self showMessage:@"sorry, no camera or camera is unavailable!!!"];
        }else{
            NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            BOOL canTakePicture = NO;
            for (NSString* mediaType in availableMediaTypes) {
                if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
                    canTakePicture = YES;
                    break;
                }
            }
            if (!canTakePicture) {
                [self showMessage:@"sorry, taking picture is not supported."];
                return;
            }
            [self initMotionManager];
            self.serviceLocation=[[[ServiceLocation alloc] init] autorelease];
            self.serviceLocation.whenUpdate=^(void){
                [self.overlayView setGpsText:[NSString stringWithFormat:@"descri:%@",[self.serviceLocation.location description]]];
            };
            [self showCamara:UIImagePickerControllerSourceTypeCamera];
            self.trackBoard=[[PlanetTrackBoard new] autorelease];
            self.trackBoard.view.frame=self.overlayView.frame;
            [self.overlayView addSubview:self.trackBoard.view];
            
        }
    }else if([signal is:BeeUIBoard.WILL_APPEAR]){
        if (self.imagePickerController&&![self.imagePickerController.view superview]) {
            [self.view addSubview:self.imagePickerController.view];
        }
        [self startTrackDirection];
        [self.serviceLocation powerOn];
    }else if([signal is:BeeUIBoard.DID_DISAPPEAR]){
        if (self.imagePickerController&&[self.imagePickerController.view superview]) {
            [self.imagePickerController.view removeFromSuperview];
        }
        [self stopTrackDirection];
        [self.serviceLocation powerOff];
    }
}


@end
