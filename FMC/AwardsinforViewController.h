//
//  AwardsinforViewController.h
//  FMC
//
//  Created by Vinod Kumar on 17/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AwardsinforViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    UITableViewCell * cell1;
}
@property NSMutableArray* images;
@property NSMutableArray* label1;
@property NSMutableArray* label2;
@property UITableView * tv;
@property(strong,nonatomic)NSString *Year;

@end
