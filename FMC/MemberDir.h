//
//  MemberDir.h
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"
#import "SWRevealViewController.h"
@interface MemberDir : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UISearchBar *searchBar;
}

@property NSMutableArray* images;
@property NSMutableArray* label1;
@property NSMutableArray* label2;
@property UITableView * tv;
@end
