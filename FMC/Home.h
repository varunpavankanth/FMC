//
//  Home.h
//  FMC
//
//  Created by Nennu on 09/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "TableViewCell.h"
@interface Home : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NSURLSessionDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,UIDocumentInteractionControllerDelegate>
{
    TableViewCell *customCell;
    NSArray *array;
    UILabel *labelText;
    UIImage *profielimage;
    UIButton *camerbut;
}
@property (nonatomic, strong) NSArray *dataSource;
@property(nonatomic,strong) NSMutableArray* images;
@property(nonatomic,strong) NSMutableArray* label1;
@property(nonatomic,strong) NSMutableArray* label2;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)UITextField *Statustextfield;
@property(nonatomic,strong)UIDocumentInteractionController *documentInteractionController;
@end
