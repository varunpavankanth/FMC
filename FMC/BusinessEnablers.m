//
//  BusinessEnablers.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//
#define padding 5
#import "BusinessEnablers.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
#import "UIImageView+WebCache.h"


@interface BusinessEnablers ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int pageNumber;
    NSMutableArray *responseArray;
    NSMutableDictionary *dic;
    NSMutableDictionary *subdic;
}

@property(nonatomic,retain)UICollectionView*collectionView;

@property(nonatomic,retain)NSArray*imagesNameArray;
@property(nonatomic,retain)NSArray*titleArray;



@end

@implementation BusinessEnablers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"Business Enablers";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
  
    // Do any additional setup after loading the view.
    _imagesNameArray=@[@"1.jpeg",@"2.jpeg",@"1.jpeg",@"2.jpeg",@"2.jpeg",@"2.jpeg"];
    
      pageNumber=1;
    _titleArray=@[@"pn3",@"pn2",];
    
    
    
    
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
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewId"];
    [self.view addSubview:_collectionView];
    [self BusinessEnablersServercall];
  
    
    
}




// Do any additional setup after loading the view, typically from a nib.



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return responseArray.count;;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(responseArray)
    {
        dic=[responseArray objectAtIndex:section];
        NSMutableArray *arr   =(NSMutableArray*)[(NSDictionary*)dic valueForKeyPath:@"partners"];
    return arr.count;
    }
    else
    {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // NSDictionary *dict = [_titleArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifer" forIndexPath:indexPath];
    //cell.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if(responseArray)
    {
        dic=[responseArray objectAtIndex:indexPath.section];
        
      NSMutableArray *arr   =(NSMutableArray*)[(NSDictionary*)dic valueForKeyPath:@"partners"];
//        for (int i=0; i<arr.count; i++) {
     
        subdic=[arr objectAtIndex:indexPath.row];
    CGFloat width = 150;
    CGFloat height1=150;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(cell.frame)-width)/2, 15, width, height1)];
        
   // imageView.image = [UIImage imageNamed:[subdic valueForKey:@"partner_logo"]];
      //  NSURL *url=[NSURL URLWithString:subdic[@"partner_logo"]] ;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"partner_logo"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
     imageView.layer.cornerRadius = 75.0f;
    [cell.contentView addSubview:imageView];
    CGFloat height = 30;
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetHeight(cell.frame) - height+5, 150, height+10);
    [button setBackgroundImage:[UIImage imageNamed:@"labelImage"] forState:UIControlStateNormal];
    [button setTitle:[self stringWithSentenceCapitalization:[subdic valueForKey:@"partner_name"]] forState:UIControlStateNormal];
     
          button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.titleLabel.numberOfLines=0;
    [button setTintColor:[UIColor whiteColor]];
    [cell.contentView addSubview:button];
//        }
    }
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 50, 30, 30); // top, left, bottom, right
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width=(self.view.frame.size.width-2 - 2*padding);
    NSLog(@"%f",width);
    return  CGSizeMake((self.view.frame.size.width)/3, 160);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
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

/*SERVER CALL*/
-(void)BusinessEnablersServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/knowledgepartners/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"knowledge_partner_details"];
                 
                 [self.collectionView reloadData];
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
