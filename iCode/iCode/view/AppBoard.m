//
//  AppBoard.m
//  iCode
//
//  Created by hjx on 2014-04-02.
//  Copyright (c) 2014 gen. All rights reserved.
//

#import "AppBoard.h"
#import "OauthController.h"
#import "UserController.h"
#define authorizeUrl @"oauth/authorize"
#define oauthTokenKey @"oauth_token"
#define oauthVerifierKey @"oauth_verifier"
#define oauthTokenSecretKey @"oauth_token_secret"
#import "OauthParameter.h"
#import "RemoteUserInfo.h"
@interface AppBoard ()

@property (nonatomic, copy) NSString *requestToken;

@property (nonatomic, copy) NSString *requestTokenSecret;

@property (nonatomic, strong) BeeUIWebView *authorizeView;

@property (nonatomic, copy) NSString *oauthVerifier;

@end

@implementation AppBoard

DEF_SINGLETON(AppBoard)


- (void)dealloc{
    [self unobserveAllNotifications];
    [_requestToken release];
    [_requestTokenSecret release];
    [_oauthVerifier release];
    [_authorizeView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self observeNotification:BeeUIApplication.LAUNCHED];
}


- (void)handleUISignal:(BeeUISignal *)signal{
    if ([signal is:BeeUIBoard.WILL_APPEAR]) {
        if (![OauthCredentialStore sharedInstance].userInfo) {
            self.MSG(OauthController.GET_REQUEST_TOKEN);
        }
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)showAuthorizeView:(BOOL)show{
    if (_authorizeView) {
        [_authorizeView removeFromSuperview];
        [_authorizeView release];
        _authorizeView=nil;
    }
    if (show) {
        _authorizeView=[[BeeUIWebView alloc] initWithFrame:self.view.bounds];
        _authorizeView.delegate=self;
        [_authorizeView setUrl:[self getAuthorizeUrl]];
        [self.view addSubview:_authorizeView];
    }else{
        [_authorizeView removeFromSuperview];
        [_authorizeView release];
        _authorizeView=nil;
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

/**
 *
 *  @param oauthToken requestToken
 *
 *  @return verifier
 */
- (NSString*) getAuthorizeUrl{
    NSMutableString *str=[NSMutableString stringWithString:oauthBaseUrl];
    [str appendString:authorizeUrl];
    NSMutableArray *parameters=[NSMutableArray arrayWithCapacity:1];
    [parameters addObject:[OauthParameter OauthParameterWithName:oauthTokenKey value:self.requestToken]];
    [str appendFormat:@"?%@",[OauthParameter parameterStringForParameters:parameters]];
    return str;

}

- (void)handleMessage:(BeeMessage *)msg{
    [super handleMessage:msg];
    if ([msg is:OauthController.GET_REQUEST_TOKEN]) {
        if (msg.succeed) {
            NSArray *datas=msg.GET_OUTPUT(@"result");
            self.requestToken=[OauthParameter getParameter:datas byName:oauthTokenKey].value;
            self.requestTokenSecret=[OauthParameter getParameter:datas byName:oauthTokenSecretKey].value;
            [self showAuthorizeView:YES];
        }
    }else if ([msg is:OauthController.GET_ACCESS_TOKEN]){
        if (msg.succeed) {
            NSArray *datas=msg.GET_OUTPUT(@"result");
            RemoteUserInfo *userInfo=[RemoteUserInfo new];
            userInfo.userName=[OauthParameter getParameter:datas byName:@"username"].value;
            userInfo.fullName=[OauthParameter getParameter:datas byName:@"fullname"].value;
            userInfo.oauthToken=[OauthParameter getParameter:datas byName:@"oauth_token"].value;
            userInfo.oauthTokenSecret=[OauthParameter getParameter:datas byName:@"oauth_token_secret"].value;
            userInfo.userId=[[OauthParameter getParameter:datas byName:@"user_nsid"].value stringByRemovingPercentEncoding];
            [OauthCredentialStore sharedInstance].userInfo=userInfo;
            [userInfo release];
            self.MSG(UserController.USER_LOGIN);
            [BeeUserDefaults userDefaultsWrite:[NSKeyedArchiver archivedDataWithRootObject:userInfo] forKey:UserOauthInfoKey];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) handleNotification:(NSNotification *)notification{
    if ( [notification is:BeeUIApplication.LAUNCHED] ){
		NSDictionary *data=[notification object];
        NSURL *url=[data objectForKey:@"url"];
        if ([[url host] isEqualToString:@"success"] && [url query].length > 0) {
            NSArray *oauthParameters = [OauthParameter responseParameters:[url query]];
            self.oauthVerifier= [OauthParameter getParameter:oauthParameters byName:@"oauth_verifier"].value;
            [self showAuthorizeView:NO];
            self.MSG(OauthController.GET_ACCESS_TOKEN).INPUT(@"requestToken",self.requestToken).INPUT(@"requestTokenSecret",self.requestTokenSecret).INPUT(@"verifier",self.oauthVerifier);
        }
	}
}

@end
