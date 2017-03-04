//
//  Awards.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//
#define padding 5
#import "Awards.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"


#import "AwardsinforViewController.h"

@interface Awards ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int pageNumber;
    NSDictionary *dic;
    NSMutableArray *responseArray;
}


@property(nonatomic,retain)UICollectionView*collectionView;

@property(nonatomic,retain)NSArray*imagesNameArray;
@property(nonatomic,retain)NSArray*titleArray;

@end

@implementation Awards

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber =1;
    [self AwardsServercall
];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"Awards";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClicked:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClicked:)];
    
    
    
    
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
    // NSDictionary *dict = [_titleArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifer" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (responseArray) {
        dic=[responseArray objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame),CGRectGetWidth(cell.frame)/1.43)];
    imageView.image = [UIImage imageNamed:@"awards.jpeg"];
    [cell.contentView addSubview:imageView];
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinX(imageView.frame)+cell.frame.size.height-20, CGRectGetWidth(cell.frame),20);
    [button setBackgroundImage:[UIImage imageNamed:@"labelImage"] forState:UIControlStateNormal];
    [button setTitle:[dic valueForKey:@"year"] forState:UIControlStateNormal];

    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.titleLabel.numberOfLines=0;
    [button setTintColor:[UIColor whiteColor]];
    [cell.contentView addSubview:button];
    cell.layer.cornerRadius = 7.0;
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    }
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 15, 0,15); // top, left, bottom, right
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10; // This is the minimum inter item spacing, can be more
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake((self.view.frame.size.width-40)/2, 120);
   // return CGSizeMake(10, 160);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    AwardsinforViewController*VC=[[AwardsinforViewController alloc]init];
    if (responseArray) {
        dic=[responseArray objectAtIndex:indexPath.row];
        VC.title=[dic valueForKey:@"year"];
         VC.Year=[dic valueForKey:@"year"];

    
    [self.navigationController pushViewController:VC animated:YES];
    
}
}
-(void)AwardsServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/awardyears/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"award_years"];
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
             }
             
             
         }];
        
    }
}

@end
