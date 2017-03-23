//
//  GalleryCollectionViewController.m
//  FMC
//
//  Created by Vinod Kumar on 15/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "GalleryCollectionViewController.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "UIImageView+WebCache.h"
#import "APIDataFetcher.h"
#import "photoZoom.h"
#import "SVProgressHUD.h"
#define padding 2
@interface GalleryCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    int pageNumber;
    NSMutableArray *responseArray;
    NSMutableDictionary *dic;
}

@property(nonatomic,retain)UICollectionView*collectionView;

@property(nonatomic,retain)NSArray*imagesNameArray;


@end

@implementation GalleryCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 2;
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
    [self.view addSubview:_collectionView];
      pageNumber=1;
    [self PhotoAlbamServercall];
  
    
    
    
}

// Do any additional setup after loading the view, typically from a nib.



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return responseArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // NSDictionary *dict = [_titleArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifer" forIndexPath:indexPath];
    //cell.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (responseArray) {
        dic=[responseArray objectAtIndex:indexPath.row];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"image_path"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
       [cell.contentView addSubview:imageView];
    
    } //CGFloat height = 30;
    
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake((self.view.frame.size.width-20)/3, self.view.frame.size.width/3);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    photoZoom *pt=[[photoZoom alloc]init];
    if (responseArray) {
         [SVProgressHUD dismiss];
        dic=[responseArray objectAtIndex:indexPath.row];
        pt.imageUrl=[NSURL URLWithString:[dic valueForKey:@"image_path"]];
        pt.title=[dic valueForKey:@"image_title"];
    }
     [self.navigationController pushViewController:pt animated:YES];
}
/*ServerCall*/
-(void)PhotoAlbamServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
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
        [self presentViewController:alertController animated:YES completion:nil];    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/photogallery/%@/%d",_album_ID,pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 [SVProgressHUD dismiss];
                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"gallery_details"];
                 ////                 for (NSDictionary * resultDict in resultsArrayfromJSON)
                 ////                 {
                 ////                     responseArray [resultDict ]
                 //                 }
                 [_collectionView reloadData];
                 //
             }
             
         }:^(NSError *error)
         
         {
             if (error)
             {
                 NSLog(@"%@", error.localizedDescription);
                [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
             }
             
             
         }];
        
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}

@end
