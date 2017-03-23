//
//  CSRViewController.m
//  FMC
//
//  Created by Vinod Kumar on 28/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "CSRViewController.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
#import "UIImageView+WebCache.h"
#import "CSRcellViewController.h"
#import "SVProgressHUD.h"
#define padding 5

@interface CSRViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int pageNumber;
    NSUInteger myCount;
    int lastpage;
    NSDictionary *dic;
    NSMutableArray *responseArray;
    NSMutableDictionary *postdic;;
}


@property(nonatomic,retain)UICollectionView*collectionView;

@property(nonatomic,retain)NSArray*imagesNameArray;
@property(nonatomic,retain)NSArray*titleArray;

@end

@implementation CSRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber =1;
    [SVProgressHUD show];
    [self PhotoAlbamServercall];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"CSR";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    CGRect frame = self.view.frame;
    frame.origin.x = padding;
    frame.size.width -= 2*padding;
    frame.size.height -= 2*padding;
    frame.origin.y = padding;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = YES;
    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifer"];
    //[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewId"];
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return responseArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifer" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (responseArray) {
        dic=[responseArray objectAtIndex:indexPath.row];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame))];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"category_image_path"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
        [cell.contentView addSubview:imageView];
        
        CGFloat height = 30;
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeSystem];
        
        button.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) - height, CGRectGetWidth(cell.frame), height);
        [button setBackgroundImage:[UIImage imageNamed:@"labelImage"] forState:UIControlStateNormal];
        [button setTitle:[self stringWithSentenceCapitalization:[dic valueForKey:@"category_name"]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        button.titleLabel.numberOfLines=0;
        [button setTintColor:[UIColor whiteColor]];
        [cell.contentView addSubview:button];
    }
    
    return cell;
}
//- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0,0); // top, left, bottom, right
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake((self.view.frame.size.width-30)/3, (self.view.frame.size.width)/3);
    //  return  CGSizeMake((self.view.frame.size.width-6)/2, 160);
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    CSRcellViewController*VC=[[CSRcellViewController alloc]init];
    
    if (responseArray) {
        dic=[responseArray objectAtIndex:indexPath.row];
        VC.title=[self stringWithSentenceCapitalization:[dic valueForKey:@"category_name"]];
        VC.category_ID=[dic valueForKey:@"csr_category_id"] ;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
    
    // Get the first character in the string and capitalize it.
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    
    NSMutableString * temp = [str mutableCopy];
    
    // Replace the first character with the capitalized version.
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp ;
}
/*serverCall*/

-(void)PhotoAlbamServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
       // [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
        [SVProgressHUD dismiss];
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@"No internet"  message:@"This feature requires internet connection.please check your internet settings and try again"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/csrcategory/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 //csr_category
                 if([result objectForKey:@"csr_category"])
                 {
                     postdic=result;
                     [self sucesstask];
                     
                 }
                 else
                 {
                     NSLog(@"nolonger data present ");
                     NSLog(@"last page no:%d",pageNumber);
                     lastpage=pageNumber;
                     pageNumber=1;
                     myCount = [responseArray count];
                 }
             }
             else{
                 NSLog(@"data got nil");
                   [SVProgressHUD dismiss];
                 [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];

             }
             
    
         }:^(NSError *error)
         
         {
             if (error)
             {
                 NSLog(@"%@", error.localizedDescription);
             }
             
             
         }];
        
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([postdic objectForKey:@"csr_category"])
    {
        if (!lastpage)
        {
            if (indexPath.row ==  6) {
                NSLog(@"load more");
                pageNumber++;
                NSLog(@"page no:%d",pageNumber);
                [self PhotoAlbamServercall];
            }
        }
        else if(indexPath.section==myCount )
        {
            [self.view makeToast:@"No more data" duration:1.0 position:@"bottom"];
            
        }
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}

-(void)sucesstask{
    if(!responseArray)
    {
        responseArray=[[postdic objectForKey:@"csr_category"] mutableCopy];
    }
    else{
        if ([postdic objectForKey:@"csr_category"]) {
            
            NSMutableArray *arry=[[NSMutableArray alloc]init];
            arry=[[postdic objectForKey:@"csr_category"] mutableCopy];
            [(NSMutableArray *)responseArray addObjectsFromArray:arry]  ;
        }
    }
    [_collectionView reloadData];
    [SVProgressHUD dismiss];
}

@end
