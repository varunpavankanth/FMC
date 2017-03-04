//
//  Events.h
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Home.h"
#import "Reachability.h"
#import "UIView+Toast.h"


@interface Events : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableViewCell * cell1;
    NSMutableDictionary *dic;
    NSError *error1;
    NSInteger *sectionid;
    NSDictionary * dict;
}
@property NSMutableArray* label1;
@property NSMutableArray* label2;
@property NSMutableArray * label1a;
@property UITableView * tv;
@property (nonatomic, strong) NSURLSession *urlSession;
-(void)eventServercall;



@end
