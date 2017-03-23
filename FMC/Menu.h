//
//  Menu.h
//  FMC
//
//  Created by Nennu on 09/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Welcome.h"
#import "History.h"
#import "MemberDir.h"
#import "BusinessEnablers.h"
#import "Awards.h"
#import "Gallery.h"
#import "Events.h"
#import "Edtorials.h"
#import "ContactUs.h"
#import "ChangePassword.h"
#import "ViewController.h"
#import "EditViewController.h"
#import "CSRViewController.h"

@interface Menu : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *itemslist;
    NSArray *imageslist;
    UITableViewCell *customCell;
    UITableView *tableview;
    UIImageView *imgv;
    UILabel *username;
}
@end
