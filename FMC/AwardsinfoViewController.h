//
//  AwardsinfoViewController.h
//  FMC
//
//  Created by Vinod Kumar on 17/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"
#import "SWRevealViewController.h"
@interface AwardsinfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray* images;
@property NSMutableArray* label1;
@property NSMutableArray* label2;
@property UITableView * tv;


@end
