//
//  Gallery.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Gallery.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
#import "UIImageView+WebCache.h"
#import "GalleryCollectionViewController.h"
#define padding 5

@interface Gallery ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int pageNumber;
    NSDictionary *dic;
    NSMutableArray *responseArray;
}


@property(nonatomic,retain)UICollectionView*collectionView;

@property(nonatomic,retain)NSArray*imagesNameArray;
@property(nonatomic,retain)NSArray*titleArray;
@end


@implementation Gallery

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber =1;
    [self PhotoAlbamServercall];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"Gallery";
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
        
        
  [imageView sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"album_image_path"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
    [cell.contentView addSubview:imageView];
    
    CGFloat height = 30;
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeSystem];
    
    button.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) - height, CGRectGetWidth(cell.frame), height);
    [button setBackgroundImage:[UIImage imageNamed:@"labelImage"] forState:UIControlStateNormal];
    [button setTitle:[self stringWithSentenceCapitalization:[dic valueForKey:@"album_name"]] forState:UIControlStateNormal];
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

-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
    
    // Get the first character in the string and capitalize it.
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    
    NSMutableString * temp = [str mutableCopy];
    
    // Replace the first character with the capitalized version.
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
   GalleryCollectionViewController*VC=[[GalleryCollectionViewController alloc]init];
    
    if (responseArray) {
        dic=[responseArray objectAtIndex:indexPath.row];
        VC.title=[self stringWithSentenceCapitalization:[dic valueForKey:@"album_name"]];
        VC.album_ID=[dic valueForKey:@"photo_album_id"] ;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

/*serverCall*/

-(void)PhotoAlbamServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/photoalbums/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
            
             if ([result isKindOfClass:[NSDictionary class]])
                          {
                        responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"album_details"];
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
