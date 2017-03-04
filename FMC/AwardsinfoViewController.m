//
//  AwardsinfoViewController.m
//  FMC
//
//  Created by Vinod Kumar on 17/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "AwardsinfoViewController.h"

@interface AwardsinfoViewController ()

@end

@implementation AwardsinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images=[[NSMutableArray alloc]initWithObjects:@"cric.jpeg",@"cric.jpeg",@"cric.jpeg",@"cric.jpeg",@"cric.jpeg",@"cric.jpeg", nil];
    self.label1=[[NSMutableArray alloc]initWithObjects:@"Vinod",@"Varun",@"Karthik",@"Gaythri",@"Appu",@"Mounika", nil];
    self.label2=[[NSMutableArray alloc]initWithObjects:@"Versatile",@"Versatile",@"Versatile",@"Versatile",@"Versatile",@"Versatile", nil];
    // Do any additional setup after loading the view.
    UITableView*tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    tv.backgroundColor=[UIColor whiteColor];
    tv.delegate=self;
    tv.dataSource=self;
    [self.view addSubview:tv];

    // Do any additional setup after loading the view.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.images count];}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    //[cell.layer setBorderWidth:2.0];
    [cell.layer setCornerRadius:5.0f];
    [cell.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    NSString *str1=[NSString stringWithFormat:@"%@",[_label1 objectAtIndex:indexPath.section]];
    NSString *str2=[NSString stringWithFormat:@"%@",[_label2 objectAtIndex:indexPath.section]];
    NSString *apd=[NSString stringWithFormat:@"%@\n%@",str1,str2];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:apd attributes:nil];
    // UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, tableView.rowHeight)];
    // bg.backgroundColor=[UIColor grayColor];
    cell.layer.cornerRadius=7.0f;
    cell.layer.borderWidth=1.0f;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor=[UIColor grayColor].CGColor;
    // cell.imageView.image=[UIImage imageNamed:[_images objectAtIndex:indexPath.row]];
    //w=cell.imageView.frame.size.width;
    // h=cell.imageView.frame.size.height;
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(5 , 5, 50,50)];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+5,5, cell.frame.size.width,  50)];
    lable.attributedText=attributedText;
    // lable.backgroundColor=[UIColor blueColor];
    lable.numberOfLines=0;
    imgv.image=[UIImage imageNamed:[_images objectAtIndex:indexPath.section]];
    imgv.layer.cornerRadius = 25.0f;
    imgv.clipsToBounds = YES;
    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,cell.frame.size.height,cell.frame.size.width,3)];
    additionalSeparator.backgroundColor = [UIColor grayColor];
    //  [cell addSubview:additionalSeparator];
    // cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 30);
    [cell addSubview:lable];
    [cell addSubview:imgv];
    //  [cell addSubview:bg];
    //    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
    //       cell.imageView.layer.borderWidth = 2.0f;
    //        cell.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    //        cell.imageView.clipsToBounds = YES;
    
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
