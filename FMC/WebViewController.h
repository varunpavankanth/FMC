//
//  WebViewController.h
//  FMC
//
//  Created by Nennu on 20/03/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    UIWebView *Webview;
}
@property(nonatomic,strong)NSString *strg;

@end
