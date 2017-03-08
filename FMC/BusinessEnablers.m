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
#import "CollectionReusableView.h"
#import "SVProgressHUD.h"


@interface BusinessEnablers ()
{
    int pageNumber;
    NSMutableArray *responseArray;
    NSMutableDictionary *dic;
    NSMutableDictionary *subdic;
    NSMutableDictionary *postdic;
    NSUInteger myCount;
    int lastpage;

}

@property(nonatomic,retain)UICollectionView*collectionView;
@end

@implementation BusinessEnablers

- (void)viewDidLoad {
    [super viewDidLoad];
      [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"Business Enablers";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
  pageNumber=1;
    self.view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.headerReferenceSize = CGSizeMake(0, 20);
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
         subdic=[arr objectAtIndex:indexPath.row];
    CGFloat width = 150;
    CGFloat height1=150;
        //(CGRectGetWidth(cell.frame)-width)/2
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(cell.frame)-width)/2, 15, width, height1)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"partner_logo"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
     imageView.layer.cornerRadius = width/2;
        imageView.backgroundColor=[UIColor blueColor];
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
    }
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewId" forIndexPath:indexPath];
        if(responseArray)
        {
            dic=[responseArray objectAtIndex:indexPath.section];
        UILabel *lable = [[UILabel alloc] init];
        lable.text=[dic valueForKey:@"category_name"];
        CGFloat width = 80;
        CGFloat height=20;
        
        lable.frame = CGRectMake(10,0, width, height);
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [headerView addSubview:lable];
        
  //      CGFloat leftPadding  = 20;
//        UIImageView *nameimage = [[UIImageView alloc] initWithFrame:CGRectMake(leftPadding, CGRectGetMaxY(imageView.frame), self.view.frame.size.width - 2*leftPadding, 40)];
//        nameimage.image=[UIImage imageNamed:@"profilelabel"];
//        [headerView addSubview:nameimage];
        }
        
        return headerView;
    }
    return nil;
}


- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 30, 30); // top, left, bottom, right
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
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([postdic objectForKey:@"knowledge_partner_details"])
    {
        if (!lastpage)
        {
            if (indexPath.row ==  responseArray.count-4) {
                NSLog(@"load more");
                pageNumber++;
                NSLog(@"page no:%d",pageNumber);
                [self BusinessEnablersServercall];
            }
        }
        else if(indexPath.section==myCount )
        {
            [self.view makeToast:@"No more data" duration:1.0 position:@"bottom"];
            
        }
    }
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
         {//knowledge_partner_details
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 if([result objectForKey:@"knowledge_partner_details"])
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
-(void)sucesstask
{
    if(!responseArray)
    {
        responseArray=[[postdic objectForKey:@"knowledge_partner_details"] mutableCopy];
    }
    else{
        if ([postdic objectForKey:@"knowledge_partner_details"]) {
            
            NSMutableArray *arry=[[NSMutableArray alloc]init];
            arry=[[postdic objectForKey:@"knowledge_partner_details"] mutableCopy];
            [(NSMutableArray *)responseArray addObjectsFromArray:arry]  ;
        }
    }
    [_collectionView reloadData];
    [SVProgressHUD dismiss];
}
@end
