//
//  WebViewController.m
//  FMC
//
//  Created by Nennu on 20/03/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "WebViewController.h"
#import "SVProgressHUD.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
     Webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
    NSString *url=[NSString stringWithFormat:@"https://docs.google.com/viewerng/viewer?url=%@",self.strg];
    Webview.delegate=self;
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [Webview loadRequest:nsrequest];
//    UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc]
//                                     initWithTarget:self action:@selector(handlePinch:)];
//    pgr.delegate = self;
//    [Webview addGestureRecognizer:pgr];
    [self.view addSubview:Webview];
    // Do any additional setup after loading the view.
}
//- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
//{
//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//    recognizer.scale = 1;
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
